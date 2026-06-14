--- DDL Banco de dados LES
--- Criação de todas as tabelas de livraria.db

CREATE TABLE admin (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL
);

CREATE TABLE bandeira (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE cartao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    numero TEXT NOT NULL,
    nome_impresso TEXT NOT NULL,
    bandeira_id INTEGER,
    cvv TEXT, validade TEXT,
    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    FOREIGN KEY(bandeira_id) REFERENCES bandeira(id)
);

CREATE TABLE categoria (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE cidade (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    estado_id INTEGER,
    FOREIGN KEY(estado_id) REFERENCES estado(id)
);

CREATE TABLE cliente (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    genero TEXT,
    data_nascimento DATE,
    cpf TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    ranking INTEGER DEFAULT 0,
    status TEXT NOT NULL 
);

CREATE TABLE cupom (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo TEXT UNIQUE,
    valor REAL,
    status TEXT,
    cliente_id INTEGER, tipo TEXT NOT NULL DEFAULT 'PROMOCIONAL',
    FOREIGN KEY(cliente_id) REFERENCES cliente(id)
);

CREATE TABLE endereco (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    tipo_residencia TEXT,
    tipo_logradouro TEXT,
    logradouro TEXT,
    numero TEXT,
    cep TEXT,
    bairro TEXT,
    cidade_id INTEGER,
    observacoes TEXT,
    tipo_endereco TEXT,
    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    FOREIGN KEY(cidade_id) REFERENCES cidade(id)
);

CREATE TABLE estado (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    pais_id INTEGER,
    FOREIGN KEY(pais_id) REFERENCES pais(id)
);

CREATE TABLE estoque (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    livro_id INTEGER,
    quantidade INTEGER,
    custo REAL,
    FOREIGN KEY(livro_id) REFERENCES livro(id)
);

CREATE TABLE grupo_precificacao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    margem_lucro REAL NOT NULL
);

CREATE TABLE item_pedido (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER,
    livro_id INTEGER,
    quantidade INTEGER,
    preco REAL, status_troca TEXT,
    FOREIGN KEY(pedido_id) REFERENCES pedido(id),
    FOREIGN KEY(livro_id) REFERENCES livro(id)
);

CREATE TABLE livro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    autor TEXT,
    editora TEXT,
    ano INTEGER,
    edicao TEXT,
    isbn TEXT,
    paginas INTEGER,
    sinopse TEXT,
    altura REAL,
    largura REAL,
    peso REAL,
    profundidade REAL,
    codigo_barras TEXT,
    grupo_precificacao_id INTEGER,
    status TEXT, 
    imagem_url TEXT,
    FOREIGN KEY(grupo_precificacao_id) REFERENCES grupo_precificacao(id)
);

CREATE TABLE livro_categoria (
    livro_id INTEGER,
    categoria_id INTEGER,
    PRIMARY KEY (livro_id, categoria_id),
    FOREIGN KEY(livro_id) REFERENCES livro(id),
    FOREIGN KEY(categoria_id) REFERENCES categoria(id)
);

CREATE TABLE log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario TEXT,
    acao TEXT,
    data DATETIME, 
    tabela TEXT, 
    dados_anteriores TEXT, 
    dados_novos TEXT
);

CREATE TABLE pagamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER,
    cartao_id INTEGER,
    cupom_id INTEGER,
    valor REAL,
    FOREIGN KEY(pedido_id) REFERENCES pedido(id),
    FOREIGN KEY(cartao_id) REFERENCES cartao(id),
    FOREIGN KEY(cupom_id) REFERENCES cupom(id)
);

CREATE TABLE pais (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE pedido (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    endereco_entrega_id INTEGER,
    data DATETIME,
    valor_total REAL,
    status TEXT, frete REAL NOT NULL DEFAULT 0,
    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    FOREIGN KEY(endereco_entrega_id) REFERENCES endereco(id)
);

CREATE TABLE telefone (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    tipo TEXT,
    ddd TEXT,
    numero TEXT,
    FOREIGN KEY(cliente_id) REFERENCES cliente(id)
);

CREATE TABLE troca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER,
    status TEXT,
    data_solicitacao DATE,
    data_recebimento DATE, 
    item_pedido_id INTEGER REFERENCES item_pedido(id), 
    motivo TEXT, cupom_gerado_id INTEGER REFERENCES cupom(id),
    FOREIGN KEY(pedido_id) REFERENCES pedido(id)
);
