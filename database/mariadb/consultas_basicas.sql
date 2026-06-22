USE mycolab_biblioteca;

-- Ver todos os livros
SELECT codigo, titulo, idioma, categoria_principal
FROM livros;

-- Ver todos os temas
SELECT livro_codigo, tema, pagina_inicio, pagina_fim, categoria
FROM temas_indice;

-- Procurar por palavra-chave
SELECT l.codigo, l.titulo, t.tema, t.pagina_inicio, t.pagina_fim, t.categoria
FROM temas_indice t
JOIN livros l ON l.codigo = t.livro_codigo
WHERE t.palavras_chave LIKE '%pleurotus%'
   OR t.tema LIKE '%pleurotus%';

-- Procurar temas de cultivo
SELECT l.codigo, l.titulo, t.tema, t.pagina_inicio, t.pagina_fim
FROM temas_indice t
JOIN livros l ON l.codigo = t.livro_codigo
WHERE t.categoria = 'Cultivo'
   OR t.categoria = 'Produção';
