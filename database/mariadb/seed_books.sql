USE mycolab_biblioteca;

INSERT INTO livros
(codigo, titulo, subtitulo, autor, editora, ano, idioma, isbn, categoria_principal, estado, observacoes)
VALUES
('0001', 'Die wundersame Welt der Pilze', 'The Wonderful World of Mushrooms and Other Fungi', 'Helen L. Pursey', 'Albatros Verlag AG', '1977', 'Alemão', '0-600-36248-5', 'Micologia geral', 'indexado', 'Introdução geral à biologia, classificação, cogumelos comestíveis e venenosos.'),

('0002', 'Pilze selbst anbauen', 'In Haus und Garten', 'Nicola Krämer; Jolanda Englbrecht', 'Ulmer', '2021', 'Alemão', '978-3-8001-0393-5', 'Cultivo de cogumelos', 'indexado', 'Guia prático de cultivo doméstico, substratos, espécies, spawn, colheita e conservação.'),

('0003', 'Speisepilze selbst anbauen', 'Für drinnen und draußen', 'Stefanie Goldscheider', 'BLV / Gräfe und Unzer Verlag', '2021', 'Alemão', '978-3-8354-1805-9', 'Cultivo de cogumelos comestíveis', 'indexado', 'Manual prático para cultivo interior e exterior, espécies, problemas, colheita e processamento.'),

('0004', 'Cogumelos do Norte de Portugal e Galiza', NULL, 'Marisa Castro; Vítor López Román', 'MEL Editores', '2009', 'Português', '978-989-635-067-3', 'Identificação de espécies', 'indexado', 'Guia regional de espécies do Norte de Portugal e Galiza.'),

('0005', 'Cogumelos', 'Como identificar, classificar e apanhar cogumelos. Guia de cogumelos venenosos e comestíveis.', 'Edmund Garnweidner', 'Everest Editora', '1999', 'Português', '972-750-418-3', 'Identificação e segurança', 'indexado', 'Guia de identificação, toxicologia, colheita, conservação e cultivo básico.'),

('0006', 'Como produzir cogumelos', NULL, 'António Ferreira Borges', 'Litexa Editora', '2006', 'Português', '978-972-578-176-0', 'Produção de cogumelos', 'indexado', 'Livro prático sobre produção de cogumelos, com foco em Agaricus e Pleurotus.'),

('0007', 'Pilzführer', 'Sicher bestimmen, gefahrlos geniessen', NULL, NULL, NULL, 'Alemão', NULL, 'Identificação e segurança', 'indexado', 'Guia de campo para identificação segura e consumo sem risco.');
