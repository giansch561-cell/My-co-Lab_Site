CREATE DATABASE IF NOT EXISTS mycolab_biblioteca
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE mycolab_biblioteca;

CREATE TABLE IF NOT EXISTS livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    titulo VARCHAR(255) NOT NULL,
    subtitulo VARCHAR(255),
    autor VARCHAR(255),
    editora VARCHAR(255),
    ano VARCHAR(50),
    idioma VARCHAR(50),
    isbn VARCHAR(50),
    categoria_principal VARCHAR(100),
    estado VARCHAR(100),
    observacoes TEXT
);

CREATE TABLE IF NOT EXISTS temas_indice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_codigo VARCHAR(10) NOT NULL,
    tema VARCHAR(255) NOT NULL,
    pagina_inicio INT,
    pagina_fim INT,
    categoria VARCHAR(100),
    palavras_chave TEXT,
    prioridade VARCHAR(50),
    FOREIGN KEY (livro_codigo) REFERENCES livros(codigo)
);
