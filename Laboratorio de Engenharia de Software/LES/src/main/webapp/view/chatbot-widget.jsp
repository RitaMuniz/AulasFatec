<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>
<link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/chatbot.css">

<button class="cb-fab" id="cbFab" aria-label="Abrir chat" title="Fale com nosso assistente">
    <svg class="cb-fab-icon cb-icon-chat" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
    </svg>
    <svg class="cb-fab-icon cb-icon-close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="display:none">
        <line x1="18" y1="6" x2="6" y2="18"/>
        <line x1="6" y1="6" x2="18" y2="18"/>
    </svg>
    <span class="cb-badge" id="cbBadge" style="display:none">1</span>
</button>

<div class="cb-window" id="cbWindow" aria-hidden="true">
    <div class="cb-header">
        <div class="cb-header-avatar">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                <path d="M12 2a5 5 0 1 1 0 10A5 5 0 0 1 12 2z"/>
                <path d="M3 20a9 9 0 0 1 18 0"/>
            </svg>
        </div>
        <div class="cb-header-info">
            <span class="cb-header-name">Assistente Livraria</span>
            <span class="cb-header-status"><span class="cb-dot"></span>Online</span>
        </div>
        <button class="cb-close-btn" id="cbClose" aria-label="Fechar chat">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                <line x1="18" y1="6" x2="6" y2="18"/>
                <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
        </button>
    </div>

    <div class="cb-messages" id="cbMessages">
        <div class="cb-msg cb-msg--bot cb-msg--intro">
            <div class="cb-bubble">
                Olá! 👋 Sou o assistente da livraria. Posso te ajudar com:
                <ul>
                    <li>Como comprar um livro</li>
                    <li>Cadastro e conta</li>
                    <li>Trocas e devoluções</li>
                    <li>Dúvidas gerais</li>
                </ul>
                No que posso te ajudar hoje?
            </div>
        </div>
    </div>

    <div class="cb-typing" id="cbTyping" style="display:none">
        <div class="cb-bubble">
            <span class="cb-dot-typing"></span>
            <span class="cb-dot-typing"></span>
            <span class="cb-dot-typing"></span>
        </div>
    </div>

    <div class="cb-input-area">
        <textarea
            class="cb-input"
            id="cbInput"
            placeholder="Digite sua mensagem..."
            rows="1"
            maxlength="1000"
            aria-label="Mensagem para o assistente"
        ></textarea>
        <button class="cb-send-btn" id="cbSend" aria-label="Enviar mensagem" disabled>
            <svg viewBox="0 0 24 24" fill="currentColor">
                <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"/>
            </svg>
        </button>
    </div>
</div>

<script>
(function () {
    'use strict';

    const API_URL = '${pageContext.request.contextPath}/chatbot';
    const MAX_HISTORY = 20;

    const fab       = document.getElementById('cbFab');
    const win       = document.getElementById('cbWindow');
    const closeBtn  = document.getElementById('cbClose');
    const messages  = document.getElementById('cbMessages');
    const input     = document.getElementById('cbInput');
    const sendBtn   = document.getElementById('cbSend');
    const typing    = document.getElementById('cbTyping');
    const badge     = document.getElementById('cbBadge');
    const iconChat  = fab.querySelector('.cb-icon-chat');
    const iconClose = fab.querySelector('.cb-icon-close');

    let isOpen    = false;
    let isWaiting = false;
    let hasUnread = false;
    let history   = [];

    // ── Abrir / fechar ────────────────────────────────────────────────────────
    function toggle() {
        isOpen = !isOpen;
        win.classList.toggle('cb-window--open', isOpen);
        fab.classList.toggle('cb-fab--open', isOpen);
        win.setAttribute('aria-hidden', String(!isOpen));
        iconChat.style.display  = isOpen ? 'none' : '';
        iconClose.style.display = isOpen ? ''     : 'none';
        if (isOpen) {
            clearBadge();
            input.focus();
            scrollToBottom();
        }
    }

    function clearBadge() {
        hasUnread = false;
        badge.style.display = 'none';
    }

    fab.addEventListener('click', toggle);
    closeBtn.addEventListener('click', toggle);

    // ── Input ─────────────────────────────────────────────────────────────────
    input.addEventListener('input', function () {
        this.style.height = 'auto';
        this.style.height = Math.min(this.scrollHeight, 120) + 'px';
        sendBtn.disabled = this.value.trim() === '' || isWaiting;
    });

    input.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            if (!sendBtn.disabled) sendMessage();
        }
    });

    sendBtn.addEventListener('click', sendMessage);

    // ── Envio ─────────────────────────────────────────────────────────────────
    function sendMessage() {
        const text = input.value.trim();
        if (!text || isWaiting) return;

        addMessage('user', text);
        history.push({ role: 'user', content: text });

        input.value = '';
        input.style.height = 'auto';
        sendBtn.disabled = true;
        setWaiting(true);

        fetch(API_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(history.slice(-MAX_HISTORY))
        })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.error) {
                const erroTexto = typeof data.error === 'object' ? JSON.stringify(data.error) : data.error;
                addMessage('bot', '⚠️ Erro: ' + erroTexto);
                return;
            }

            let reply = 'Não consegui processar a resposta. Tente novamente.';
            if (data.candidates &&
                data.candidates[0] &&
                data.candidates[0].content &&
                data.candidates[0].content.parts &&
                data.candidates[0].content.parts[0]) {
                reply = data.candidates[0].content.parts[0].text;
            }

            addMessage('bot', reply);
            history.push({ role: 'model', content: reply });

            if (!isOpen) {
                hasUnread = true;
                badge.style.display = '';
            }
        })
        .catch(function (err) {
            console.error('Chatbot error:', err);
            addMessage('bot', '⚠️ Ocorreu um erro de conexão. Tente novamente.');
        })
        .finally(function () {
            setWaiting(false);
        });
    }

    // ── Renderização de mensagens ─────────────────────────────────────────────
    function addMessage(role, text) {
        const div = document.createElement('div');
        div.className = 'cb-msg cb-msg--' + (role === 'user' ? 'user' : 'bot');

        const bubble = document.createElement('div');
        bubble.className = 'cb-bubble';
        bubble.innerHTML = formatText(text);

        div.appendChild(bubble);
        messages.appendChild(div);

        requestAnimationFrame(function () { div.classList.add('cb-msg--visible'); });
        scrollToBottom();
    }

    /**
     * Formata o texto da IA para HTML seguro.
     * Ordem importa:
     *  1. Extrai links markdown ANTES de escapar HTML (evita &amp; quebrar a URL)
     *  2. Escapa o restante do texto
     *  3. Aplica bold, itálico, código e quebras de linha
     */
    function formatText(raw) {
        // 1. Separa links markdown [label](url) do restante para não escapar a URL
        var parts = [];
        var regex = /\[([^\]]+)\]\((https?:\/\/[^)]+)\)/g;
        var last  = 0;
        var match;

        while ((match = regex.exec(raw)) !== null) {
            // Texto antes do link — será escapado normalmente
            if (match.index > last) {
                parts.push({ type: 'text', value: raw.slice(last, match.index) });
            }
            // O link em si — preservado como HTML
            parts.push({
                type: 'link',
                label: match[1],
                url:   match[2]
            });
            last = match.index + match[0].length;
        }
        // Texto restante após o último link
        if (last < raw.length) {
            parts.push({ type: 'text', value: raw.slice(last) });
        }

        // 2. Processa cada parte
        var html = parts.map(function (part) {
            if (part.type === 'link') {
                var safeLabel = escapeHtml(part.label);
                var safeUrl   = part.url.replace(/"/g, '%22');
                return '<a href="' + safeUrl + '" target="_blank" rel="noopener noreferrer" '
                     + 'style="color:var(--cb-accent);text-decoration:underline;">'
                     + safeLabel + '</a>';
            }
            // Escapa HTML e aplica formatação markdown simples
            return escapeHtml(part.value)
                .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
                .replace(/\*(.+?)\*/g,     '<em>$1</em>')
                .replace(/`(.+?)`/g,       '<code>$1</code>')
                .replace(/\n\n/g, '</p><p>')
                .replace(/\n/g,   '<br>');
        }).join('');

        return '<p>' + html + '</p>';
    }

    function escapeHtml(str) {
        return str
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    // ── Utilitários ───────────────────────────────────────────────────────────
    function setWaiting(val) {
        isWaiting = val;
        typing.style.display = val ? 'flex' : 'none';
        if (val) scrollToBottom();
    }

    function scrollToBottom() {
        setTimeout(function () { messages.scrollTop = messages.scrollHeight; }, 50);
    }
})();
</script>
</body>
</html>
