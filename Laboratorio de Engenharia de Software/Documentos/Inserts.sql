-- ======================================================
-- SCRIPT COMPLETO PARA POPULAR BANCO DE DADOS
-- 30 LIVROS + 265 PEDIDOS EM 13 MESES
-- ======================================================

-- ======================================================
-- GRUPO DE PRECIFICAÇÃO
-- ======================================================
INSERT OR IGNORE INTO grupo_precificacao (id, nome, margem_lucro) VALUES (1, 'Padrão', 30.0);

-- ======================================================
-- CATEGORIAS
-- ======================================================
INSERT OR IGNORE INTO categoria (id, nome) VALUES (1, 'Ficção');
INSERT OR IGNORE INTO categoria (id, nome) VALUES (2, 'Fantasia');
INSERT OR IGNORE INTO categoria (id, nome) VALUES (3, 'Negócios');
INSERT OR IGNORE INTO categoria (id, nome) VALUES (4, 'Autoajuda');
INSERT OR IGNORE INTO categoria (id, nome) VALUES (5, 'Romance');

-- ======================================================
-- INSERIR 30 LIVROS
-- ======================================================

-- FICÇÃO (categoria 1) - Livros 1 a 5
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (1, '1984', 'George Orwell', 'Companhia das Letras', 2009, '9788535914843', 416, 'Distopia sobre vigilância totalitária.', 23.0, 16.0, 0.45, 2.0, '1111111111111111', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/819js3EQwbL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (2, 'Dom Casmurro', 'Machado de Assis', 'Penguin', 2016, '9788563560836', 336, 'Clássico da literatura brasileira.', 21.0, 14.0, 0.35, 1.8, '2222222222222222', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/61Sl2sWG7xS._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (3, 'O Alienista', 'Machado de Assis', 'Penguin', 2012, '9788563560195', 120, 'Sátira sobre a loucura.', 20.0, 13.0, 0.25, 1.2, '3333333333333333', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/71wXRDnVH9L._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (4, 'Cem Anos de Solidão', 'Gabriel García Márquez', 'Record', 2019, '9788501114585', 448, 'Realismo fantástico.', 23.0, 16.0, 0.5, 2.2, '4444444444444444', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/817esPahlrL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (5, 'O Estrangeiro', 'Albert Camus', 'Record', 2010, '9788501080927', 160, 'Existencialismo.', 21.0, 14.0, 0.3, 1.5, '5555555555555555', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/51ITGnVzoUL._SY445_SX342_ML2_.jpg');

-- FANTASIA (categoria 2) - Livros 6 a 10
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (6, 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Rocco', 2000, '9788532511010', 264, 'Fantasia.', 23.0, 16.0, 0.4, 2.0, '6666666666666666', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81VKM1R-U1L._SY385_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (7, 'O Senhor dos Anéis', 'J.R.R. Tolkien', 'Martins Fontes', 2001, '9788533613379', 1200, 'Fantasia épica.', 23.0, 16.0, 1.2, 5.0, '7777777777777777', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81MZ8OjmQrL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (8, 'As Crônicas de Nárnia', 'C.S. Lewis', 'Martins Fontes', 2009, '9788578270690', 768, 'Aventuras em um mundo mágico.', 23.0, 16.0, 0.9, 3.5, '8888888888888888', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/91gbxco0x0L._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (9, 'O Nome do Vento', 'Patrick Rothfuss', 'Arqueiro', 2011, '9788599296231', 656, 'Épico de fantasia.', 23.0, 16.0, 0.7, 3.0, '9999999999999999', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/51NiIHPz4wL._SY445_SX342_ML2_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (10, 'Mistborn', 'Brandon Sanderson', 'Leya', 2015, '9788544100882', 656, 'Sistema de magia único.', 23.0, 16.0, 0.75, 3.2, '1010101010101010', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/71XRJX79bDL._SY425_.jpg');

-- NEGÓCIOS (categoria 3) - Livros 11 a 15
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (11, 'O Homem Mais Rico da Babilônia', 'George Clason', 'HarperCollins', 2017, '9788595081532', 160, 'Finanças pessoais.', 21.0, 14.0, 0.3, 1.5, '1111111111111112', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81ehX6Quw2L._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (12, 'Pai Rico, Pai Pobre', 'Robert Kiyosaki', 'Alta Books', 2018, '9788550801483', 336, 'Educação financeira.', 23.0, 16.0, 0.5, 2.0, '1212121212121212', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/71V4lNR2gKL._SY425_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (13, 'A Arte da Guerra', 'Sun Tzu', 'Martins Fontes', 2006, '9788533621459', 160, 'Estratégia.', 21.0, 14.0, 0.25, 1.2, '1313131313131313', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81ZS5rrgLbS._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (14, 'Startup Enxuta', 'Eric Ries', 'Leya', 2012, '9788578270447', 352, 'Metodologia ágil.', 23.0, 16.0, 0.55, 2.1, '1414141414141414', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81NATRL+10L._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (15, 'Como Fazer Amigos', 'Dale Carnegie', 'Record', 2018, '9788501117210', 288, 'Relacionamento profissional.', 21.0, 14.0, 0.35, 1.8, '1515151515151515', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81OnkwLbDbL._SY466_.jpg');

-- AUTOAJUDA (categoria 4) - Livros 16 a 20
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (16, 'O Poder do Hábito', 'Charles Duhigg', 'Objetiva', 2012, '9788539004119', 408, 'Mudança de hábitos.', 23.0, 16.0, 0.6, 2.5, '1616161616161616', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/51Pw06uU8FL._SY445_SX342_ML2_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (17, 'Mindset', 'Carol S. Dweck', 'Objetiva', 2017, '9788547000244', 312, 'Mentalidade de crescimento.', 23.0, 16.0, 0.4, 2.0, '1717171717171717', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/41+7a4RuENL._SY445_SX342_QL70_ML2_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (18, 'Os Segredos da Mente Milionária', 'T. Harv Eker', 'Sextante', 2018, '9788543108883', 192, 'Mentalidade financeira.', 21.0, 14.0, 0.35, 1.6, '1818181818181818', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81cfVMhh-tL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (19, 'A Coragem de Não Agradar', 'Ichiro Kishimi', 'Sextante', 2019, '9788543108739', 256, 'Psicologia.', 23.0, 16.0, 0.4, 1.9, '1919191919191919', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/41hiJ8XZDOL._SY445_SX342_ML2_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (20, 'Essencialismo', 'Greg McKeown', 'Sextante', 2015, '9788543102744', 272, 'Foco no essencial.', 21.0, 14.0, 0.45, 2.0, '2020202020202020', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/71HuZRl-XeL._SY466_.jpg');

-- ROMANCE (categoria 5) - Livros 21 a 25
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (21, 'É Assim Que Acaba', 'Colleen Hoover', 'Galera', 2018, '9788501112512', 368, 'Romance dramático.', 23.0, 16.0, 0.5, 2.0, '2121212121212121', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/91r5G8RxqfL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (22, 'Verity', 'Colleen Hoover', 'Galera', 2020, '9788501117845', 320, 'Thriller romântico.', 23.0, 16.0, 0.5, 2.0, '2222222222222223', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/91SDZ2eUj+L._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (23, 'Orgulho e Preconceito', 'Jane Austen', 'Penguin', 2012, '9788563560973', 432, 'Clássico inglês.', 21.0, 14.0, 0.5, 2.0, '2323232323232323', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81JdM-o7K3S._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (24, 'O Morro dos Ventos Uivantes', 'Emily Brontë', 'Penguin', 2015, '9788563561116', 368, 'Romance gótico.', 21.0, 14.0, 0.45, 2.0, '2424242424242424', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/41ZDAGGif5S._SY445_SX342_ML2_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (25, 'A Biblioteca da Meia-Noite', 'Matt Haig', 'Bertrand Brasil', 2021, '9786558380545', 308, 'Reflexão sobre vidas.', 23.0, 16.0, 0.4, 2.0, '2525252525252525', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81iqH8dpjuL._SY425_.jpg');

-- LIVROS ADICIONAIS (26 a 30)
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (26, 'A Revolução dos Bichos', 'George Orwell', 'Companhia das Letras', 2007, '9788535909559', 152, 'Crítica política.', 21.0, 14.0, 0.2, 1.0, '2626262626262626', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/91BsZhxCRjL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (27, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Agir', 2009, '9788522009790', 96, 'Clássico infantil.', 18.0, 12.0, 0.15, 0.8, '2727272727272727', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/61MmXA6a9yL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (28, 'O Alquimista', 'Paulo Coelho', 'Paralela', 2017, '9788584391223', 208, 'Jornada pessoal.', 21.0, 14.0, 0.35, 1.5, '2828282828282828', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/81slUinjTlS._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (29, 'Coraline', 'Neil Gaiman', 'Intrínseca', 2012, '9788580572175', 192, 'Fantasia sombria.', 21.0, 14.0, 0.3, 1.2, '2929292929292929', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/91DZobBc1BL._SY466_.jpg');
INSERT OR IGNORE INTO livro (id, titulo, autor, editora, ano, isbn, paginas, sinopse, altura, largura, peso, profundidade, codigo_barras, grupo_precificacao_id, status, imagem_url) VALUES (30, 'A Sutil Arte de Ligar o Foda-se', 'Mark Manson', 'Intrínseca', 2017, '9788551001440', 224, 'Autoajuda.', 21.0, 14.0, 0.35, 1.5, '3030303030303030', 1, 'ATIVO', 'https://m.media-amazon.com/images/I/6175IU0qFgL._SY466_.jpg');

-- ======================================================
-- ESTOQUE DOS LIVROS
-- ======================================================
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (1, 80, 18.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (2, 60, 15.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (3, 50, 12.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (4, 70, 20.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (5, 55, 14.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (6, 100, 19.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (7, 40, 35.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (8, 65, 22.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (9, 50, 25.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (10, 60, 23.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (11, 45, 15.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (12, 70, 18.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (13, 55, 12.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (14, 50, 22.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (15, 65, 16.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (16, 60, 21.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (17, 55, 23.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (18, 50, 14.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (19, 45, 18.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (20, 60, 20.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (21, 80, 20.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (22, 70, 24.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (23, 55, 15.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (24, 50, 14.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (25, 65, 22.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (26, 90, 14.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (27, 120, 8.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (28, 85, 12.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (29, 50, 18.00);
INSERT OR IGNORE INTO estoque (livro_id, quantidade, custo) VALUES (30, 100, 13.00);

-- ======================================================
-- LIVRO_CATEGORIA (Associação)
-- ======================================================
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (1, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (2, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (3, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (4, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (5, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (6, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (7, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (8, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (9, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (10, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (11, 3);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (12, 3);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (13, 3);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (14, 3);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (15, 3);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (16, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (17, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (18, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (19, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (20, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (21, 5);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (22, 5);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (23, 5);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (24, 5);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (25, 5);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (26, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (27, 1);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (28, 4);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (29, 2);
INSERT OR IGNORE INTO livro_categoria (livro_id, categoria_id) VALUES (30, 4);

-- ======================================================
-- ADMIN
-- ======================================================
INSERT OR IGNORE INTO admin (id, nome, email, senha) VALUES (1, 'Administrador', 'admin@livraria.com', 'admin123');

-- ======================================================
-- CLIENTES (30 clientes)
-- ======================================================
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (1, 'Odete Roitman', 'F', '1960-01-15', '12345678910', 'odete@email.com', 'Odete123!', 5, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (2, 'Jorge Tufao', 'M', '1975-03-20', '23456789012', 'jorge@email.com', 'Jorge123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (3, 'Maria Silva', 'F', '1985-07-08', '34567890123', 'maria@email.com', 'Maria123!', 4, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (4, 'Rita Muniz', 'F', '1990-09-12', '45678901234', 'rita@email.com', 'Rita123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (5, 'Joao Silva', 'M', '1988-11-25', '56789012345', 'joao@email.com', 'Joao123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (6, 'Ana Santos', 'F', '1992-02-18', '67890123456', 'ana@email.com', 'Ana123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (7, 'Carlos Lima', 'M', '1980-05-30', '78901234567', 'carlos@email.com', 'Carlos123!', 4, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (8, 'Fernanda Costa', 'F', '1995-08-22', '89012345678', 'fernanda@email.com', 'Fernanda123!', 1, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (9, 'Roberto Alves', 'M', '1983-12-03', '90123456789', 'roberto@email.com', 'Roberto123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (10, 'Patricia Souza', 'F', '1987-06-14', '01234567890', 'patricia@email.com', 'Patricia123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (11, 'Ricardo Mendes', 'M', '1978-09-27', '12345678901', 'ricardo@email.com', 'Ricardo123!', 5, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (12, 'Juliana Ferreira', 'F', '1993-04-05', '23456789013', 'juliana@email.com', 'Juliana123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (13, 'Marcos Vinicius', 'M', '1998-01-19', '34567890124', 'marcos@email.com', 'Marcos123!', 1, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (14, 'Tatiane Rocha', 'F', '1989-07-30', '45678901235', 'tatiane@email.com', 'Tatiane123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (15, 'Paulo Henrique', 'M', '1982-11-11', '56789012346', 'paulo@email.com', 'Paulo123!', 4, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (16, 'Camila Nunes', 'F', '1991-03-08', '67890123457', 'camila@email.com', 'Camila123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (17, 'Gustavo Ribeiro', 'M', '1986-10-25', '78901234568', 'gustavo@email.com', 'Gustavo123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (18, 'Larissa Martins', 'F', '1994-12-17', '89012345679', 'larissa@email.com', 'Larissa123!', 1, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (19, 'Thiago Oliveira', 'M', '1979-05-02', '90123456780', 'thiago@email.com', 'Thiago123!', 4, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (20, 'Bianca Lima', 'F', '1996-08-29', '01234567891', 'bianca@email.com', 'Bianca123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (21, 'Felipe Santos', 'M', '1984-02-14', '12345678912', 'felipe@email.com', 'Felipe123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (22, 'Aline Pereira', 'F', '1990-06-21', '23456789014', 'aline@email.com', 'Aline123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (23, 'Bruno Costa', 'M', '1987-09-07', '34567890125', 'bruno@email.com', 'Bruno123!', 1, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (24, 'Carla Souza', 'F', '1992-11-28', '45678901236', 'carla@email.com', 'Carla123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (25, 'Diego Rocha', 'M', '1981-04-18', '56789012347', 'diego@email.com', 'Diego123!', 4, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (26, 'Elaine Martins', 'F', '1993-07-09', '67890123458', 'elaine@email.com', 'Elaine123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (27, 'Fabio Almeida', 'M', '1985-12-22', '78901234569', 'fabio@email.com', 'Fabio123!', 3, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (28, 'Gabriela Nunes', 'F', '1997-01-31', '89012345680', 'gabriela@email.com', 'Gabriela123!', 1, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (29, 'Hugo Silva', 'M', '1983-08-13', '90123456791', 'hugo@email.com', 'Hugo123!', 2, 'ATIVO');
INSERT OR IGNORE INTO cliente (id, nome, genero, data_nascimento, cpf, email, senha, ranking, status) VALUES (30, 'Isabela Lima', 'F', '1995-05-24', '01234567892', 'isabela@email.com', 'Isabela123!', 3, 'ATIVO');

-- ======================================================
-- PAIS
-- ======================================================
INSERT OR IGNORE INTO pais (id, nome) VALUES (1, 'Brasil');

-- ======================================================
-- ESTADOS
-- ======================================================
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (1, 'Acre', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (2, 'Alagoas', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (3, 'Amapá', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (4, 'Amazonas', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (5, 'Bahia', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (6, 'Ceará', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (7, 'Distrito Federal', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (8, 'Espírito Santo', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (9, 'Goiás', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (10, 'Maranhão', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (11, 'Mato Grosso', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (12, 'Mato Grosso do Sul', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (13, 'Minas Gerais', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (14, 'Pará', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (15, 'Paraíba', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (16, 'Paraná', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (17, 'Pernambuco', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (18, 'Piauí', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (19, 'Rio de Janeiro', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (20, 'Rio Grande do Norte', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (21, 'Rio Grande do Sul', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (22, 'Rondônia', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (23, 'Roraima', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (24, 'Santa Catarina', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (25, 'São Paulo', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (26, 'Sergipe', 1);
INSERT OR IGNORE INTO estado (id, nome, pais_id) VALUES (27, 'Tocantins', 1);

-- ======================================================
-- CIDADE
-- ======================================================
INSERT OR IGNORE INTO cidade (id, nome, estado_id) VALUES (1, 'Campinas', 25);
INSERT OR IGNORE INTO cidade (id, nome, estado_id) VALUES (2, 'São Paulo', 25);
INSERT OR IGNORE INTO cidade (id, nome, estado_id) VALUES (3, 'Rio de Janeiro', 19);
INSERT OR IGNORE INTO cidade (id, nome, estado_id) VALUES (4, 'Belo Horizonte', 13);
INSERT OR IGNORE INTO cidade (id, nome, estado_id) VALUES (5, 'Salvador', 5);

-- ======================================================
-- ENDEREÇOS (30 endereços de entrega)
-- ======================================================
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (1, 1, 'Apartamento', 'Rua', 'Augusta', '100', '01305000', 'Consolação', 1, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (2, 2, 'Casa', 'Avenida', 'Brasil', '500', '04567890', 'Centro', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (3, 3, 'Apartamento', 'Rua', 'da Consolação', '800', '01302000', 'Cerqueira César', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (4, 4, 'Casa', 'Alameda', 'Santos', '55', '01419000', 'Jardins', 1, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (5, 5, 'Apartamento', 'Rua', 'das Flores', '200', '01234567', 'Jardim Paulista', 1, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (6, 6, 'Apartamento', 'Rua', 'das Margaridas', '150', '04538000', 'Itaim Bibi', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (7, 7, 'Casa', 'Rua', 'Haddock Lobo', '890', '01414000', 'Cerqueira César', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (8, 8, 'Apartamento', 'Alameda', 'Campinas', '1200', '01404000', 'Jardim Paulista', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (9, 9, 'Casa', 'Rua', 'Tucumã', '300', '41527193', 'Perdizes', 5, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (10, 10, 'Apartamento', 'Avenida', 'Angélica', '2500', '01228000', 'Santa Cecília', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (11, 11, 'Casa', 'Rua', 'Cardeal Arcoverde', '500', '28467320', 'Pinheiros', 3, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (12, 12, 'Apartamento', 'Rua', 'Funchal', '400', '41527193', 'Vila Olímpia', 5, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (13, 13, 'Casa', 'Rua', 'Apuana', '123', '04711000', 'Santo Amaro', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (14, 14, 'Apartamento', 'Avenida', 'Santo Amaro', '5000', '04505001', 'Brooklin', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (15, 15, 'Casa', 'Rua', 'Ribeirão Preto', '789', '01331000', 'Bela Vista', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (16, 16, 'Apartamento', 'Rua', 'Mato Grosso', '100', '01234000', 'Consolação', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (17, 17, 'Casa', 'Avenida', 'Paulista', '1500', '01310000', 'Bela Vista', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (18, 18, 'Apartamento', 'Rua', 'Bela Cintra', '300', '28467320', 'Cerqueira César', 3, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (19, 19, 'Casa', 'Alameda', 'Jauaperi', '800', '31576482', 'Jardins', 4, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (20, 20, 'Apartamento', 'Rua', 'Lima', '500', '05405000', 'Pinheiros', 1, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (21, 21, 'Casa', 'Avenida', 'Rebouças', '2500', '05402000', 'Pinheiros', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (22, 22, 'Apartamento', 'Rua', 'João Cachoeira', '1800', '04535001', 'Itaim Bibi', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (23, 23, 'Casa', 'Rua', 'Tabapuã', '500', '04533000', 'Itaim Bibi', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (24, 24, 'Apartamento', 'Avenida', 'Brigadeiro Faria Lima', '3000', '04538133', 'Pinheiros', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (25, 25, 'Casa', 'Rua', 'Minas Gerais', '80', '01244000', 'Higienópolis', 1, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (26, 26, 'Apartamento', 'Rua', 'Bahia', '500', '31576482', 'Higienópolis', 4, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (27, 27, 'Casa', 'Rua', 'Marques de Paraná', '1200', '01303002', 'Consolação', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (28, 28, 'Apartamento', 'Rua', 'Pamplona', '1500', '01405000', 'Jardim Paulista', 5, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (29, 29, 'Casa', 'Rua', 'Groenlândia', '650', '41527193', 'Jardim América', 2, 'ENTREGA');
INSERT OR IGNORE INTO endereco (id, cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) VALUES (30, 30, 'Apartamento', 'Rua', 'Araújo', '400', '01220020', 'Consolação', 1, 'ENTREGA');

-- ENDEREÇOS DE COBRANÇA
INSERT OR IGNORE INTO endereco (cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, tipo_endereco) SELECT cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, 'COBRANCA' FROM endereco WHERE tipo_endereco = 'ENTREGA';

-- ======================================================
-- TELEFONES
-- ======================================================
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (1, 'CELULAR', '11', '912341234');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (2, 'CELULAR', '11', '912345678');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (3, 'CELULAR', '11', '987654321');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (4, 'CELULAR', '11', '976543210');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (5, 'CELULAR', '11', '965432109');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (6, 'CELULAR', '11', '954321098');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (7, 'CELULAR', '11', '943210987');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (8, 'CELULAR', '11', '932109876');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (9, 'CELULAR', '11', '921098765');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (10, 'CELULAR', '11', '910987654');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (11, 'CELULAR', '11', '909876543');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (12, 'CELULAR', '11', '898765432');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (13, 'CELULAR', '11', '887654321');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (14, 'CELULAR', '11', '876543210');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (15, 'CELULAR', '11', '865432109');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (16, 'CELULAR', '11', '854321098');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (17, 'CELULAR', '11', '843210987');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (18, 'CELULAR', '11', '832109876');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (19, 'CELULAR', '11', '821098765');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (20, 'CELULAR', '11', '810987654');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (21, 'CELULAR', '11', '809876543');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (22, 'CELULAR', '11', '798765432');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (23, 'CELULAR', '11', '787654321');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (24, 'CELULAR', '11', '776543210');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (25, 'CELULAR', '11', '765432109');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (26, 'CELULAR', '11', '754321098');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (27, 'CELULAR', '11', '743210987');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (28, 'CELULAR', '11', '732109876');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (29, 'CELULAR', '11', '721098765');
INSERT OR IGNORE INTO telefone (cliente_id, tipo, ddd, numero) VALUES (30, 'CELULAR', '11', '710987654');

-- ======================================================
-- BANDEIRA
-- ======================================================
INSERT OR IGNORE INTO bandeira (id, nome) VALUES (1, 'Visa');
INSERT OR IGNORE INTO bandeira (id, nome) VALUES (2, 'Mastercard');
INSERT OR IGNORE INTO bandeira (id, nome) VALUES (3, 'Elo');

-- ======================================================
-- CARTÕES
-- ======================================================
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (1, '1111222233334444', 'Odete Roitman', 1, '123', '12/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (2, '2222333344445555', 'Jorge Tufao', 2, '456', '10/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (3, '3333444455556666', 'Maria Silva', 3, '789', '05/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (4, '4444555566667777', 'Rita Muniz', 1, '321', '08/27');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (5, '5555666677778888', 'Joao Silva', 2, '654', '03/31');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (6, '6666777788889999', 'Ana Santos', 3, '987', '12/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (7, '7777888899990000', 'Carlos Lima', 1, '456', '06/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (8, '8888999900001111', 'Fernanda Costa', 2, '123', '09/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (9, '9999000011112222', 'Roberto Alves', 3, '789', '11/27');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (10, '0000111122223333', 'Patricia Souza', 1, '654', '04/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (11, '1111222233334445', 'Ricardo Mendes', 2, '321', '12/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (12, '2222333344445556', 'Juliana Ferreira', 3, '987', '10/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (13, '3333444455556667', 'Marcos Vinicius', 1, '456', '05/31');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (14, '4444555566667778', 'Tatiane Rocha', 2, '123', '08/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (15, '5555666677778889', 'Paulo Henrique', 3, '789', '03/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (16, '6666777788889990', 'Camila Nunes', 1, '654', '12/27');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (17, '7777888899990001', 'Gustavo Ribeiro', 2, '321', '06/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (18, '8888999900001112', 'Larissa Martins', 3, '987', '09/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (19, '9999000011112223', 'Thiago Oliveira', 1, '456', '11/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (20, '0000111122223334', 'Bianca Lima', 2, '123', '04/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (21, '1111222233334446', 'Felipe Santos', 3, '789', '12/31');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (22, '2222333344445557', 'Aline Pereira', 1, '654', '10/27');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (23, '3333444455556668', 'Bruno Costa', 2, '321', '05/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (24, '4444555566667779', 'Carla Souza', 3, '987', '08/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (25, '5555666677778890', 'Diego Rocha', 1, '456', '03/27');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (26, '6666777788889991', 'Elaine Martins', 2, '123', '12/28');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (27, '7777888899990002', 'Fabio Almeida', 3, '789', '06/29');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (28, '8888999900001113', 'Gabriela Nunes', 1, '654', '09/30');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (29, '9999000011112224', 'Hugo Silva', 2, '321', '11/31');
INSERT OR IGNORE INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (30, '0000111122223335', 'Isabela Lima', 3, '987', '04/28');

-- ======================================================
-- CUPOM
-- ======================================================
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (1, 'BEMVINDO10', 10.00, 'USADO', 1, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (2, 'FIDELIDADE15', 15.00, 'USADO', 3, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (3, 'VERAO20', 20.00, 'DISPONIVEL', 5, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (4, 'NATAL30', 30.00, 'USADO', 7, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (5, 'ANIVERSARIO25', 25.00, 'DISPONIVEL', 9, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (6, 'RELEITURAS10', 10.00, 'USADO', 11, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (7, 'PROMO15', 15.00, 'DISPONIVEL', 13, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (8, 'BLACK20', 20.00, 'USADO', 15, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (9, 'VOLTA30', 30.00, 'DISPONIVEL', 17, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (10, 'ESPECIAL50', 50.00, 'DISPONIVEL', 19, 'PROMOCIONAL');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (11, 'TROCA10_1', 10.00, 'DISPONIVEL', 10, 'TROCA');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (12, 'TROCA15_1', 15.00, 'DISPONIVEL', 25, 'TROCA');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (13, 'TROCA20_1', 20.00, 'DISPONIVEL', 8, 'TROCA');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (14, 'TROCA25_1', 25.00, 'DISPONIVEL', 23, 'TROCA');
INSERT OR IGNORE INTO cupom (id, codigo, valor, status, cliente_id, tipo) VALUES (15, 'TROCA30_1', 30.00, 'DISPONIVEL', 15, 'TROCA');
INSERT OR IGNORE INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES ('TROCA48_10', 10.00, 'DISPONIVEL', 8, 'TROCA');
INSERT OR IGNORE INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES ('TROCA110_15', 15.00, 'DISPONIVEL', 10, 'TROCA');
INSERT OR IGNORE INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES ('TROCA170_20', 20.00, 'DISPONIVEL', 18, 'TROCA');
INSERT OR IGNORE INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES ('TROCA215_25', 25.00, 'DISPONIVEL', 24, 'TROCA');
INSERT OR IGNORE INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES ('TROCA240_30', 30.00, 'DISPONIVEL', 20, 'TROCA');


-- ======================================================
-- PEDIDOS (MAIO/2025 a MAIO/2026 - ~265 pedidos)
-- ======================================================

-- MAIO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1746057600000, 95.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1746072000000, 67.50, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1746086400000, 116.0, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1746100800000, 120.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1746115200000, 45.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1746129600000, 144.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1746144000000, 84.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1746158400000, 143.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1746172800000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1746187200000, 185.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1746201600000, 82.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1746216000000, 104.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1746230400000, 88.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1746244800000, 153.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1746259200000, 118.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1746273600000, 130.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1746288000000, 89.50, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1746302400000, 168.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1746316800000, 67.50, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1746331200000, 200.00, 'ENTREGUE');

-- JUNHO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1748736000000, 87.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1748750400000, 76.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1748764800000, 107.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1748779200000, 160.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1748793600000, 119.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1748808000000, 101.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1748822400000, 112.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1748836800000, 242.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1748851200000, 136.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1748865600000, 162.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1748880000000, 74.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1748894400000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1748908800000, 108.50, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1748923200000, 141.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1748937600000, 77.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1748952000000, 116.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1748966400000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1748980800000, 102.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1748995200000, 99.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1749009600000, 153.00, 'ENTREGUE');

-- JULHO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1751328000000, 78.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1751342400000, 55.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1751356800000, 121.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1751371200000, 66.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1751385600000, 90.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1751400000000, 48.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1751414400000, 83.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1751428800000, 70.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1751443200000, 105.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1751457600000, 61.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1751472000000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1751486400000, 44.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1751500800000, 112.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1751515200000, 57.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1751529600000, 84.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1751544000000, 72.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1751558400000, 101.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1751572800000, 63.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1751587200000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1751601600000, 50.00, 'ENTREGUE');

-- AGOSTO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1754006400000, 79.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1754020800000, 95.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1754035200000, 58.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1754049600000, 114.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1754064000000, 67.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1754078400000, 86.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1754092800000, 53.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1754107200000, 109.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1754121600000, 74.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1754136000000, 98.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1754150400000, 62.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1754164800000, 87.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1754179200000, 71.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1754193600000, 106.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1754208000000, 55.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1754222400000, 92.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1754236800000, 68.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1754251200000, 103.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1754265600000, 49.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1754280000000, 117.00, 'ENTREGUE');

-- SETEMBRO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1756684800000, 82.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1756699200000, 59.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1756713600000, 123.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1756728000000, 64.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1756742400000, 91.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1756756800000, 47.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1756771200000, 85.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1756785600000, 73.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1756800000000, 108.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1756814400000, 60.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1756828800000, 97.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1756843200000, 56.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1756857600000, 88.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1756872000000, 69.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1756886400000, 102.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1756900800000, 51.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1756915200000, 94.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1756929600000, 66.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1756944000000, 119.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1756958400000, 45.00, 'ENTREGUE');

-- OUTUBRO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1759363200000, 75.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1759377600000, 100.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1759392000000, 63.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1759406400000, 111.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1759420800000, 54.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1759435200000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1759449600000, 77.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1759464000000, 104.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1759478400000, 61.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1759492800000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1759507200000, 48.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1759521600000, 83.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1759536000000, 70.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1759550400000, 115.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1759564800000, 52.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1759579200000, 93.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1759593600000, 68.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1759608000000, 107.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1759622400000, 59.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1759636800000, 87.00, 'ENTREGUE');

-- NOVEMBRO/2025 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1761955200000, 80.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1761969600000, 62.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1761984000000, 118.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1761998400000, 55.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1762012800000, 99.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1762027200000, 71.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1762041600000, 86.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1762056000000, 50.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1762070400000, 113.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1762084800000, 67.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1762099200000, 92.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1762113600000, 58.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1762128000000, 105.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1762142400000, 74.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1762156800000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1762171200000, 65.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1762185600000, 97.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1762200000000, 53.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1762214400000, 110.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1762228800000, 76.00, 'ENTREGUE');

-- DEZEMBRO/2025 (25 pedidos - mês de pico)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1764633600000, 145.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1764648000000, 98.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1764662400000, 167.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1764676800000, 112.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1764691200000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1764705600000, 156.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1764720000000, 73.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1764734400000, 124.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1764748800000, 101.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1764763200000, 138.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1764777600000, 95.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1764792000000, 119.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1764806400000, 82.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1764820800000, 143.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1764835200000, 107.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1764849600000, 66.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1764864000000, 131.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1764878400000, 94.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1764892800000, 115.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1764907200000, 88.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1764921600000, 149.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1764936000000, 76.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1764950400000, 128.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1764964800000, 103.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1764979200000, 91.00, 'ENTREGUE');

-- JANEIRO/2026 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1767312000000, 84.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1767326400000, 60.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1767340800000, 117.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1767355200000, 69.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1767369600000, 95.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1767384000000, 56.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1767398400000, 108.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1767412800000, 73.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1767427200000, 99.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1767441600000, 64.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1767456000000, 114.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1767470400000, 51.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1767484800000, 86.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1767499200000, 78.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1767513600000, 105.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1767528000000, 62.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1767542400000, 93.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1767556800000, 70.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1767571200000, 111.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1767585600000, 57.00, 'ENTREGUE');

-- FEVEREIRO/2026 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1769990400000, 87.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1770004800000, 63.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1770019200000, 120.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1770033600000, 68.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1770048000000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1770062400000, 55.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1770076800000, 109.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1770091200000, 74.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1770105600000, 101.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1770120000000, 66.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1770134400000, 115.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1770148800000, 52.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1770163200000, 88.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1770177600000, 79.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1770192000000, 106.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1770206400000, 61.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1770220800000, 94.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1770235200000, 72.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1770249600000, 113.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1770264000000, 58.00, 'ENTREGUE');

-- MARÇO/2026 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1772496000000, 90.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1772510400000, 65.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1772524800000, 122.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1772539200000, 71.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1772553600000, 98.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1772568000000, 54.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1772582400000, 111.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1772596800000, 76.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1772611200000, 103.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1772625600000, 67.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1772640000000, 118.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1772654400000, 59.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1772668800000, 91.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1772683200000, 80.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1772697600000, 107.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1772712000000, 62.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1772726400000, 95.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1772740800000, 73.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1772755200000, 116.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1772769600000, 56.00, 'ENTREGUE');

-- ABRIL/2026 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1775088000000, 89.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1775102400000, 64.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1775116800000, 125.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1775131200000, 72.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1775145600000, 100.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1775160000000, 57.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1775174400000, 112.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1775188800000, 77.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1775203200000, 104.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1775217600000, 68.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (26, 26, 1775232000000, 119.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (27, 27, 1775246400000, 60.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (28, 28, 1775260800000, 92.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (29, 29, 1775275200000, 81.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (30, 30, 1775289600000, 108.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (1, 1, 1775304000000, 63.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (2, 2, 1775318400000, 96.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (3, 3, 1775332800000, 74.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (4, 4, 1775347200000, 117.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (5, 5, 1775361600000, 59.00, 'ENTREGUE');

-- MAIO/2026 (20 pedidos)
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (6, 6, 1777680000000, 91.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (7, 7, 1777694400000, 66.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (8, 8, 1777708800000, 123.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (9, 9, 1777723200000, 73.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (10, 10, 1777737600000, 101.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (11, 11, 1777752000000, 58.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (12, 12, 1777766400000, 113.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (13, 13, 1777780800000, 78.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (14, 14, 1777795200000, 105.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (15, 15, 1777809600000, 69.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (16, 16, 1777824000000, 120.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (17, 17, 1777838400000, 61.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (18, 18, 1777852800000, 93.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (19, 19, 1777867200000, 82.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (20, 20, 1777881600000, 109.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (21, 21, 1777896000000, 64.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (22, 22, 1777910400000, 97.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (23, 23, 1777924800000, 75.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (24, 24, 1777939200000, 118.00, 'ENTREGUE');
INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (25, 25, 1777953600000, 60.00, 'ENTREGUE');

-- ======================================================
-- 11. ITENS DOS PEDIDOS (2-3 itens por pedido)
-- ======================================================

-- PEDIDOS 1-10
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (1, 1, 2, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (1, 21, 1, 49.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (2, 6, 1, 39.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (2, 11, 1, 28.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (3, 16, 2, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (3, 7, 1, 52.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (4, 2, 3, 25.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (4, 12, 1, 45.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (5, 17, 2, 22.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (6, 3, 2, 38.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (6, 8, 1, 68.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (7, 18, 2, 26.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (7, 13, 1, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (8, 4, 1, 48.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (8, 9, 1, 72.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (8, 23, 1, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (9, 19, 2, 28.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (9, 14, 1, 40.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (10, 5, 3, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (10, 10, 1, 65.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (10, 24, 1, 24.00);

-- PEDIDOS 11-20
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (11, 20, 1, 40.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (11, 25, 2, 21.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (12, 6, 2, 39.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (12, 26, 1, 26.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (13, 15, 2, 35.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (13, 27, 1, 18.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (14, 1, 3, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (14, 7, 1, 52.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (14, 28, 1, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (15, 2, 2, 25.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (15, 8, 1, 68.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (16, 21, 2, 49.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (16, 16, 1, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (17, 22, 1, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (17, 11, 1, 28.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (17, 3, 1, 38.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (18, 4, 2, 48.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (18, 9, 1, 72.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (19, 12, 1, 45.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (19, 17, 1, 22.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (20, 5, 1, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (20, 10, 2, 65.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (20, 29, 1, 38.00);

-- PEDIDOS 21-30
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (21, 13, 2, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (21, 23, 1, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (22, 18, 1, 26.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (22, 30, 2, 25.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (23, 19, 3, 28.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (23, 1, 1, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (24, 24, 1, 24.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (24, 8, 2, 68.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (25, 14, 2, 40.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (25, 6, 1, 39.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (26, 20, 2, 40.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (26, 25, 1, 21.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (27, 15, 1, 35.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (27, 7, 1, 52.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (27, 2, 1, 25.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (28, 9, 3, 72.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (28, 26, 1, 26.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (29, 3, 1, 38.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (29, 21, 2, 49.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (30, 10, 2, 65.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (30, 16, 1, 32.00);

-- PEDIDOS 31-40
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (31, 1, 2, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (31, 22, 1, 28.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (32, 11, 2, 28.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (32, 6, 1, 39.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (33, 17, 1, 22.50);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (33, 8, 1, 68.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (33, 27, 1, 18.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (34, 4, 2, 48.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (34, 12, 1, 45.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (35, 18, 2, 26.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (35, 2, 1, 25.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (36, 7, 1, 52.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (36, 28, 2, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (37, 21, 1, 49.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (37, 14, 1, 40.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (38, 5, 2, 32.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (38, 29, 1, 38.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (39, 3, 2, 38.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (39, 23, 1, 23.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (40, 19, 2, 28.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (40, 9, 1, 72.00);
INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (40, 30, 1, 25.00);

-- Itens de pedido gerados para pedidos 41 a 265
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (88, 41, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (89, 41, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (90, 42, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (91, 42, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (92, 43, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (93, 43, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (94, 44, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (95, 44, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (96, 45, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (97, 45, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (98, 46, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (99, 46, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (100, 47, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (101, 47, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (102, 48, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (103, 48, 24, 1, 24.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (104, 49, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (105, 49, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (106, 50, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (107, 50, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (108, 51, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (109, 51, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (110, 52, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (111, 52, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (112, 53, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (113, 53, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (114, 54, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (115, 54, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (116, 55, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (117, 55, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (118, 56, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (119, 56, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (120, 57, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (121, 57, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (122, 58, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (123, 58, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (124, 59, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (125, 59, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (126, 60, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (127, 60, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (128, 61, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (129, 61, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (130, 62, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (131, 62, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (132, 63, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (133, 63, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (134, 64, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (135, 64, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (136, 65, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (137, 65, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (138, 66, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (139, 66, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (140, 67, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (141, 67, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (142, 68, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (143, 68, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (144, 69, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (145, 69, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (146, 70, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (147, 70, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (148, 71, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (149, 71, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (150, 72, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (151, 72, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (152, 73, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (153, 73, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (154, 74, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (155, 74, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (156, 75, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (157, 75, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (158, 76, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (159, 76, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (160, 77, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (161, 77, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (162, 78, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (163, 78, 11, 2, 28.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (164, 79, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (165, 79, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (166, 80, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (167, 80, 4, 1, 48.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (168, 81, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (169, 81, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (170, 82, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (171, 82, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (172, 83, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (173, 83, 2, 4, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (174, 84, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (175, 84, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (176, 85, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (177, 85, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (178, 86, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (179, 86, 24, 1, 24.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (180, 87, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (181, 87, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (182, 88, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (183, 88, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (184, 89, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (185, 89, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (186, 90, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (187, 90, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (188, 91, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (189, 91, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (190, 92, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (191, 92, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (192, 93, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (193, 93, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (194, 94, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (195, 94, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (196, 95, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (197, 95, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (198, 96, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (199, 96, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (200, 97, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (201, 97, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (202, 98, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (203, 98, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (204, 99, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (205, 99, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (206, 100, 17, 1, 22.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (207, 100, 17, 1, 22.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (208, 101, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (209, 101, 7, 1, 52.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (210, 102, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (211, 102, 27, 3, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (212, 103, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (213, 103, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (214, 104, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (215, 104, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (216, 105, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (217, 105, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (218, 106, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (219, 106, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (220, 107, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (221, 107, 27, 3, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (222, 108, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (223, 108, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (224, 109, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (225, 109, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (226, 110, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (227, 110, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (228, 111, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (229, 111, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (230, 112, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (231, 112, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (232, 113, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (233, 113, 24, 1, 24.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (234, 114, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (235, 114, 1, 4, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (236, 115, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (237, 115, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (238, 116, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (239, 116, 15, 2, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (240, 117, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (241, 117, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (242, 118, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (243, 118, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (244, 119, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (245, 119, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (246, 120, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (247, 120, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (248, 121, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (249, 121, 11, 2, 28.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (250, 122, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (251, 122, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (252, 123, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (253, 123, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (254, 124, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (255, 124, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (256, 125, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (257, 125, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (258, 126, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (259, 126, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (260, 127, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (261, 127, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (262, 128, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (263, 128, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (264, 129, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (265, 129, 12, 2, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (266, 130, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (267, 130, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (268, 131, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (269, 131, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (270, 132, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (271, 132, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (272, 133, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (273, 133, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (274, 134, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (275, 134, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (276, 135, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (277, 135, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (278, 136, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (279, 136, 25, 2, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (280, 137, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (281, 137, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (282, 138, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (283, 138, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (284, 139, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (285, 139, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (286, 140, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (287, 140, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (288, 141, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (289, 141, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (290, 142, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (291, 142, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (292, 143, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (293, 143, 4, 3, 48.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (294, 144, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (295, 144, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (296, 145, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (297, 145, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (298, 146, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (299, 146, 14, 2, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (300, 147, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (301, 147, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (302, 148, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (303, 148, 6, 2, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (304, 149, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (305, 149, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (306, 150, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (307, 150, 1, 4, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (308, 151, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (309, 151, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (310, 152, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (311, 152, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (312, 153, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (313, 153, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (314, 154, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (315, 154, 14, 3, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (316, 155, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (317, 155, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (318, 156, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (319, 156, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (320, 157, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (321, 157, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (322, 158, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (323, 158, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (324, 159, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (325, 159, 1, 4, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (326, 160, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (327, 160, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (328, 161, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (329, 161, 14, 2, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (330, 162, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (331, 162, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (332, 163, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (333, 163, 15, 3, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (334, 164, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (335, 164, 11, 2, 28.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (336, 165, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (337, 165, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (338, 166, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (339, 166, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (340, 167, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (341, 167, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (342, 168, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (343, 168, 4, 1, 48.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (344, 169, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (345, 169, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (346, 170, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (347, 170, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (348, 171, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (349, 171, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (350, 172, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (351, 172, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (352, 173, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (353, 173, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (354, 174, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (355, 174, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (356, 175, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (357, 175, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (358, 176, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (359, 176, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (360, 177, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (361, 177, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (362, 178, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (363, 178, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (364, 179, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (365, 179, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (366, 180, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (367, 180, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (368, 181, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (369, 181, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (370, 182, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (371, 182, 15, 2, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (372, 183, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (373, 183, 24, 1, 24.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (374, 184, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (375, 184, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (376, 185, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (377, 185, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (378, 186, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (379, 186, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (380, 187, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (381, 187, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (382, 188, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (383, 188, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (384, 189, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (385, 189, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (386, 190, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (387, 190, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (388, 191, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (389, 191, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (390, 192, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (391, 192, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (392, 193, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (393, 193, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (394, 194, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (395, 194, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (396, 195, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (397, 195, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (398, 196, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (399, 196, 1, 4, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (400, 197, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (401, 197, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (402, 198, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (403, 198, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (404, 199, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (405, 199, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (406, 200, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (407, 200, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (408, 201, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (409, 201, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (410, 202, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (411, 202, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (412, 203, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (413, 203, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (414, 204, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (415, 204, 12, 2, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (416, 205, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (417, 205, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (418, 206, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (419, 206, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (420, 207, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (421, 207, 25, 2, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (422, 208, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (423, 208, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (424, 209, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (425, 209, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (426, 210, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (427, 210, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (428, 211, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (429, 211, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (430, 212, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (431, 212, 10, 1, 65.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (432, 213, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (433, 213, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (434, 214, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (435, 214, 11, 2, 28.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (436, 215, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (437, 215, 25, 1, 21.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (438, 216, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (439, 216, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (440, 217, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (441, 217, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (442, 218, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (443, 218, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (444, 219, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (445, 219, 11, 2, 28.5);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (446, 220, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (447, 220, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (448, 221, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (449, 221, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (450, 222, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (451, 222, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (452, 223, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (453, 223, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (454, 224, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (455, 224, 15, 2, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (456, 225, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (457, 225, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (458, 226, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (459, 226, 5, 2, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (460, 227, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (461, 227, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (462, 228, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (463, 228, 19, 2, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (464, 229, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (465, 229, 18, 1, 26.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (466, 230, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (467, 230, 27, 3, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (468, 231, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (469, 231, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (470, 232, 3, 2, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (471, 232, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (472, 233, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (473, 233, 27, 3, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (474, 234, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (475, 234, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (476, 235, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (477, 235, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (478, 236, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (479, 236, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (480, 237, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (481, 237, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (482, 238, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (483, 238, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (484, 239, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (485, 239, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (486, 240, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (487, 240, 6, 1, 39.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (488, 241, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (489, 241, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (490, 242, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (491, 242, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (492, 243, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (493, 243, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (494, 244, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (495, 244, 4, 1, 48.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (496, 245, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (497, 245, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (498, 246, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (499, 246, 8, 1, 68.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (500, 247, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (501, 247, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (502, 248, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (503, 248, 2, 4, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (504, 249, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (505, 249, 2, 2, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (506, 250, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (507, 250, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (508, 251, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (509, 251, 15, 1, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (510, 252, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (511, 252, 12, 2, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (512, 253, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (513, 253, 5, 1, 32.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (514, 254, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (515, 254, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (516, 255, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (517, 255, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (518, 256, 2, 3, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (519, 256, 12, 1, 45.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (520, 257, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (521, 257, 3, 1, 38.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (522, 258, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (523, 258, 15, 2, 35.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (524, 259, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (525, 259, 27, 2, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (526, 260, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (527, 260, 14, 1, 40.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (528, 261, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (529, 261, 27, 1, 18.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (530, 262, 1, 3, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (531, 262, 19, 1, 28.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (532, 263, 1, 1, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (533, 263, 7, 1, 52.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (534, 264, 1, 2, 23.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (535, 264, 9, 1, 72.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (536, 265, 2, 1, 25.0);
INSERT INTO item_pedido (id, pedido_id, livro_id, quantidade, preco) VALUES (537, 265, 15, 1, 35.0);

UPDATE item_pedido SET status_troca = 'TROCADO' WHERE id = 19;
UPDATE item_pedido SET status_troca = 'TROCADO' WHERE id = 53;
UPDATE item_pedido SET status_troca = 'TROCA_SOLICITADA' WHERE id = 102;
UPDATE item_pedido SET status_troca = 'TROCADO' WHERE id = 180;
UPDATE item_pedido SET status_troca = 'TROCA_SOLICITADA' WHERE id = 226;
UPDATE item_pedido SET status_troca = 'TROCADO' WHERE id = 292;
UPDATE item_pedido SET status_troca = 'TROCA_SOLICITADA' WHERE id = 346;
UPDATE item_pedido SET status_troca = 'TROCADO' WHERE id = 396;
UPDATE item_pedido SET status_troca = 'TROCA_SOLICITADA' WHERE id = 436;
UPDATE item_pedido SET status_troca = 'TROCA_SOLICITADA' WHERE id = 486;

-- ======================================================
-- 12. PAGAMENTOS
-- ======================================================
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (1, 1, NULL, 95.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (2, 2, NULL, 67.50);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (3, 3, NULL, 116.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (4, 4, NULL, 120.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (5, 5, NULL, 45.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (6, 6, NULL, 144.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (7, 7, NULL, 84.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (8, 8, NULL, 143.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (9, 9, NULL, 96.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (10, 10, NULL, 185.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (11, 11, NULL, 82.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (12, 12, NULL, 104.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (13, 13, NULL, 88.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (14, 14, NULL, 153.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (15, 15, NULL, 118.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (16, 16, NULL, 130.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (17, 17, NULL, 89.50);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (18, 18, NULL, 168.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (19, 19, NULL, 67.50);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (20, 20, NULL, 200.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (21, 21, NULL, 87.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (22, 22, NULL, 76.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (23, 23, NULL, 107.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (24, 24, NULL, 160.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (25, 25, NULL, 119.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (26, 26, NULL, 101.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (27, 27, NULL, 112.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (28, 28, NULL, 242.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (29, 29, NULL, 136.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (30, 30, NULL, 162.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (31, 1, NULL, 74.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (32, 2, NULL, 96.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (33, 3, NULL, 108.50);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (34, 4, NULL, 141.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (35, 5, NULL, 77.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (36, 6, NULL, 116.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (37, 7, NULL, 89.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (38, 8, NULL, 102.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (39, 9, NULL, 99.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (40, 10, NULL, 153.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (41, 11, NULL, 78.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (42, 12, NULL, 55.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (43, 13, NULL, 121.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (44, 14, NULL, 66.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (45, 15, NULL, 90.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (46, 16, NULL, 48.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (47, 17, NULL, 83.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (48, 18, NULL, 70.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (49, 19, NULL, 105.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (50, 20, NULL, 61.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (51, 21, NULL, 96.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (52, 22, NULL, 44.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (53, 23, NULL, 112.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (54, 24, NULL, 57.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (55, 25, NULL, 84.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (56, 26, NULL, 72.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (57, 27, NULL, 101.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (58, 28, NULL, 63.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (59, 29, NULL, 89.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (60, 30, NULL, 50.00);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (61, 1, NULL, 79.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (62, 2, NULL, 95.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (63, 3, NULL, 58.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (64, 4, NULL, 114.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (65, 5, NULL, 67.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (66, 6, NULL, 86.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (67, 7, NULL, 53.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (68, 8, NULL, 109.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (69, 9, NULL, 74.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (70, 10, NULL, 98.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (71, 11, NULL, 62.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (72, 12, NULL, 87.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (73, 13, NULL, 71.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (74, 14, NULL, 106.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (75, 15, NULL, 55.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (76, 16, NULL, 92.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (77, 17, NULL, 68.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (78, 18, NULL, 103.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (79, 19, NULL, 49.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (80, 20, NULL, 117.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (81, 21, NULL, 82.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (82, 22, NULL, 59.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (83, 23, NULL, 123.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (84, 24, NULL, 64.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (85, 25, NULL, 91.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (86, 26, NULL, 47.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (87, 27, NULL, 85.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (88, 28, NULL, 73.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (89, 29, NULL, 108.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (90, 30, NULL, 60.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (91, 1, NULL, 97.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (92, 2, NULL, 56.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (93, 3, NULL, 88.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (94, 4, NULL, 69.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (95, 5, NULL, 102.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (96, 6, NULL, 51.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (97, 7, NULL, 94.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (98, 8, NULL, 66.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (99, 9, NULL, 119.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (100, 10, NULL, 45.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (101, 11, NULL, 75.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (102, 12, NULL, 100.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (103, 13, NULL, 63.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (104, 14, NULL, 111.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (105, 15, NULL, 54.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (106, 16, NULL, 89.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (107, 17, NULL, 77.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (108, 18, NULL, 104.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (109, 19, NULL, 61.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (110, 20, NULL, 96.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (111, 21, NULL, 48.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (112, 22, NULL, 83.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (113, 23, NULL, 70.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (114, 24, NULL, 115.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (115, 25, NULL, 52.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (116, 26, NULL, 93.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (117, 27, NULL, 68.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (118, 28, NULL, 107.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (119, 29, NULL, 59.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (120, 30, NULL, 87.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (121, 1, NULL, 80.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (122, 2, NULL, 62.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (123, 3, NULL, 118.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (124, 4, NULL, 55.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (125, 5, NULL, 99.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (126, 6, NULL, 71.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (127, 7, NULL, 86.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (128, 8, NULL, 50.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (129, 9, NULL, 113.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (130, 10, NULL, 67.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (131, 11, NULL, 92.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (132, 12, NULL, 58.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (133, 13, NULL, 105.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (134, 14, NULL, 74.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (135, 15, NULL, 89.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (136, 16, NULL, 65.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (137, 17, NULL, 97.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (138, 18, NULL, 53.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (139, 19, NULL, 110.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (140, 20, NULL, 76.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (141, 21, NULL, 145.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (142, 22, NULL, 98.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (143, 23, NULL, 167.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (144, 24, NULL, 112.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (145, 25, NULL, 89.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (146, 26, NULL, 156.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (147, 27, NULL, 73.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (148, 28, NULL, 124.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (149, 29, NULL, 101.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (150, 30, NULL, 138.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (151, 1, NULL, 95.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (152, 2, NULL, 119.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (153, 3, NULL, 82.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (154, 4, NULL, 143.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (155, 5, NULL, 107.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (156, 6, NULL, 66.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (157, 7, NULL, 131.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (158, 8, NULL, 94.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (159, 9, NULL, 115.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (160, 10, NULL, 88.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (161, 11, NULL, 149.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (162, 12, NULL, 76.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (163, 13, NULL, 128.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (164, 14, NULL, 103.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (165, 15, NULL, 91.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (166, 16, NULL, 84.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (167, 17, NULL, 60.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (168, 18, NULL, 117.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (169, 19, NULL, 69.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (170, 20, NULL, 95.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (171, 21, NULL, 56.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (172, 22, NULL, 108.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (173, 23, NULL, 73.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (174, 24, NULL, 99.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (175, 25, NULL, 64.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (176, 26, NULL, 114.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (177, 27, NULL, 51.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (178, 28, NULL, 86.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (179, 29, NULL, 78.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (180, 30, NULL, 105.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (181, 1, NULL, 62.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (182, 2, NULL, 93.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (183, 3, NULL, 70.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (184, 4, NULL, 111.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (185, 5, NULL, 57.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (186, 6, NULL, 87.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (187, 7, NULL, 63.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (188, 8, NULL, 120.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (189, 9, NULL, 68.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (190, 10, NULL, 96.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (191, 11, NULL, 55.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (192, 12, NULL, 109.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (193, 13, NULL, 74.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (194, 14, NULL, 101.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (195, 15, NULL, 66.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (196, 16, NULL, 115.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (197, 17, NULL, 52.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (198, 18, NULL, 88.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (199, 19, NULL, 79.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (200, 20, NULL, 106.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (201, 21, NULL, 61.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (202, 22, NULL, 94.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (203, 23, NULL, 72.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (204, 24, NULL, 113.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (205, 25, NULL, 58.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (206, 26, NULL, 90.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (207, 27, NULL, 65.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (208, 28, NULL, 122.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (209, 29, NULL, 71.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (210, 30, NULL, 98.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (211, 1, NULL, 54.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (212, 2, NULL, 111.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (213, 3, NULL, 76.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (214, 4, NULL, 103.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (215, 5, NULL, 67.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (216, 6, NULL, 118.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (217, 7, NULL, 59.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (218, 8, NULL, 91.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (219, 9, NULL, 80.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (220, 10, NULL, 107.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (221, 11, NULL, 62.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (222, 12, NULL, 95.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (223, 13, NULL, 73.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (224, 14, NULL, 116.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (225, 15, NULL, 56.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (226, 16, NULL, 89.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (227, 17, NULL, 64.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (228, 18, NULL, 125.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (229, 19, NULL, 72.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (230, 20, NULL, 100.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (231, 21, NULL, 57.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (232, 22, NULL, 112.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (233, 23, NULL, 77.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (234, 24, NULL, 104.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (235, 25, NULL, 68.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (236, 26, NULL, 119.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (237, 27, NULL, 60.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (238, 28, NULL, 92.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (239, 29, NULL, 81.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (240, 30, NULL, 108.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (241, 1, NULL, 63.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (242, 2, NULL, 96.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (243, 3, NULL, 74.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (244, 4, NULL, 117.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (245, 5, NULL, 59.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (246, 6, NULL, 91.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (247, 7, NULL, 66.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (248, 8, NULL, 123.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (249, 9, NULL, 73.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (250, 10, NULL, 101.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (251, 11, NULL, 58.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (252, 12, NULL, 113.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (253, 13, NULL, 78.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (254, 14, NULL, 105.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (255, 15, NULL, 69.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (256, 16, NULL, 120.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (257, 17, NULL, 61.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (258, 18, NULL, 93.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (259, 19, NULL, 82.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (260, 20, NULL, 109.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (261, 21, NULL, 64.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (262, 22, NULL, 97.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (263, 23, NULL, 75.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (264, 24, NULL, 118.0);
INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor) VALUES (265, 25, NULL, 60.0);

-- ======================================================
-- TROCA (amostra representativa de devoluções)
-- ======================================================
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (10, 'CONCLUIDA', '10/06/2025', '18/06/2025', 19, 'Livro com páginas rasgadas', 11);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (25, 'CONCLUIDA', '15/07/2025', '23/07/2025', 53, 'Capa amassada na entrega', 12);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (48, 'SOLICITADA', '05/09/2025', NULL, 102, 'Cliente pediu troca por outro título', NULL);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (87, 'CONCLUIDA', '20/10/2025', '28/10/2025', 180, 'Edição errada enviada', 13);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (110, 'SOLICITADA', '08/11/2025', NULL, 226, 'Livro danificado no transporte', NULL);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (143, 'CONCLUIDA', '14/12/2025', '22/12/2025', 292, 'Cliente não gostou do conteúdo', 14);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (170, 'SOLICITADA', '17/01/2026', NULL, 346, 'Páginas faltando', NULL);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (195, 'CONCLUIDA', '11/02/2026', '19/02/2026', 396, 'Produto diferente do anunciado', 15);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (215, 'SOLICITADA', '05/03/2026', NULL, 436, 'Defeito de impressão', NULL);
INSERT INTO troca (pedido_id, status, data_solicitacao, data_recebimento, item_pedido_id, motivo, cupom_gerado_id) VALUES (240, 'SOLICITADA', '22/04/2026', NULL, 486, 'Embalagem violada', NULL);

UPDATE troca SET cupom_gerado_id = (SELECT id FROM cupom WHERE codigo = 'TROCA48_10') WHERE id = 3;
UPDATE troca SET cupom_gerado_id = (SELECT id FROM cupom WHERE codigo = 'TROCA110_15') WHERE id = 5;
UPDATE troca SET cupom_gerado_id = (SELECT id FROM cupom WHERE codigo = 'TROCA170_20') WHERE id = 7;
UPDATE troca SET cupom_gerado_id = (SELECT id FROM cupom WHERE codigo = 'TROCA215_25') WHERE id = 9;
UPDATE troca SET cupom_gerado_id = (SELECT id FROM cupom WHERE codigo = 'TROCA240_30') WHERE id = 10;
-- ======================================================
-- VERIFICAÇÃO FINAL
-- ======================================================

-- Total de livros
SELECT COUNT(*) AS total_livros FROM livro;

-- Total de clientes
SELECT COUNT(*) AS total_clientes FROM cliente;

-- Total de pedidos
SELECT COUNT(*) AS total_pedidos FROM pedido;

-- Vendas por mês e categoria (para o gráfico)
SELECT 
    CASE 
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-05' THEN 'Maio/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-06' THEN 'Junho/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-07' THEN 'Julho/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-08' THEN 'Agosto/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-09' THEN 'Setembro/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-10' THEN 'Outubro/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-11' THEN 'Novembro/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2025-12' THEN 'Dezembro/2025'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2026-01' THEN 'Janeiro/2026'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2026-02' THEN 'Fevereiro/2026'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2026-03' THEN 'Março/2026'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2026-04' THEN 'Abril/2026'
        WHEN strftime('%Y-%m', datetime(p.data/1000, 'unixepoch')) = '2026-05' THEN 'Maio/2026'
    END AS mes,
    c.nome AS categoria,
    SUM(ip.quantidade) AS quantidade_vendida
FROM pedido p
JOIN item_pedido ip ON ip.pedido_id = p.id
JOIN livro l ON l.id = ip.livro_id
JOIN livro_categoria lc ON lc.livro_id = l.id
JOIN categoria c ON c.id = lc.categoria_id
WHERE p.status = 'ENTREGUE'
GROUP BY mes, c.nome
ORDER BY p.data, c.nome;
