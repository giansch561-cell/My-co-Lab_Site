USE mycolab_biblioteca;

/*
================================================
MY-CO-LAB LIBRARY
Tabela: temas_indice
Fonte: Índices dos livros
================================================
*/

/*
0001 — Die wundersame Welt der Pilze
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0001', 'Einleitung', 6, 15, 'Introdução', 'introdução,pilze,fungos,micologia', 'alta'),
('0001', 'Hauptgruppen der Pilze', 16, 39, 'Classificação', 'grupos principais,classificação,fungos,pilze', 'muito alta'),
('0001', 'Eßbare Pilze', 40, 64, 'Comestibilidade', 'cogumelos comestíveis,edible mushrooms,essbare pilze,identificação', 'muito alta'),
('0001', 'Giftpilze', 65, 79, 'Segurança', 'cogumelos venenosos,giftpilze,toxicidade,intoxicação', 'muito alta'),
('0001', 'Pilze in Wirklichkeit und Legende', 80, 95, 'História e cultura', 'história,cultura,lendas,mitologia,pilze', 'média'),
('0001', 'Stichwortverzeichnis', 96, NULL, 'Índice remissivo', 'índice,stichwortverzeichnis,referência', 'baixa');


/********************************************/

/*
0002 — Pilze selbst anbauen
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0002', 'Grundlagen', 12, 23, 'Fundamentos', 'fundamentos,fungos,pilze,cultivo,substrato,spawn', 'muito alta'),
('0002', 'Kultur auf Stroh', 24, 53, 'Cultivo', 'palha,stroh,substrato,cultivo,austernpilz', 'muito alta'),
('0002', 'Kultur auf Kaffee', 54, 55, 'Cultivo', 'café,kaffee,borras de café,substrato', 'alta'),
('0002', 'Kultur auf Holz', 56, 111, 'Cultivo', 'madeira,holz,troncos,shiitake,nameko', 'muito alta'),
('0002', 'Kultur auf Kompost', 112, 133, 'Cultivo', 'composto,kompost,champignon,agaricus', 'alta'),
('0002', 'Fertigkulturen', 134, 151, 'Cultivo doméstico', 'culturas prontas,fertigkulturen,kits de cultivo', 'alta'),
('0002', 'Brut selbst herstellen', 152, 157, 'Produção de spawn', 'spawn,pilzbrut,inóculo,laboratório,esterilidade', 'muito alta'),
('0002', 'Ernte', 158, 158, 'Colheita', 'colheita,ernte,ponto de colheita', 'alta'),
('0002', 'Lagerung', 159, 159, 'Pós-colheita', 'armazenamento,lagerung,conservação', 'alta'),
('0002', 'Trocknung', 159, 160, 'Conservação', 'secagem,trocknung,desidratação', 'alta'),
('0002', 'Rezepte', 161, 176, 'Receitas', 'receitas,rezepte,cozinha,cogumelos', 'baixa');


/********************************************/

/*
0003 — Speisepilze selbst anbauen
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0003', 'Leben und Wachsen', 10, 18, 'Biologia', 'vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia', 'muito alta'),
('0003', 'Grundlagen der Pilzzucht', 19, 31, 'Fundamentos de cultivo', 'cultivo,condições de crescimento,sazonalidade,micélio,spawn', 'muito alta'),
('0003', 'Übersicht der Anbaumethoden', 32, 42, 'Métodos de cultivo', 'métodos,cultivo interior,cultivo exterior,equipamentos,kits', 'muito alta'),
('0003', 'Anbau im Freien', 43, 53, 'Cultivo exterior', 'exterior,jardim,madeira,palha,canteiros', 'alta'),
('0003', 'Probleme', 54, 59, 'Problemas e sanidade', 'problemas,pragas,doenças,contaminação,cultivo', 'alta'),
('0003', 'Frühlingspilze', 60, 67, 'Espécies', 'espécies primavera,frühling,sazonalidade', 'média'),
('0003', 'Sommerpilze', 68, 73, 'Espécies', 'espécies verão,sommer,sazonalidade', 'média'),
('0003', 'Herbstpilze', 74, 86, 'Espécies', 'espécies outono,herbst,sazonalidade', 'média'),
('0003', 'Winterpilze', 87, 99, 'Espécies', 'espécies inverno,winter,sazonalidade', 'média'),
('0003', 'Ernte und Verarbeitung', 100, 107, 'Colheita e pós-colheita', 'colheita,processamento,limpeza,preparação,secagem', 'alta');


/********************************************/

/*
0004 — Cogumelos do Norte de Portugal e Galiza
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0004', 'Introdução ao mundo dos fungos', NULL, NULL, 'Micologia geral', 'fungos,cogumelos,micologia,biologia', 'muito alta'),
('0004', 'Identificação de espécies', NULL, NULL, 'Identificação', 'identificação,espécies,nome científico,nome comum', 'muito alta'),
('0004', 'Cogumelos comestíveis', NULL, NULL, 'Comestibilidade', 'comestíveis,alimentação,espécies', 'alta'),
('0004', 'Cogumelos tóxicos', NULL, NULL, 'Segurança', 'tóxicos,venenosos,intoxicação,segurança', 'muito alta'),
('0004', 'Espécies do Norte de Portugal', NULL, NULL, 'Espécies regionais', 'Portugal,Norte de Portugal,espécies,hábitat', 'alta'),
('0004', 'Espécies da Galiza', NULL, NULL, 'Espécies regionais', 'Galiza,espécies,hábitat,distribuição', 'alta'),
('0004', 'Utilização culinária', NULL, NULL, 'Culinária', 'cozinha,receitas,uso culinário,cogumelos', 'média');


/********************************************/

/*
0005 — Cogumelos
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0005', 'O que é um cogumelo?', 10, 11, 'Biologia', 'fungos,cogumelo,micélio,carpóforo', 'muito alta'),
('0005', 'Vida associada às árvores', 12, 13, 'Ecologia', 'árvores,micorrizas,simbiose,floresta', 'alta'),
('0005', 'Cogumelos parasitas', 14, 15, 'Ecologia', 'parasitas,árvores,doenças', 'média'),
('0005', 'Eliminadores de resíduos', 16, 17, 'Ecologia', 'sapróbios,decomposição,matéria orgânica', 'alta'),
('0005', 'Crescimento dos cogumelos', 18, 19, 'Biologia', 'crescimento,micélio,frutificação', 'alta'),
('0005', 'Onde crescem?', 20, 21, 'Habitat', 'habitat,floresta,prado,campo', 'alta'),
('0005', 'Quando crescem?', 28, 29, 'Fenologia', 'época,sazonalidade,chuva,temperatura', 'alta'),
('0005', 'Formação do carpóforo', 32, 33, 'Biologia', 'carpóforo,corpo frutífero,frutificação', 'muito alta'),
('0005', 'Identificação correta', 34, 37, 'Identificação', 'identificação,píleo,lâminas,poros,pé,anel', 'muito alta'),
('0005', 'Cogumelos tóxicos', 38, 44, 'Segurança', 'tóxicos,venenosos,intoxicação,amanitina,muscarina', 'muito alta'),
('0005', 'Conselhos práticos de identificação', 48, 49, 'Identificação', 'conselhos práticos,identificação,apanha', 'alta'),
('0005', 'Cogumelos com tubos e poros', 50, 69, 'Identificação', 'tubos,poros,boletos,boletus', 'alta'),
('0005', 'Cogumelos com lâminas e anel', 70, 91, 'Identificação', 'lâminas,anel,amanita,agaricus', 'alta'),
('0005', 'Cogumelos com lâminas sem anel', 92, 117, 'Identificação', 'lâminas,sem anel,russula,lactarius', 'alta'),
('0005', 'Outros cogumelos', 118, 124, 'Identificação', 'outros cogumelos,formas especiais', 'média'),
('0005', 'Medidas preventivas', 140, 143, 'Segurança', 'prevenção,colheita segura,regras,proteção', 'muito alta'),
('0005', 'Metais pesados e radioatividade', 144, 145, 'Segurança alimentar', 'metais pesados,radioatividade,contaminação', 'alta'),
('0005', 'Preparação e valor nutritivo', 146, 148, 'Culinária e nutrição', 'preparação,valor nutritivo,cozinha', 'média'),
('0005', 'Conservação, secagem e congelação', 149, 150, 'Pós-colheita', 'conservação,secagem,congelação,armazenamento', 'alta'),
('0005', 'Cultivo em palha e madeira', 150, 152, 'Cultivo', 'cultivo,palha,madeira,troncos,substrato', 'alta');


/********************************************/

/*
0006 — Como produzir cogumelos
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0006', 'Introdução', 11, 12, 'Introdução', 'introdução,produção,cogumelos', 'média'),
('0006', 'Os cogumelos ao longo dos tempos', 13, 16, 'História', 'história,cultura,cogumelos', 'média'),
('0006', 'O que são os cogumelos', 17, 20, 'Biologia', 'fungos,micélio,hifas,esporos,basídios', 'muito alta'),
('0006', 'Produção de sementes de cogumelos', 21, 24, 'Cultivo', 'spawn,semente,inóculo,micélio,meio de cultura', 'muito alta'),
('0006', 'Produção de Agaricus sp.', 25, 54, 'Produção', 'agaricus,substrato,compostagem,cobertura,rega,colheita,conservação', 'alta'),
('0006', 'Substrato e compostagem', 25, 32, 'Substrato', 'substrato,composto,compostagem,fermentação,pasteurização', 'muito alta'),
('0006', 'Condições ambientais de cultivo', 33, 36, 'Ambiente', 'temperatura,humidade,co2,ventilação,incubação,frutificação', 'muito alta'),
('0006', 'Camada de cobertura', 37, 40, 'Cultivo', 'cobertura,casing,frutificação,retenção de água,microclima', 'alta'),
('0006', 'Regas', 41, 42, 'Maneio', 'rega,água,humidade,evaporação', 'alta'),
('0006', 'Sanidade e tratamentos', 43, 45, 'Sanidade', 'sanidade,doenças,pragas,tratamentos,prevenção', 'média'),
('0006', 'Produções', 46, 46, 'Produção', 'produção,rendimento,flush,colheitas', 'média'),
('0006', 'Maneio após a colheita', 47, 49, 'Pós-colheita', 'colheita,pós-colheita,qualidade,manuseamento', 'alta'),
('0006', 'Técnicas de conservação', 50, 53, 'Conservação', 'conservação,refrigeração,secagem,armazenamento,atmosfera modificada', 'alta'),
('0006', 'Pragas e doenças', 55, 69, 'Sanidade', 'pragas,doenças,contaminação,agaricus', 'alta'),
('0006', 'Composição química e valor nutritivo', 70, 74, 'Nutrição', 'composição química,valor nutritivo,nutrição', 'média'),
('0006', 'Produção de Pleurotus sp.', 75, 89, 'Produção', 'pleurotus,substrato,cultivo,condições ambientais,pragas,valor nutritivo', 'muito alta'),
('0006', 'Bibliografia utilizada', 91, 91, 'Referência', 'bibliografia,fontes,referências', 'baixa');


/********************************************/

/*
0007 — Pilzführer
*/
INSERT INTO temas_indice
(livro_codigo, tema, pagina_inicio, pagina_fim, categoria, palavras_chave, prioridade)
VALUES
('0007', 'Identificação segura de cogumelos', NULL, NULL, 'Identificação', 'identificação,pilzführer,segurança,cogumelos', 'muito alta'),
('0007', 'Cogumelos comestíveis', NULL, NULL, 'Comestibilidade', 'comestíveis,essbare pilze,consumo', 'alta'),
('0007', 'Cogumelos venenosos', NULL, NULL, 'Segurança', 'venenosos,giftpilze,tóxicos,intoxicação', 'muito alta'),
('0007', 'Características morfológicas', NULL, NULL, 'Morfologia', 'chapéu,lâminas,poros,pé,anel,volva', 'muito alta'),
('0007', 'Habitat e época de frutificação', NULL, NULL, 'Ecologia', 'habitat,época,floresta,prado,sazonalidade', 'alta'),
('0007', 'Conselhos de consumo seguro', NULL, NULL, 'Segurança alimentar', 'consumo seguro,prevenção,risco,apanha', 'muito alta');
