USE mycolab_biblioteca;

CREATE TABLE IF NOT EXISTS modulos_estudo (
    codigo VARCHAR(10) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    fase VARCHAR(100),
    objetivo TEXT
);

CREATE TABLE IF NOT EXISTS modulos_fontes (
    id INT AUTO_INCREMENT PRIMARY KEY,

    modulo_codigo VARCHAR(10),

    livro_codigo VARCHAR(10),

    tema_id INT,

    prioridade VARCHAR(50),

    observacoes TEXT,

    FOREIGN KEY (modulo_codigo)
        REFERENCES modulos_estudo(codigo),

    FOREIGN KEY (livro_codigo)
        REFERENCES livros(codigo),

    FOREIGN KEY (tema_id)
        REFERENCES temas_indice(id)
);
