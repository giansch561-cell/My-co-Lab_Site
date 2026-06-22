USE mycolab_biblioteca;

INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0001', 'Einleitung', 6, 15, 'Introdução', 'introdução,fungos,pilze', 'alta'),
('0001', 'Hauptgruppen der Pilze', 16, 39, 'Classificação', 'grupos,classificação,biologia', 'muito alta'),
('0001', 'Eßbare Pilze', 40, 64, 'Comestibilidade', 'comestíveis,identificação', 'muito alta'),
('0001', 'Giftpilze', 65, 79, 'Segurança', 'venenosos,tóxicos,identificação', 'muito alta'),

('0002', 'Grundlagen', 12, 23, 'Fundamentos', 'cultivo,fungos,substrato,spawn', 'muito alta'),
('0002', 'Kultur auf Stroh', 24, 53, 'Cultivo', 'palha,substrato,cultivo', 'muito alta'),
('0002', 'Kultur auf Kaffee', 54, 55, 'Cultivo', 'café,borras,cultivo', 'alta'),
('0002', 'Kultur auf Holz', 56, 111, 'Cultivo', 'madeira,troncos,shiitake', 'muito alta'),

('0006', 'O que são os cogumelos', 17, 20, 'Biologia', 'fungos,micélio,hifas,esporos', 'muito alta'),
('0006', 'Produção de sementes de cogumelos', 21, 24, 'Cultivo', 'spawn,semente,inóculo,micélio', 'muito alta'),
('0006', 'Produção de Agaricus sp.', 25, 54, 'Produção', 'agaricus,substrato,compostagem,cobertura', 'alta'),
('0006', 'Produção de Pleurotus sp.', 75, 89, 'Produção', 'pleurotus,cultivo,substrato', 'muito alta');
