package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.dao.ChatbotDAO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class ChatbotController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SYSTEM_PROMPT = """
            Você é o assistente virtual da Livraria Online, um e-commerce de livros.
            Seja sempre simpático, objetivo e útil. Responda em português brasileiro.
            
            === CATÁLOGO E CATEGORIAS ===
            A livraria vende livros físicos organizados por categorias (ex: Literatura, Ficção Científica,
            Romance, Infantil, Técnicos, Autoajuda, História, etc.).
            Cada livro tem: título, autor, ISBN, preço, estoque disponível e categoria.
            Os clientes podem filtrar e buscar livros na página de catálogo (/view/livros.jsp).
            
            === FLUXO DE CADASTRO ===
            1. O cliente acessa a página de cadastro (/view/cadastro.jsp).
            2. Preenche: nome completo, e-mail (único), CPF (único, formato válido), senha,
               data de nascimento e telefone(s).
            3. Deve cadastrar ao menos um endereço (rua, número, complemento, bairro, cidade, estado, país, CEP).
            4. Após o cadastro, é redirecionado para o login.
            
            === FLUXO DE COMPRA ===
            1. O cliente navega no catálogo e clica em um livro para ver detalhes (/view/detalhe.jsp).
            2. Adiciona o livro ao carrinho (/view/carrinho.jsp). Pode alterar quantidades ou remover itens.
            3. Vai para o checkout (/view/checkout.jsp):
               a. Escolhe o endereço de entrega (cadastrados na conta).
               b. Aplica cupom de desconto (se tiver).
               c. Escolhe a forma de pagamento: cartão de crédito cadastrado na conta.
            4. Confirma o pedido — é gerado um Pedido com status inicial "Em processamento".
            5. Pode acompanhar os pedidos em /view/pedidos.jsp e ver detalhes em /view/pedido.jsp.
            
            === TROCA / DEVOLUÇÃO ===
            1. O cliente acessa um pedido entregue e solicita troca em /view/troca-solicitar.jsp.
            2. Informa o motivo e os itens a devolver.
            3. A solicitação fica com status "Aguardando aprovação" até o admin analisar.
            4. O admin gerencia devoluções em /view/admin-devolucoes.jsp.
            
            === ÁREA DO CLIENTE ===
            - Perfil e dados pessoais: /view/cliente.jsp
            - Endereços cadastrados: /view/enderecos.jsp
            - Cartões de crédito: /view/cartoes.jsp
            - Histórico de pedidos: /view/pedidos.jsp
            
            === REGRAS IMPORTANTES ===
            - CPF e e-mail são únicos por cliente.
            - É necessário ter ao menos um endereço para finalizar uma compra.
            - É necessário ter ao menos um cartão cadastrado para finalizar uma compra.
            - Cupons de desconto são aplicados no checkout e podem ter valor fixo ou percentual.
            - O estoque é verificado no momento da confirmação do pedido.
            
            === O QUE VOCÊ PODE AJUDAR ===
            - Explicar como se cadastrar, fazer login, ou recuperar conta.
            - Explicar o processo de compra passo a passo.
            - Tirar dúvidas sobre trocas e devoluções.
            - Orientar sobre como adicionar endereços e cartões.
            - Responder perguntas gerais sobre livros e categorias disponíveis.
            - Ajudar a entender o status de um pedido.
            - Recomendar livros do catálogo (quando tiver dados disponíveis).
            
            Não invente informações sobre livros específicos, preços exatos ou promoções que não foram
            mencionadas. Se não souber algo específico, diga que o cliente pode verificar direto no site
            ou entrar em contato com o suporte.
            
            === EVITE ===
            - Foque apenas em assuntos ligados a livraria.
            - Caso o usuário pergunte coisas não relacionadas a livraria, responda que não podde atender a esse assunto.
            """;

    // Retorna JSON: {"querLivros": true/false, "palavrasChave": ["..."]}
    private static final String INTENT_PROMPT = """
            Analise a mensagem do usuário e responda APENAS com um objeto JSON (sem markdown, sem explicações).
            
            Regras:
            - "querLivros" deve ser true se o usuário estiver pedindo recomendação, sugestão ou indicação de livros
              para qualquer ocasião, tema, gênero, pessoa ou finalidade.
            - "palavrasChave" deve ser uma lista de termos relevantes para buscar no catálogo
              (gênero, tema, categoria, autor, título, ocasião traduzida para categoria de livro).
              Deixe vazio [] se "querLivros" for false.
            
            Exemplos:
            {"querLivros": true, "palavrasChave": ["romance", "amor"]}
            {"querLivros": true, "palavrasChave": ["infantil", "criança"]}
            {"querLivros": false, "palavrasChave": []}
            
            Responda SOMENTE o JSON, nada mais.
            """;

    private final ChatbotDAO chatbotDAO = new ChatbotDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        StringBuilder jsonBuffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) jsonBuffer.append(line);
        }

        String jsonHistory = jsonBuffer.toString().trim();
        if (jsonHistory.isEmpty()) jsonHistory = "[]";

        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            out.print("{\"error\": \"Configuração de IA ausente no servidor.\"}");
            return;
        }

        String lastUserMessage = extractLastUserMessage(jsonHistory);

        try {
            String contextPath = request.getContextPath();

            // Detectar se o usuário quer recomendação de livros
            String livrosContexto = "";
            if (!lastUserMessage.isEmpty()) {
                String intentResponse = callGeminiSimples(apiKey, INTENT_PROMPT, lastUserMessage);
                boolean querLivros = parseBoolean(intentResponse, "querLivros");

                if (querLivros) {
                    List<String> palavras = parseStringArray(intentResponse, "palavrasChave");

                    // PASSO 2 — buscar livros em estoque via DAO
                    List<ChatbotDAO.LivroResumo> livros = chatbotDAO.buscarLivrosEmEstoque(palavras);
                    if (!livros.isEmpty()) {
                        livrosContexto = montarContextoLivros(livros, contextPath);
                    } else {
                        livrosContexto = "\n\n=== CATÁLOGO ===\n"
                                + "Nenhum livro em estoque encontrado para: "
                                + String.join(", ", palavras) + ".";
                    }
                }
            }

            // PASSO 3 — responder com histórico + contexto de livros (se houver)
            String systemFinal    = SYSTEM_PROMPT + livrosContexto;
            String geminiContents = convertToGeminiFormat(jsonHistory);
            String apiResponse    = callGeminiComHistorico(apiKey, systemFinal, geminiContents);

            out.print(apiResponse);

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"Erro ao processar a requisição no backend.\"}");
        }
    }

    //Monta o bloco de contexto injetado no system prompt
    private String montarContextoLivros(List<ChatbotDAO.LivroResumo> livros, String contextPath) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n\n=== LIVROS DISPONÍVEIS EM ESTOQUE (use APENAS estes para recomendar) ===\n\n");

        for (ChatbotDAO.LivroResumo l : livros) {
            String link = "http://localhost:8080" + contextPath + "/livro?id=" + l.id;
            sb.append("- \"").append(l.titulo).append("\"");
            if (l.autor != null && !l.autor.isBlank()) sb.append(" — ").append(l.autor);
            sb.append(" | Link: ").append(link).append("\n");
        }

        sb.append("""
                
                Instruções para recomendar:
                - Cite apenas livros da lista acima (todos estão em estoque).
                - Para cada livro recomendado, inclua o título, o autor e o link exato fornecido.
                - Formate cada livro assim: [Título](link) — Autor
                - Não invente títulos fora desta lista.
                """);

        return sb.toString();
    }

    //Chamada Gemini simples (detecção de intenção)
    private String callGeminiSimples(String apiKey, String systemPrompt, String userMessage) throws Exception {
        String body = "{"
                + "\"systemInstruction\":{\"parts\":[{\"text\":\"" + escapeJson(systemPrompt) + "\"}]},"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(userMessage) + "\"}]}]"
                + "}";
        return sendToGemini(apiKey, body);
    }

    //Chamada Gemini com histórico completo
    private String callGeminiComHistorico(String apiKey, String systemPrompt, String geminiContents) throws Exception {
        String body = "{"
                + "\"systemInstruction\":{\"parts\":[{\"text\":\"" + escapeJson(systemPrompt) + "\"}]},"
                + "\"contents\":" + geminiContents
                + "}";
        return sendToGemini(apiKey, body);
    }

    //HTTP para a API Gemini
    private String sendToGemini(String apiKey, String body) throws Exception {
        String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + apiKey;
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8))
                .build();
        HttpResponse<String> resp = client.send(req, HttpResponse.BodyHandlers.ofString());
        return resp.body();
    }

    //Extrai a última mensagem do usuário do histórico JSON
    private String extractLastUserMessage(String jsonHistory) {
        String trimmed = jsonHistory.trim();
        if (trimmed.equals("[]") || trimmed.isEmpty()) return "";

        int pos = trimmed.lastIndexOf("\"role\"");
        while (pos != -1) {
            int rColon    = trimmed.indexOf(':', pos);
            int rValStart = trimmed.indexOf('"', rColon + 1) + 1;
            int rValEnd   = trimmed.indexOf('"', rValStart);
            String role   = trimmed.substring(rValStart, rValEnd);

            if ("user".equals(role)) {
                int cPos      = trimmed.indexOf("\"content\"", pos);
                if (cPos == -1) break;
                int cColon    = trimmed.indexOf(':', cPos);
                int cValStart = trimmed.indexOf('"', cColon + 1) + 1;
                int cValEnd   = findEndOfJsonString(trimmed, cValStart);
                return unescapeJson(trimmed.substring(cValStart, cValEnd));
            }
            pos = trimmed.lastIndexOf("\"role\"", pos - 1);
        }
        return "";
    }

    //Parse de boolean no JSON da Gemini
    private boolean parseBoolean(String geminiResponse, String field) {
        try {
            String text = extractGeminiText(geminiResponse);
            text = text.replaceAll("```json|```", "").trim();
            int idx = text.indexOf("\"" + field + "\"");
            if (idx == -1) return false;
            String rest = text.substring(text.indexOf(':', idx) + 1).trim();
            return rest.startsWith("true");
        } catch (Exception e) {
            return false;
        }
    }

    //Parse de array de strings no JSON da Gemini
    private List<String> parseStringArray(String geminiResponse, String field) {
        List<String> list = new ArrayList<>();
        try {
            String text = extractGeminiText(geminiResponse);
            text = text.replaceAll("```json|```", "").trim();
            int idx      = text.indexOf("\"" + field + "\"");
            if (idx == -1) return list;
            int arrStart = text.indexOf('[', idx);
            int arrEnd   = text.indexOf(']', arrStart);
            if (arrStart == -1 || arrEnd == -1) return list;
            String arr   = text.substring(arrStart + 1, arrEnd);
            int i = 0;
            while (i < arr.length()) {
                int q1 = arr.indexOf('"', i);
                if (q1 == -1) break;
                int q2 = findEndOfJsonString(arr, q1 + 1);
                list.add(unescapeJson(arr.substring(q1 + 1, q2)));
                i = q2 + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Extrai o texto da resposta JSON da Gemini
    private String extractGeminiText(String geminiResponse) {
        int idx = geminiResponse.indexOf("\"text\"");
        if (idx == -1) return "";
        int colon    = geminiResponse.indexOf(':', idx);
        int valStart = geminiResponse.indexOf('"', colon + 1) + 1;
        int valEnd   = findEndOfJsonString(geminiResponse, valStart);
        return unescapeJson(geminiResponse.substring(valStart, valEnd));
    }

    //Converte [{role, content}] → [{role, parts:[{text}]}]
    private String convertToGeminiFormat(String jsonHistory) {
        String trimmed = jsonHistory.trim();
        if (trimmed.equals("[]") || trimmed.isEmpty()) return "[]";

        StringBuilder result = new StringBuilder("[");
        int i = 0;
        boolean first = true;

        while (i < trimmed.length()) {
            int start = trimmed.indexOf('{', i);
            if (start == -1) break;

            int roleStart = trimmed.indexOf("\"role\"", start);
            if (roleStart == -1) break;
            int rColon    = trimmed.indexOf(':', roleStart);
            int rValStart = trimmed.indexOf('"', rColon + 1) + 1;
            int rValEnd   = trimmed.indexOf('"', rValStart);
            String role   = trimmed.substring(rValStart, rValEnd);

            int cStart    = trimmed.indexOf("\"content\"", start);
            if (cStart == -1) break;
            int cColon    = trimmed.indexOf(':', cStart);
            int cValStart = trimmed.indexOf('"', cColon + 1) + 1;
            int cValEnd   = findEndOfJsonString(trimmed, cValStart);
            String content = unescapeJson(trimmed.substring(cValStart, cValEnd));

            if (!first) result.append(",");
            result.append("{\"role\":\"").append(escapeJson(role)).append("\",")
                    .append("\"parts\":[{\"text\":\"").append(escapeJson(content)).append("\"}]}");
            first = false;

            i = trimmed.indexOf('}', cValEnd) + 1;
            if (i == 0) break;
        }

        result.append("]");
        return result.toString();
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }

    private int findEndOfJsonString(String s, int start) {
        for (int i = start; i < s.length(); i++) {
            if (s.charAt(i) == '\\') i++;
            else if (s.charAt(i) == '"') return i;
        }
        return s.length();
    }

    private String unescapeJson(String s) {
        return s.replace("\\\"", "\"").replace("\\n", "\n")
                .replace("\\r", "\r").replace("\\t", "\t").replace("\\\\", "\\");
    }
}