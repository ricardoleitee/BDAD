pragma foreign_keys=on;
.mode columns
.headers on

DROP TABLE LikePagina;
DROP TABLE LikeComentario;
DROP TABLE LikeEvento;
DROP TABLE LikeFoto;
DROP TABLE Guestbook;
DROP TABLE FotoPagina;
DROP TABLE FotoEvento;
DROP TABLE ComentarioFoto;
DROP TABLE ComentarioEvento;
DROP TABLE Foto;
DROP TABLE Comentario;
DROP TABLE Evento;
DROP TABLE Admin;
DROP TABLE PaginaLocal;
DROP TABLE Segue;
DROP TABLE Utilizador;

CREATE TABLE Utilizador(
username NVARCHAR2(40) NOT NULL UNIQUE PRIMARY KEY,
password NVARCHAR2(32) NOT NULL,
idade INTEGER(2) CHECK (idade>0 AND idade<136),
localidade NVARCHAR2(80),
sexo NVARCHAR2(40) NOT NULL CHECK (sexo=="M" OR sexo=="F"),
latitude FLOAT,
longitude FLOAT
);

CREATE TABLE Segue(
user1 NVARHCAR2(40) NOT NULL REFERENCES Utilizador(username),
user2 NVARCHAR2(40) NOT NULL REFERENCES Utilizador(username),
CONSTRAINT pk_segue PRIMARY KEY (user1,user2)
);

CREATE TABLE Admin(
username NVARCHAR2(80) REFERENCES Utilizador(username),
nome NVARCHAR2(80) REFERENCES PaginaLocal(nome),
CONSTRAINT pk_Administrador PRIMARY KEY (username,nome)
);

CREATE TABLE PaginaLocal(
nome NVARCHAR2(80) NOT NULL UNIQUE PRIMARY KEY,
descricao NVARCHAR2(1000),
morada NVARCHAR2(200),
localidade NVARCHAR2(80),
capacidade INTEGER CHECK(capacidade > 0),
latitude FLOAT,
longitude FLOAT,
tipo NVARCHAR2(20)
);

CREATE TABLE Evento(
idEvento INTEGER NOT NULL UNIQUE PRIMARY KEY,
nome NVARCHAR2(128) NOT NULL,
descricao NVARCHAR2(1000),
dataInicio DATE,
dataFim DATE CHECK (dataFim > dataInicio),
nomePagina NVARCHAR2(80) REFERENCES PaginaLocal(nome),
precoH FLOAT CHECK (precoH>=0),
precoM FLOAT CHECK (precoM>=0)
);


CREATE TABLE Comentario(
idComentario INTEGER NOT NULL UNIQUE PRIMARY KEY,
texto NVARCHAR2(1000) NOT NULL,
username NVARCHAR2(40) REFERENCES Utilizador(username)
);

CREATE TABLE Foto(
url NVARCHAR2(200) UNIQUE NOT NULL PRIMARY KEY,
descricao NVARCHAR2(1000),
username NVARCHAR2(40) NOT NULL REFERENCES Utilizador(username)
);

CREATE TABLE ComentarioEvento(
idComentarioEvento INTEGER NOT NULL UNIQUE PRIMARY KEY REFERENCES Comentario(idComentario),
idEvento INTEGER NOT NULL REFERENCES Evento(idEvento)
);

CREATE TABLE ComentarioFoto(
idComentarioFoto INTEGER NOT NULL UNIQUE PRIMARY KEY REFERENCES Comentario(idComentario),
url NVARHCAR2(200) NOT NULL REFERENCES Foto(url)
);

CREATE TABLE FotoEvento(
idFotoEvento NVARCHAR2(200) NOT NULL UNIQUE PRIMARY KEY REFERENCES Foto(url),
idEvento INTEGER NOT NULL REFERENCES Evento(idEvento)
);

CREATE TABLE FotoPagina(
idFotoPagina NVARCHAR2(200) NOT NULL UNIQUE PRIMARY KEY REFERENCES Foto(url),
nome NVARCHAR2(80) NOT NULL REFERENCES PaginaLocal(nome)
);

CREATE TABLE Guestbook(
username NVARCHAR2(80) NOT NULL REFERENCES Utilizador(username),
idEvento INTEGER NOT NULL REFERENCES Evento(idEvento),
checkin NVARCHAR2(500),
CONSTRAINT pk_Guestbook PRIMARY KEY (username, idEvento)
);

CREATE TABLE LikeFoto(
username NVARCHAR2(80) REFERENCES Utilizador(username),
url NVARCHAR2(200) REFERENCES Foto(url),
CONSTRAINT pk_LikeFoto PRIMARY KEY (username,url)
);

CREATE TABLE LikeEvento(
username NVARCHAR2(80) REFERENCES Utilizador(username),
idEvento INTEGER REFERENCES Evento(idEvento),
CONSTRAINT pk_LikeEvento PRIMARY KEY (username,idEvento)
);

CREATE TABLE LikeComentario(
username NVARCHAR2(80) REFERENCES Utilizador(username),
idComentario INTEGER REFERENCES Comentario(idComentario),
CONSTRAINT pk_LikeComentario PRIMARY KEY (username,idComentario)
);

CREATE TABLE LikePagina(
username NVARCHAR2(80) REFERENCES Utilizador(username),
nome NVARCHAR2(80) REFERENCES PaginaLocal(nome),
CONSTRAINT pk_LikePagina PRIMARY KEY (username,nome)
);


INSERT INTO Utilizador VALUES ("João Gil","06911e2e8c10e17c9cf2c9778d1f07d8f01aeba94b60f6243018687bf80a87e1",24,"Vila Real","M",41.176708,-8.589045);
INSERT INTO Utilizador VALUES ("Sara Dinis","042462d713067fd9274b9631dc343731a64f326010ac1d2ad95fa848021b9d81",27,"Vila Real","F",41.300711,-7.729115);
INSERT INTO Utilizador VALUES ("Isabel Mendes", "3e76e492e953aab2550618f520ab6ea8fe8585713e85c4a3ff35b1d8bcf5b45a", 18, "Vila Real", "F", 41.304368,-7.734966);
INSERT INTO Utilizador VALUES ("João Nuno", "2f0a4604bda9a5141233bac8675ae63756dff86b0fed2bc0147485eced91adc6", 30, "Vila Real", "M", 41.311114,-7.736607);
INSERT INTO Utilizador VALUES ("Carla Baía", "f35eaaf7e04e119454a4e3ac6e5de922589845d24f62da82ff25406aeea4207b", 45, "Vila Real", "F", 41.300673,-7.761418);
INSERT INTO Utilizador VALUES ("Raquel Bombardo", "26fb1bbeba622925f66270e0b938432cf4ae41b9a6dbd655ea557a235ec184a9", 23, "Vila Real", "F", 41.312561,-7.76292);
INSERT INTO Utilizador VALUES ("Miguel Mimoso", "9a3708ed8ee6137b3780e926c314ad6c0583e297baea15fe52aa81fb69ca09eb", 28, "Vila Real", "M", 41.317819,-7.782371);
INSERT INTO Utilizador VALUES ("Afonso Guimarães", "e52569fa28bd0bca4e82c8d1f341d81bd415ebc2666117775a48ee83a413f146", 23, "Vila Real", "M", 41.568518,-8.457591);

INSERT INTO Utilizador VALUES ("Ana Montana", "f8c4ed806bcd3e2b986889860c469436d624b734431d9b6b85449135b98bd283", 29, "Vila Real", "F", 41.545673,-8.426177);

INSERT INTO Utilizador VALUES ("Ricardo Leite","d86d83ac7e01a274d558081900f8644e76a45e8da9d22df0a6eb8745f9a3588f",23,"Aveiro","M",41.183644,-8.59957);
INSERT INTO Utilizador VALUES ("Rita Almeida", "254f076f8c8ae21e56d92eb3bb0f70abd2b4d11f2fc0cac0c558b58c804e2fa7", 22, "Aveiro", "F", 40.638243,-8.654631);
INSERT INTO Utilizador VALUES ("Rui Leite", "c00a9857fa711e3ae486382a294a845115c925425a8dad2b40e41264caf8fd84", 16, "Aveiro", "M", 40.639932,-8.653145);
INSERT INTO Utilizador VALUES ("Nuno Taborda", "fd11efc892877007337723b08efa44a05409847ba7d7cc57d62cfd20e1dfd78a", 25, "Aveiro", "M", 40.642871,-8.650307);
INSERT INTO Utilizador VALUES ("André Patarrana", "a0c794797ca59714ec8990087c235ebc560616f8ab6b23129ec32b3909e1a99c", 31, "Aveiro", "M", 40.646266,-8.640898);
INSERT INTO Utilizador VALUES ("Raquel Fonseca", "07dfb471873f76aa7486062f02d4f3118e856057d17a80bdb3691f31093c7395", 26, "Aveiro", "F", 41.556766,-8.426804);

INSERT INTO Utilizador VALUES ("Duarte Brandão","8169f58695d90eee2de5958ff975e62c11062ad7926beb2e1bc477cf52189953",20,"Porto","M",41.765086,-8.583238);
INSERT INTO Utilizador VALUES ("Fernando José","55a9f4f8994b1bbf2058ea38c8efb6c459000814d5f39c087002571639e6230e",15,"Porto","M",41.070547,-8.654794);
INSERT INTO Utilizador VALUES ("Maria Sousa","b268d8081ef89a553f8ab1bb7dda74ce43d893cce804350aa11cc42110732689",27,"Porto","F",41.180499,-8.652743);
INSERT INTO Utilizador VALUES ("Pedro João","453cb9130c89673ba0e53d31859accec6565a1eb31401d98e8fa3a3153edbb92",21,"Porto","F",41.158528,-8.611491);
INSERT INTO Utilizador VALUES ("Maria José","b0eec4dc8ae95ca33e6aad276e2ca7c971f7c18c3b020bffc8d7f3b233df2035",23,"Porto","F",41.162288,-8.652743);
INSERT INTO Utilizador VALUES ("Joana Rita","11feea741aba68df7160f20ac26ea50910b6d5c78089d4bf5d8f62c7aa8064e9",21,"Porto","F",41.156427,-8.633013);
INSERT INTO Utilizador VALUES ("Maria João","5a1f4cea69f41313edc65bf404c277fdd79e2f2ee5092edf495e97e7f84fdedf",22,"Porto","F",41.180499,-8.691977);
INSERT INTO Utilizador VALUES ("Rui Pedro","73817c4b860345cc31852898662491aa4e50d286d3eafef3e347e39dad2a20ad",32,"Porto","M",41.160293,-8.65115);
INSERT INTO Utilizador VALUES ("Rita João","5a1f4cea69f41313edc65bf404c277fdd79e2f2ee5092edf495e97e7f84fdedf",22,"Porto","F",41.180499,-8.691977);
INSERT INTO Utilizador VALUES ("Carolina João","e3920dd646637cc2370928bae141fb2774f5fd44060680d3768896b56cba0ad1",24,"Porto","F",41.154287,-8.62236);
INSERT INTO Utilizador VALUES ("Paula Martins","08bb09ffd82084c3bd2c56a91eba4a2212721e61cf01f97fece0679df10ac194",27,"Porto","F",41.153519,-8.621973);
INSERT INTO Utilizador VALUES ("João Pedro","78cc5e9dd4b1fbee7962ac9b1c41892fe66d09bb76268bc408d0bc80cf768171",22,"Porto","M",41.156605,-8.605859);
INSERT INTO Utilizador VALUES ("Patricia João","fdae909bc34152713a2a20f0acdff3cee2e4aff069268ff8af6eceefa01e1e11",20,"Porto","F",41.155676,-8.629054);
INSERT INTO Utilizador VALUES ("António Rodrigues", "e3ed9515e1d56a8dd47030d6679cd6196dc5265b0f4f5461e188f85951d87a0e", 19, "Porto", "M", 41.560422,-8.423655);

INSERT INTO Utilizador VALUES ("Luis Lima","eba1bfc55be833c714ab63f101831ade486a5132a92506774b95fcfc272e636b",19,"Lisboa","M",41.1774,-8.588468);
INSERT INTO Utilizador VALUES ("Mariana Machado","a53b75ffdafd493eebc6642599a7e3547e5a7430be507e058e585786ef232bef",24,"Lisboa","F",41.190661,-8.704659);
INSERT INTO Utilizador VALUES ("Rafael de Matos", "49b0cb37fd471a4875386ee9aa820b9abc1b1d641ab2d3e63cad360419a063f5", 24, "Lisboa", "M", 38.709039,-9.401261);
INSERT INTO Utilizador VALUES ("Cristina Leonor", "2eab0a269b604a06784890ef34996ea7c350eb452224396d1fc898a79d24f7bd", 37, "Lisboa", "F", 38.726103,-9.151934);
INSERT INTO Utilizador VALUES ("Diana Pinheiro", "32e62323a2e2bd68e03a044c2d1a9354ead345a5dd97534efebfb9d4fbca2a88", 29, "Lisboa", "F", 38.730811,-9.158881);
INSERT INTO Utilizador VALUES ("Pedro Soares", "081890a7d4a85935cad5fb27a297534bfb2c7a976fdf219e52828fcc6cfdaf8f", 35, "Lisboa", "M", 38.738724,-9.147353);
INSERT INTO Utilizador VALUES ("Renato Pereira", "46a1b3eebaeff6abd9686cf2f28df4b575ee7f8a9484382de2e06af90c84016c", 40, "Lisboa", "M", 38.744825,-9.174427);
INSERT INTO Utilizador VALUES ("Sara Santos", "78ef68585c812f18ea10c4d195a7064dfa29dd2c169770a982047fab02e2bd56", 22, "Lisboa", "F", 41.561522,-8.434475);

--SEGUIDORES

INSERT INTO Segue VALUES ("João Gil","João Gil");
INSERT INTO Segue VALUES ("João Gil","Sara Dinis");
INSERT INTO Segue VALUES ("João Gil","Isabel Mendes");
INSERT INTO Segue VALUES ("João Gil","João Nuno");
INSERT INTO Segue VALUES ("João Gil","Carla Baía");
INSERT INTO Segue VALUES ("João Gil","Raquel Bombardo");
INSERT INTO Segue VALUES ("João Gil","Miguel Mimoso");
INSERT INTO Segue VALUES ("João Gil","Ricardo Leite");
INSERT INTO Segue VALUES ("João Gil","Rita Almeida");
INSERT INTO Segue VALUES ("João Gil","Rafael de Matos");
INSERT INTO Segue VALUES ("João Gil","Luis Lima");
INSERT INTO Segue VALUES ("Sara Dinis","Sara Dinis");
INSERT INTO Segue VALUES ("Sara Dinis","João Gil");
INSERT INTO Segue VALUES ("Sara Dinis","Isabel Mendes");
INSERT INTO Segue VALUES ("Sara Dinis","João Nuno");
INSERT INTO Segue VALUES ("Sara Dinis","Carla Baía");
INSERT INTO Segue VALUES ("Sara Dinis","Raquel Bombardo");
INSERT INTO Segue VALUES ("Sara Dinis","Miguel Mimoso");
INSERT INTO Segue VALUES ("Isabel Mendes","Isabel Mendes");
INSERT INTO Segue VALUES ("Isabel Mendes","João Gil");
INSERT INTO Segue VALUES ("Isabel Mendes","Sara Dinis");
INSERT INTO Segue VALUES ("Isabel Mendes","João Nuno");
INSERT INTO Segue VALUES ("Isabel Mendes","Carla Baía");
INSERT INTO Segue VALUES ("Isabel Mendes","Raquel Bombardo");
INSERT INTO Segue VALUES ("Isabel Mendes","Miguel Mimoso");
INSERT INTO Segue VALUES ("João Nuno","João Nuno");
INSERT INTO Segue VALUES ("João Nuno","João Gil");
INSERT INTO Segue VALUES ("João Nuno","Sara Dinis");
INSERT INTO Segue VALUES ("João Nuno","Isabel Mendes");
INSERT INTO Segue VALUES ("Carla Baía","Carla Baía");
INSERT INTO Segue VALUES ("Carla Baía","Miguel Mimoso");
INSERT INTO Segue VALUES ("Raquel Bombardo","Raquel Bombardo");
INSERT INTO Segue VALUES ("Miguel Mimoso","Miguel Mimoso");
INSERT INTO Segue VALUES ("Miguel Mimoso","Carla Baía");
INSERT INTO Segue VALUES ("Miguel Mimoso","João Gil");
INSERT INTO Segue VALUES ("Ricardo Leite","Ricardo Leite");
INSERT INTO Segue VALUES ("Ricardo Leite","João Gil");
INSERT INTO Segue VALUES ("Ricardo Leite","Rafael de Matos");
INSERT INTO Segue VALUES ("Ricardo Leite","Luis Lima");
INSERT INTO Segue VALUES ("Ricardo Leite","Rita Almeida");
INSERT INTO Segue VALUES ("Ricardo Leite","Rui Leite");
INSERT INTO Segue VALUES ("Ricardo Leite","Nuno Taborda");
INSERT INTO Segue VALUES ("Ricardo Leite","André Patarrana");
INSERT INTO Segue VALUES ("Rita Almeida","Rita Almeida");
INSERT INTO Segue VALUES ("Rita Almeida","Ricardo Leite");
INSERT INTO Segue VALUES ("Rui Leite","Rui Leite");
INSERT INTO Segue VALUES ("Nuno Taborda","Nuno Taborda");
INSERT INTO Segue VALUES ("André Patarrana","André Patarrana");
INSERT INTO Segue VALUES ("Duarte Brandão","Duarte Brandão");
INSERT INTO Segue VALUES ("Duarte Brandão","Fernando José");
INSERT INTO Segue VALUES ("Duarte Brandão","Maria Sousa");
INSERT INTO Segue VALUES ("Duarte Brandão","Pedro João");
INSERT INTO Segue VALUES ("Duarte Brandão","Maria José");
INSERT INTO Segue VALUES ("Duarte Brandão","Joana Rita");
INSERT INTO Segue VALUES ("Duarte Brandão","Maria João");
INSERT INTO Segue VALUES ("Duarte Brandão","Rui Pedro");
INSERT INTO Segue VALUES ("Fernando José","Fernando José");
INSERT INTO Segue VALUES ("Fernando José","Maria José");
INSERT INTO Segue VALUES ("Fernando José","Joana Rita");
INSERT INTO Segue VALUES ("Maria Sousa","Maria Sousa");
INSERT INTO Segue VALUES ("Maria Sousa","Duarte Brandão");
INSERT INTO Segue VALUES ("Pedro João","Pedro João");
INSERT INTO Segue VALUES ("Pedro João","Joana Rita");
INSERT INTO Segue VALUES ("Pedro João","Maria José");
INSERT INTO Segue VALUES ("Maria José","Maria José");
INSERT INTO Segue VALUES ("Maria José","Duarte Brandão");
INSERT INTO Segue VALUES ("Joana Rita","Joana Rita");
INSERT INTO Segue VALUES ("Joana Rita","Duarte Brandão");
INSERT INTO Segue VALUES ("Maria João","Maria João");
INSERT INTO Segue VALUES ("Maria João","Duarte Brandão");
INSERT INTO Segue VALUES ("Rui Pedro","Rui Pedro");
INSERT INTO Segue VALUES ("Rita João","Rita João");
INSERT INTO Segue VALUES ("Rita João","Carolina João");
INSERT INTO Segue VALUES ("Rita João","Paula Martins");
INSERT INTO Segue VALUES ("Rita João","João Pedro");
INSERT INTO Segue VALUES ("Rita João","Patricia João");
INSERT INTO Segue VALUES ("Carolina João","Carolina João");
INSERT INTO Segue VALUES ("Carolina João","Rita João");
INSERT INTO Segue VALUES ("Carolina João","Paula Martins");
INSERT INTO Segue VALUES ("Carolina João","João Pedro");
INSERT INTO Segue VALUES ("Carolina João","Patricia João");
INSERT INTO Segue VALUES ("Paula Martins","Paula Martins");
INSERT INTO Segue VALUES ("Paula Martins","João Pedro");
INSERT INTO Segue VALUES ("Paula Martins","Patricia João");
INSERT INTO Segue VALUES ("João Pedro","João Pedro");
INSERT INTO Segue VALUES ("Patricia João","Patricia João");
INSERT INTO Segue VALUES ("Luis Lima","Luis Lima");
INSERT INTO Segue VALUES ("Luis Lima","João Gil");
INSERT INTO Segue VALUES ("Luis Lima","Ricardo Leite");
INSERT INTO Segue VALUES ("Luis Lima","Miguel Mimoso");
INSERT INTO Segue VALUES ("Luis Lima","Rafael de Matos");
INSERT INTO Segue VALUES ("Mariana Machado","Mariana Machado");
INSERT INTO Segue VALUES ("Rafael de Matos","Rafael de Matos");
INSERT INTO Segue VALUES ("Rafael de Matos","Cristina Leonor");
INSERT INTO Segue VALUES ("Rafael de Matos","Diana Pinheiro");
INSERT INTO Segue VALUES ("Rafael de Matos","Pedro Soares");
INSERT INTO Segue VALUES ("Rafael de Matos","Renato Pereira");
INSERT INTO Segue VALUES ("Rafael de Matos","Ana Montana");
INSERT INTO Segue VALUES ("Rafael de Matos","Raquel Fonseca");
INSERT INTO Segue VALUES ("Rafael de Matos","António Rodrigues");
INSERT INTO Segue VALUES ("Rafael de Matos","Sara Santos");
INSERT INTO Segue VALUES ("Rafael de Matos","Afonso Guimarães");
INSERT INTO Segue VALUES ("Rafael de Matos","João Gil");
INSERT INTO Segue VALUES ("Rafael de Matos","Miguel Mimoso");
INSERT INTO Segue VALUES ("Rafael de Matos","Luis Lima");
INSERT INTO Segue VALUES ("Rafael de Matos","Rita Almeida");
INSERT INTO Segue VALUES ("Rafael de Matos","Isabel Mendes");
INSERT INTO Segue VALUES ("Rafael de Matos","Carla Baía");
INSERT INTO Segue VALUES ("Cristina Leonor","Cristina Leonor");
INSERT INTO Segue VALUES ("Diana Pinheiro","Diana Pinheiro");
INSERT INTO Segue VALUES ("Pedro Soares","Pedro Soares");
INSERT INTO Segue VALUES ("Renato Pereira","Renato Pereira");
INSERT INTO Segue VALUES ("Ana Montana","Ana Montana");
INSERT INTO Segue VALUES ("Raquel Fonseca","Raquel Fonseca");
INSERT INTO Segue VALUES ("António Rodrigues","António Rodrigues");
INSERT INTO Segue VALUES ("Sara Santos","Sara Santos");
INSERT INTO Segue VALUES ("Afonso Guimarães","Afonso Guimarães");


--PAGINASLOCAIS

INSERT INTO PaginaLocal VALUES ("Grupo Andromeda","O Twins é das discotecas mais antigas do Porto com mais de 20 anos de história.","Rua Paredes Adoufe, 5000, Vila Real, Portugal","Vila Real", 2000,41.361333,-7.72988,"discoteca");
INSERT INTO PaginaLocal VALUES ("B-Club","No B-Club consegues as noites mais divertidas!","Rua D. Pedro Castro - Loja 6, 5000-669 Vila Real, Vila Real, Portugal","Vila Real", 1500,41.295917,-7.746504,"discoteca"); 
INSERT INTO PaginaLocal VALUES ("Quilate Bar","Não incomoda os vizinhos!","Av. Cidade de Orense, lote 1 loja 5, 5000 Vila Real, Vila Real, Portugal","Vila Real", 500,41.300413,-7.750597,"bar");
INSERT INTO PaginaLocal VALUES ("Kopos Bar","É sempre a abrir noite fora!","Largo do Pioledo, 5000 Vila Real Vila Real, Vila Real, Portugal","Vila Real", 550,41.30029,-7.744254,"bar");


INSERT INTO PaginaLocal VALUES ("Estação da Luz","Discoteca de referência do distrito de Aveiro","Rua Direita, Quintãs, Aveiro, Portugal","Aveiro", 1750, 40.5753,-8.622691,"discoteca");
INSERT INTO PaginaLocal VALUES ("NB Club Aveiro","Espaço misto com ambiente jovem moderno","Rua Caís do Paraíso 9, 3810, Aveiro, Portugal","Aveiro", 1500, 40.639859,-8.658809,"discoteca");
INSERT INTO PaginaLocal VALUES ("Vinil Bar","Ambiente único com rock à mistura!","Rua António Carlos Vidal, 3840-410 Vagos, Aveiro, Portugal","Aveiro", 500, 40.554125,-8.680815,"bar");          

INSERT INTO PaginaLocal VALUES ("Twins Foz","O Twins é das discotecas mais antigas do Porto com mais de 20 anos de história.","Rua Passeio Alegre 1000, 4150-574 Foz do Douro - Porto, Portugal","Porto",1700,41.180499,-8.691977,"discoteca");
INSERT INTO PaginaLocal VALUES ("Eskada Porto","Discoteca do Grupo Eskada, a irmã mais nova da famosa discoteca estabelecida em Vizela, abriu as portas em 2013 no Porto com remodelação do espaço.","Rua Alegria 611, 4000 Porto, Portugal","Porto",1500,41.14923,-8.672453,"discoteca");
INSERT INTO PaginaLocal VALUES ("VILLA Porto","Famosa pelas suas segundas feiras extravagantes, o VILLA Porto é das maiores discotecas do Porto, com 3 pisos, localizada no centro.","Rua Passos Manuel 259, 4000 Porto, Portugal","Porto",1300,41.1557,-8.602729,"discoteca");
INSERT INTO PaginaLocal VALUES ("Gare","O Gare é uma discoteca do Porto conhecida pelas suas festas alternativas de Drum&Bass e Dubstep.","Rua da Madeira 182, 4000-330 Porto, Portugal","Porto",1000,41.145857,-8.60954,"discoteca");
INSERT INTO PaginaLocal VALUES ("Pitch","Conhecido pelas suas quartas feiras com as festas do BIBA A BAIXA, o Pitch é das melhores discotecas da Baixa do Porto","Rua Passos Manuel 34, 4000 Porto, Portugal","Porto",1300,41.147173,-8.608182,"discoteca");
INSERT INTO PaginaLocal VALUES ("Optimus Primavera Sound","Melhor Festival do Porto","Paque da Cidade, Porto, Portugal","Porto",50000,41.172254,-8.684967,"festival");

INSERT INTO PaginaLocal VALUES ("BBC","Situado numa das zonas maior movimento nocturno da cidade de Lisboa e com uma vista deslumbrante sobre o rio!","Avenida Brasília Pavilhão Poente, 1300-598 Lisboa","Lisboa",2000,38.696135,-9.192161,"discoteca");
INSERT INTO PaginaLocal VALUES ("SKY","As noites mais luxuosas são aqui!","Rua Artilharia 1, Lisboa, Portugal","Lisboa",1500,38.721574,-9.146985,"discoteca");
INSERT INTO PaginaLocal VALUES ("Hard Rock Cafe Lisboa","Hard Rock Cafe Lisboa completes the ultimate Discovery of our Modern Times and launches you into an atmosphere of electrifying and priceless rock n’ roll memorabilia","Avenida da Liberdade, 2, 1250-144, Lisboa, Portugal","Lisboa",400,38.721594,-9.14577,"cafe");


--ADMINISTRADORES

INSERT INTO Admin VALUES ("João Gil","Grupo Andromeda");
INSERT INTO Admin VALUES ("João Gil","B-Club");
INSERT INTO Admin VALUES ("Sara Dinis","Quilate Bar");
INSERT INTO Admin VALUES ("Sara Dinis","Kopos Bar");

INSERT INTO Admin VALUES ("Rita Almeida","Estação da Luz");
INSERT INTO Admin VALUES ("Ricardo Leite","NB Club Aveiro");
INSERT INTO Admin VALUES ("Ricardo Leite","Vinil Bar");

INSERT INTO Admin VALUES ("Duarte Brandão","Twins Foz");
INSERT INTO Admin VALUES ("Duarte Brandão","Eskada Porto");
INSERT INTO Admin VALUES ("Duarte Brandão","VILLA Porto");
INSERT INTO Admin VALUES ("Carolina João","Gare");
INSERT INTO Admin VALUES ("Carolina João","Pitch");
INSERT INTO Admin VALUES ("Paula Martins","Optimus Primavera Sound");

INSERT INTO Admin VALUES ("Rafael de Matos","BBC");
INSERT INTO Admin VALUES ("Rafael de Matos","SKY");
INSERT INTO Admin VALUES ("Rafael de Matos","Hard Rock Cafe Lisboa");

--EVENTOS

INSERT INTO Evento VALUES (1,"Ladies Night","Noite das Mulheres","2013-06-07 23:59:59.000","2013-06-08 06:00:00.000","Grupo Andromeda",10.0,0.0);
INSERT INTO Evento VALUES (2,"Final de Aulas","Festa de fim de Aulas","2013-06-18 23:59:59.000","2013-06-19 06:00:00.000","B-Club",7.5, 7.5);
INSERT INTO Evento VALUES (3,"Bass Delight","Bass and Drum","2013-06-26 23:59:59.000","2013-06-27 06:00:00.000","B-Club",10.0,8.0);
INSERT INTO Evento VALUES (4,"B-Ladies","Elas é que mandam","2013-06-21 23:59:59.000","2013-06-22 06:00:00.000","B-Club",8.0,0.0);
INSERT INTO Evento VALUES (5,"SWAG","Estilo, atitude, inspirar respeito","2013-06-08 23:59:59.000","2013-06-09 06:00:00.000","Quilate Bar",5.0,5.0);
INSERT INTO Evento VALUES (6,"MISSA","Mulher interessante, sensual, sexy e amorosa","2013-06-09 23:59:59.000","2013-06-10 06:00:00.000","Quilate Bar",10.0,0.0);
INSERT INTO Evento VALUES (7,"Noite da gata","Oferta de 3 bebidas para elas","2013-06-28 23:59:59.000","2013-06-29 06:00:00.000","Kopos Bar",8.0,5.0);
INSERT INTO Evento VALUES (8,"Sabado vou aos copos","Oferta de 1 bebida para elas","2013-06-15 23:59:59.000","2013-06-16 06:00:00.000","Kopos Bar",8.0,5.0);

INSERT INTO Evento VALUES (9,"Discotek","The sounds of disco compiled by Estação","2013-06-07 23:59:59.000","2013-06-08 06:00:00.000","Estação da Luz",10.0,0.0);
INSERT INTO Evento VALUES (10,"Friday Night Light","Música anos 80, 90, 2000","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","Estação da Luz",5.0,0.0);
INSERT INTO Evento VALUES (11,"Nova Imagem","Reabertura NB","2013-06-07 23:59:59.000","2013-06-08 06:00:00.000","NB Club Aveiro",7.5,7.5);
INSERT INTO Evento VALUES (12,"Star Woman","Boa disposição e animação","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","NB Club Aveiro",7.5,5.0);
INSERT INTO Evento VALUES (13,"Salsabor","Ritmos calientes","2013-06-07 23:59:59.000","2013-06-08 06:00:00.000","Vinil Bar",0.0,0.0);
INSERT INTO Evento VALUES (14,"Abertura Esplanada","Concerto ao vivo dos Cooldrive","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","Vinil Bar",0.0,0.0);

INSERT INTO Evento VALUES (15,"Low Cost 1 Maio","Quintas-feiras Low Cost no TWINS","2013-05-01 23:59:59.000","2013-05-02 06:00:00.000","Twins Foz",8.5,5.0);
INSERT INTO Evento VALUES (16,"Low Cost 7 Junho","Quintas-feiras Low Cost no TWINS","2013-06-05 23:59:59.000", "2013-06-07 06:00:00.000","Twins Foz",8.5,5.0);
INSERT INTO Evento VALUES (17,"My Boyfriend Is Out Of Town 30 Abril","Evento de Quarta-feira no Eskada Porto","2013-04-30 23:59:59.000","2013-05-01 06:00:00.000","Eskada Porto",10.0,7.0);
INSERT INTO Evento VALUES (18,"Pré-Queima","Festa de aquecimento para a Queima das Fitas do Porto, esta sexta feira no VILLA Porto.","2013-05-03 23:59:59.000","2013-05-04 06:00:00.000","VILLA Porto",5.0,3.0);
INSERT INTO Evento VALUES (19,"BAILE SERTANEJO - DIEGO FARIA AO VIVO NO VILLA","• DIEGO FARIA AO VIVO • cantor do megahit: ELAS FICAM LOUCAS !","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","VILLA Porto",10.0,8.0);
INSERT INTO Evento VALUES (20,"ENTER.Electric Daisy Carnival","Richie Hawtin (official page) / Dubfire / Seth Troxler / Damian Lazarus / Hobo / n-sound","2013-05-17 23:59:59.000","2013-05-18 06:00:00.000","Gare",15.0,15.0);
INSERT INTO Evento VALUES (21,"BIBA A BAIXA 30 Abril","Todas as Quartas feiras no Pitch há a festa BIBA A BAIXA com os DJs THE END","2013-04-30 23:59:59.000","2013-05-01 06:00:00.000","Pitch",8.0,5.0);
INSERT INTO Evento VALUES (22,"BIBA A BAIXA 5 Junho","O BIBA A BAIXA realiza-se todas as quartas-feiras no club PITCH com preços de bebidas atractivos associado a um bom ambiente, uma noite que promete ser especial, proporcionado grandes momentos de diversão, numa noite da semana de pandam !! ;-)Na cabine :OVERULE,NUNO CARNEIRO,RICARDO REIS!Até já ...Parque de Estacionamento:D.João I(cartões de desconto disponíveis no PITCH)","2013-06-04 23:59:59.000","2013-06-05 06:00:00.000","Pitch",8.0,5.0);
INSERT INTO Evento VALUES (23,"Pass Geral","Acesso a todos os concertos","2013-06-20 23:59:59.000","2013-06-22 06:00:00.000","Optimus Primavera Sound",125.0,125.0);
INSERT INTO Evento VALUES (24,"Dia 1","Merchandise | Nick Cave | James Blake","2013-06-20 23:59:59.000","2013-06-21 06:00:00.000","Optimus Primavera Sound",55.0,55.0);
INSERT INTO Evento VALUES (25,"Dia 2","Mão Morta | Blur | Hots Snake","2013-06-21 23:59:59.000","2013-06-22 06:00:00.000","Optimus Primavera Sound",55.0,55.0);
INSERT INTO Evento VALUES (26,"Dia 3","My Bloody Valentine | Fucked Up | The Magician","2013-06-22 23:59:59.000","2013-06-23 06:00:00.000","Optimus Primavera Sound",55.0,55.0);

INSERT INTO Evento VALUES (27,"Luv Beats","Capicua","2013-06-08 23:59:59.000","2013-06-09 06:00:00.000","BBC",10.0,10.0);
INSERT INTO Evento VALUES (28,"BBC Candie","Sam The Kid","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","BBC",10.0,10.0);
INSERT INTO Evento VALUES (29,"Sunset Rio","Uma tarde bem passada ao sol","2013-06-15 17:59:59.000","2013-06-16 06:00:00.000","BBC",10.0,5.0);
INSERT INTO Evento VALUES (30,"Summer Party","Convite","2013-06-14 23:59:59.000","2013-06-15 06:00:00.000","SKY",10.0,8.0);
INSERT INTO Evento VALUES (31,"Live Music","MOJO Power of the Grove","2013-06-12 23:59:59.000","2013-06-13 06:00:00.000","Hard Rock Cafe Lisboa",10.0,7.0);

--GUESTSBOOKS

INSERT INTO Guestbook VALUES ("João Gil",1,NULL);
INSERT INTO Guestbook VALUES ("João Gil",2,NULL);
INSERT INTO Guestbook VALUES ("João Gil",3,NULL);
INSERT INTO Guestbook VALUES ("João Gil",4,NULL);
INSERT INTO Guestbook VALUES ("João Gil",6,NULL);
INSERT INTO Guestbook VALUES ("João Gil",8,NULL);
INSERT INTO Guestbook VALUES ("João Gil",23,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",1,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",4,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",5,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",6,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",7,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",8,NULL);
INSERT INTO Guestbook VALUES ("Sara Dinis",23,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",1,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",4,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",5,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",6,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",7,NULL);
INSERT INTO Guestbook VALUES ("Isabel Mendes",24,NULL);
INSERT INTO Guestbook VALUES ("João Nuno",2,NULL);
INSERT INTO Guestbook VALUES ("João Nuno",25,NULL);
INSERT INTO Guestbook VALUES ("Carla Baía",1,NULL);
INSERT INTO Guestbook VALUES ("Carla Baía",4,NULL);
INSERT INTO Guestbook VALUES ("Carla Baía",6,NULL);
INSERT INTO Guestbook VALUES ("Carla Baía",7,NULL);
INSERT INTO Guestbook VALUES ("Carla Baía",25,NULL);
INSERT INTO Guestbook VALUES ("Raquel Bombardo",1,NULL);
INSERT INTO Guestbook VALUES ("Raquel Bombardo",3,NULL);
INSERT INTO Guestbook VALUES ("Raquel Bombardo",5,NULL);
INSERT INTO Guestbook VALUES ("Raquel Bombardo",25,NULL);
INSERT INTO Guestbook VALUES ("Miguel Mimoso",2,NULL);
INSERT INTO Guestbook VALUES ("Miguel Mimoso",4,NULL);
INSERT INTO Guestbook VALUES ("Miguel Mimoso",6,NULL);
INSERT INTO Guestbook VALUES ("Miguel Mimoso",8,NULL);
INSERT INTO Guestbook VALUES ("Miguel Mimoso",24,NULL);
INSERT INTO Guestbook VALUES ("Afonso Guimarães",1,NULL);
INSERT INTO Guestbook VALUES ("Afonso Guimarães",5,NULL);
INSERT INTO Guestbook VALUES ("Afonso Guimarães",7,NULL);
INSERT INTO Guestbook VALUES ("Afonso Guimarães",23,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",1,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",2,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",3,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",4,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",5,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",6,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",7,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",8,NULL);
INSERT INTO Guestbook VALUES ("Ana Montana",23,NULL);

INSERT INTO Guestbook VALUES ("Ricardo Leite",9,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",10,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",11,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",12,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",13,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",14,NULL);
INSERT INTO Guestbook VALUES ("Ricardo Leite",23,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",9,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",10,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",12,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",13,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",14,NULL);
INSERT INTO Guestbook VALUES ("Rita Almeida",24,NULL);
INSERT INTO Guestbook VALUES ("Rui Leite",9,NULL);
INSERT INTO Guestbook VALUES ("Rui Leite",11,NULL);
INSERT INTO Guestbook VALUES ("Rui Leite",14,NULL);
INSERT INTO Guestbook VALUES ("Rui Leite",25,NULL);
INSERT INTO Guestbook VALUES ("Nuno Taborda",11,NULL);
INSERT INTO Guestbook VALUES ("Nuno Taborda",13,NULL);
INSERT INTO Guestbook VALUES ("Nuno Taborda",14,NULL);
INSERT INTO Guestbook VALUES ("Nuno Taborda",24,NULL);
INSERT INTO Guestbook VALUES ("André Patarrana",9,NULL);
INSERT INTO Guestbook VALUES ("André Patarrana",10,NULL);
INSERT INTO Guestbook VALUES ("André Patarrana",11,NULL);
INSERT INTO Guestbook VALUES ("André Patarrana",12,NULL);
INSERT INTO Guestbook VALUES ("André Patarrana",26,NULL);
INSERT INTO Guestbook VALUES ("Raquel Fonseca",9,NULL);
INSERT INTO Guestbook VALUES ("Raquel Fonseca",10,NULL);
INSERT INTO Guestbook VALUES ("Raquel Fonseca",11,NULL);
INSERT INTO Guestbook VALUES ("Raquel Fonseca",12,NULL);
INSERT INTO Guestbook VALUES ("Raquel Fonseca",26,NULL);

INSERT INTO Guestbook VALUES ("Duarte Brandão",15,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",16,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",17,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",18,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",19,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",20,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",21,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",22,NULL);
INSERT INTO Guestbook VALUES ("Duarte Brandão",23,NULL);
INSERT INTO Guestbook VALUES ("Fernando José",15,NULL);
INSERT INTO Guestbook VALUES ("Fernando José",16,NULL);
INSERT INTO Guestbook VALUES ("Fernando José",22,NULL);
INSERT INTO Guestbook VALUES ("Fernando José",23,NULL);
INSERT INTO Guestbook VALUES ("Maria Sousa",17,NULL);
INSERT INTO Guestbook VALUES ("Maria Sousa",18,NULL);
INSERT INTO Guestbook VALUES ("Maria Sousa",21,NULL);
INSERT INTO Guestbook VALUES ("Maria Sousa",24,NULL);
INSERT INTO Guestbook VALUES ("Pedro João",15,NULL);
INSERT INTO Guestbook VALUES ("Pedro João",16,NULL);
INSERT INTO Guestbook VALUES ("Pedro João",18,NULL);
INSERT INTO Guestbook VALUES ("Pedro João",19,NULL);
INSERT INTO Guestbook VALUES ("Pedro João",23,NULL);
INSERT INTO Guestbook VALUES ("Maria José",15,NULL);
INSERT INTO Guestbook VALUES ("Maria José",16,NULL);
INSERT INTO Guestbook VALUES ("Maria José",17,NULL);
INSERT INTO Guestbook VALUES ("Maria José",18,NULL);
INSERT INTO Guestbook VALUES ("Maria José",19,NULL);
INSERT INTO Guestbook VALUES ("Maria José",20,NULL);
INSERT INTO Guestbook VALUES ("Maria José",21,NULL);
INSERT INTO Guestbook VALUES ("Maria José",22,NULL);
INSERT INTO Guestbook VALUES ("Maria José",23,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",15,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",16,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",17,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",18,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",19,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",20,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",21,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",22,NULL);
INSERT INTO Guestbook VALUES ("Joana Rita",23,NULL);
INSERT INTO Guestbook VALUES ("Maria João",15,NULL);
INSERT INTO Guestbook VALUES ("Maria João",17,NULL);
INSERT INTO Guestbook VALUES ("Maria João",19,NULL);
INSERT INTO Guestbook VALUES ("Maria João",21,NULL);
INSERT INTO Guestbook VALUES ("Maria João",25,NULL);
INSERT INTO Guestbook VALUES ("Maria João",26,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",15,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",16,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",17,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",18,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",19,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",20,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",21,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",22,NULL);
INSERT INTO Guestbook VALUES ("Rui Pedro",23,NULL);
INSERT INTO Guestbook VALUES ("Rita João",16,NULL);
INSERT INTO Guestbook VALUES ("Rita João",18,NULL);
INSERT INTO Guestbook VALUES ("Rita João",20,NULL);
INSERT INTO Guestbook VALUES ("Rita João",22,NULL);
INSERT INTO Guestbook VALUES ("Rita João",24,NULL);
INSERT INTO Guestbook VALUES ("Carolina João",15,NULL);
INSERT INTO Guestbook VALUES ("Carolina João",20,NULL);
INSERT INTO Guestbook VALUES ("Carolina João",21,NULL);
INSERT INTO Guestbook VALUES ("Carolina João",22,NULL);
INSERT INTO Guestbook VALUES ("Carolina João",26,NULL);
INSERT INTO Guestbook VALUES ("Paula Martins",15,NULL);
INSERT INTO Guestbook VALUES ("Paula Martins",19,NULL);
INSERT INTO Guestbook VALUES ("Paula Martins",23,NULL);
INSERT INTO Guestbook VALUES ("João Pedro",16,NULL);
INSERT INTO Guestbook VALUES ("João Pedro",18,NULL);
INSERT INTO Guestbook VALUES ("João Pedro",20,NULL);
INSERT INTO Guestbook VALUES ("João Pedro",22,NULL);
INSERT INTO Guestbook VALUES ("João Pedro",24,NULL);
INSERT INTO Guestbook VALUES ("Patricia João",17,NULL);
INSERT INTO Guestbook VALUES ("Patricia João",19,NULL);
INSERT INTO Guestbook VALUES ("Patricia João",21,NULL);
INSERT INTO Guestbook VALUES ("Patricia João",25,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",15,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",16,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",17,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",18,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",19,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",20,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",21,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",22,NULL);
INSERT INTO Guestbook VALUES ("António Rodrigues",24,NULL);

INSERT INTO Guestbook VALUES ("Luis Lima",25,NULL);
INSERT INTO Guestbook VALUES ("Luis Lima",27,NULL);
INSERT INTO Guestbook VALUES ("Luis Lima",28,NULL);
INSERT INTO Guestbook VALUES ("Luis Lima",29,NULL);
INSERT INTO Guestbook VALUES ("Luis Lima",30,NULL);
INSERT INTO Guestbook VALUES ("Luis Lima",31,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",24,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",26,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",27,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",28,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",29,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",30,NULL);
INSERT INTO Guestbook VALUES ("Mariana Machado",31,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",23,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",27,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",28,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",29,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",30,NULL);
INSERT INTO Guestbook VALUES ("Rafael de Matos",31,NULL);
INSERT INTO Guestbook VALUES ("Cristina Leonor",25,NULL);
INSERT INTO Guestbook VALUES ("Cristina Leonor",27,NULL);
INSERT INTO Guestbook VALUES ("Cristina Leonor",29,NULL);
INSERT INTO Guestbook VALUES ("Cristina Leonor",30,NULL);
INSERT INTO Guestbook VALUES ("Cristina Leonor",31,NULL);
INSERT INTO Guestbook VALUES ("Diana Pinheiro",26,NULL);
INSERT INTO Guestbook VALUES ("Diana Pinheiro",27,NULL);
INSERT INTO Guestbook VALUES ("Diana Pinheiro",28,NULL);
INSERT INTO Guestbook VALUES ("Diana Pinheiro",30,NULL);
INSERT INTO Guestbook VALUES ("Diana Pinheiro",31,NULL);
INSERT INTO Guestbook VALUES ("Pedro Soares",26,NULL);
INSERT INTO Guestbook VALUES ("Pedro Soares",28,NULL);
INSERT INTO Guestbook VALUES ("Pedro Soares",29,NULL);
INSERT INTO Guestbook VALUES ("Pedro Soares",30,NULL);
INSERT INTO Guestbook VALUES ("Renato Pereira",23,NULL);
INSERT INTO Guestbook VALUES ("Renato Pereira",28,NULL);
INSERT INTO Guestbook VALUES ("Renato Pereira",29,NULL);
INSERT INTO Guestbook VALUES ("Renato Pereira",30,NULL);
INSERT INTO Guestbook VALUES ("Renato Pereira",31,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",23,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",27,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",28,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",29,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",30,NULL);
INSERT INTO Guestbook VALUES ("Sara Santos",31,NULL);

--FOTOS

INSERT INTO Foto VALUES ("http://somelink.com/andro.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro1.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro2.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro3.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro4.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro5.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/andro6.jpg", "Grupo Andromeda","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub1.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub2.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub3.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub4.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub5.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub6.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub7.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub8.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub9.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/bclub10.jpg", "B-Club","João Gil");
INSERT INTO Foto VALUES ("http://somelink.com/quilate.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate1.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate2.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate3.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate4.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate5.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate6.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate7.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/quilate8.jpg", "Quilate Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos1.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos2.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos3.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos4.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos5.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos6.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos7.jpg", "Kopos Bar","Sara Dinis");
INSERT INTO Foto VALUES ("http://somelink.com/kopos8.jpg", "Kopos Bar","Sara Dinis");

INSERT INTO Foto VALUES ("http://somelink.com/estacao.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao1.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao2.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao3.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao4.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao5.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/estacao6.jpg", "Estação da Luz","Rita Almeida");
INSERT INTO Foto VALUES ("http://somelink.com/nb.jpg", "NB Club","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/nb1.jpg", "NB Club","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/nb2.jpg", "NB Club","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/nb3.jpg", "NB Club","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/nb4.jpg", "NB Club","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/vinil.jpg", "Vinil Bar","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/vinil1.jpg", "Vinil Bar","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/vinil2.jpg", "Vinil Bar","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/vinil3.jpg", "Vinil Bar","Ricardo Leite");
INSERT INTO Foto VALUES ("http://somelink.com/vinil4.jpg", "Vinil Bar","Ricardo Leite");

INSERT INTO Foto VALUES ("http://somelink.com/twins.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins1.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins2.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins3.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins4.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins5.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/twins6.jpg", "Twins","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/eskada.jpg", "Eskada","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/eskada1.jpg", "Eskada","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/eskada2.jpg", "Eskada","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa1.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa2.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa3.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa4.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa5.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa6.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa7.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa8.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa9.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/villa10.jpg", "Villa","Duarte Brandão");
INSERT INTO Foto VALUES ("http://somelink.com/gare.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/gare1.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/gare2.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/gare3.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/gare4.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/gare5.jpg", "Gare","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch1.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch2.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch3.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch4.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch5.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch6.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch7.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/pitch8.jpg", "Pitch","Carolina João");
INSERT INTO Foto VALUES ("http://somelink.com/ops.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops1.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops2.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops3.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops4.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops5.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops6.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops7.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops8.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops9.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops10.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops11.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops12.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops13.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops14.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops15.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops16.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops17.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops18.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops19.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops20.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops21.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops22.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops23.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops24.jpg", "Optimus Primavera Sound","Paula Martins");
INSERT INTO Foto VALUES ("http://somelink.com/ops25.jpg", "Optimus Primavera Sound","Paula Martins");

INSERT INTO Foto VALUES ("http://somelink.com/bbc.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc1.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc2.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc3.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc4.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc5.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc6.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc7.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc8.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/bbc9.jpg", "BBC","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/sky.jpg", "SKY","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/sky1.jpg", "SKY","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/sky2.jpg", "SKY","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/hrcl.jpg", "Hard Rock","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/hrcl1.jpg", "Hard Rock","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/hrcl2.jpg", "Hard Rock","Rafael de Matos");
INSERT INTO Foto VALUES ("http://somelink.com/hrcl3.jpg", "Hard Rock","Rafael de Matos");


--COMENTARIOS

INSERT INTO Comentario VALUES (1,"Gostei muito desta noite.","João Gil");
INSERT INTO Comentario VALUES (2,"Finalmente as aulas acabaram!","João Gil");
INSERT INTO Comentario VALUES (3,"Só Gatas!","João Gil");
INSERT INTO Comentario VALUES (4,"O Optimus estava gostoso!","João Gil");
INSERT INTO Comentario VALUES (5,"Noite inesquecivel!","Sara Dinis");
INSERT INTO Comentario VALUES (6,"Adorei!","Sara Dinis");
INSERT INTO Comentario VALUES (7,"Estava toda cega!","Isabel Mendes");
INSERT INTO Comentario VALUES (8,"Foi bom festejar o final de aulas nesta companhia!","João Nuno");
INSERT INTO Comentario VALUES (9,"Optimus Primavera Sound aqui vou eu!","João Nuno");
INSERT INTO Comentario VALUES (10,"Noite Perfeita!","Carla Baía");
INSERT INTO Comentario VALUES (11,"A preparar para o OPS!","Carla Baía");
INSERT INTO Comentario VALUES (12,"Foi fantástico, só não gostei de ter ficado meia hora à porta!","Raquel Bombardo");
INSERT INTO Comentario VALUES (13,"BRUTAAAAL!","Miguel Mimoso");
INSERT INTO Comentario VALUES (14,"Fui aos copos e fiquei com os copos!","Miguel Mimoso");

INSERT INTO Comentario VALUES (15,"Evento fantástico","Ricardo Leite");
INSERT INTO Comentario VALUES (16,"Melhor era impossivel","Ricardo Leite");
INSERT INTO Comentario VALUES (17,"Ficámos mesmo bem na foto!","Rita Almeida");
INSERT INTO Comentario VALUES (18,"Sou o maior!","Rui Leite");
INSERT INTO Comentario VALUES (19,"Acabou-se a mama toda!","Nuno Taborda");
INSERT INTO Comentario VALUES (20,"Melhor noite de todas!","Raquel Fonseca");

INSERT INTO Comentario VALUES (21,"Querooo mais!","Duarte Brandão");
INSERT INTO Comentario VALUES (22,"Os infiltrados xD!","Duarte Brandão");
INSERT INTO Comentario VALUES (23,"Para o ano há mais!","Fernando José");
INSERT INTO Comentario VALUES (24,"Viva a Baixa!!","Fernando José");
INSERT INTO Comentario VALUES (25,"Os finos estavam mortos!","Maria Sousa");
INSERT INTO Comentario VALUES (26,"Low cost é que calha bem na crise!","Pedro João");
INSERT INTO Comentario VALUES (27,"OPS Forever","Maria José");
INSERT INTO Comentario VALUES (28,"Aprende a tirar fotos!","Joana Rita");
INSERT INTO Comentario VALUES (29,"Amei Mão Morta!","Maria João");
INSERT INTO Comentario VALUES (30,"Comprámos Garrafa!","Rui Pedro");
INSERT INTO Comentario VALUES (31,"Lindas!","Rita João");
INSERT INTO Comentario VALUES (32,"Melhor Optimus de sempre!","Carolina João");
INSERT INTO Comentario VALUES (33,"Baila, baila, baila comigo","Paula Martins");
INSERT INTO Comentario VALUES (34,"Fantástico!","João Pedro");

INSERT INTO Comentario VALUES (35,"Hots Snake rulam!","Luis Lima");
INSERT INTO Comentario VALUES (36,"Foi pena terem entornado vodka em cima de mim, de resto, correu tudo muito bem!","Luis Lima");
INSERT INTO Comentario VALUES (37,"Merchandise sou a vossa fã número um!!","Mariana Machado");
INSERT INTO Comentario VALUES (38,"Mas que grande Sunset!","Mariana Machado");
INSERT INTO Comentario VALUES (39,"Eu mais estas 3 mulheres lindas!","Rafael de Matos");
INSERT INTO Comentario VALUES (40,"A loucura!!","Rafael de Matos");
INSERT INTO Comentario VALUES (41,"Por fim chegou o Verão!","Cristina Leonor");
INSERT INTO Comentario VALUES (42,"Um serão bem passado!","Cristina Leonor");
INSERT INTO Comentario VALUES (43,"Yo Sam The Kid!","Diana Pinheiro");
INSERT INTO Comentario VALUES (44,"Eu e o Samuel o Puto!","Diana Pinheiro");
INSERT INTO Comentario VALUES (45,"Rock and Roll!","Pedro Soares");

--COMENTARIOS DOS EVENTOS

INSERT INTO ComentarioEvento VALUES (1,3);
INSERT INTO ComentarioEvento VALUES (2,2);
INSERT INTO ComentarioEvento VALUES (3,1);
INSERT INTO ComentarioEvento VALUES (4,23);
INSERT INTO ComentarioEvento VALUES (5,1);
INSERT INTO ComentarioEvento VALUES (6,6);
INSERT INTO ComentarioEvento VALUES (8,2);
INSERT INTO ComentarioEvento VALUES (9,25);
INSERT INTO ComentarioEvento VALUES (10,4);
INSERT INTO ComentarioEvento VALUES (11,25);
INSERT INTO ComentarioEvento VALUES (12,5);
INSERT INTO ComentarioEvento VALUES (13,6);
INSERT INTO ComentarioEvento VALUES (14,8);

INSERT INTO ComentarioEvento VALUES (15,9);
INSERT INTO ComentarioEvento VALUES (16,12);
INSERT INTO ComentarioEvento VALUES (18,14);
INSERT INTO ComentarioEvento VALUES (19,14);
INSERT INTO ComentarioEvento VALUES (20,9);

INSERT INTO ComentarioEvento VALUES (21,23);
INSERT INTO ComentarioEvento VALUES (23,23);
INSERT INTO ComentarioEvento VALUES (24,16);
INSERT INTO ComentarioEvento VALUES (25,17);
INSERT INTO ComentarioEvento VALUES (26,16);
INSERT INTO ComentarioEvento VALUES (27,23);
INSERT INTO ComentarioEvento VALUES (29,25);
INSERT INTO ComentarioEvento VALUES (32,26);
INSERT INTO ComentarioEvento VALUES (33,19);
INSERT INTO ComentarioEvento VALUES (34,16);

INSERT INTO ComentarioEvento VALUES (35,25);
INSERT INTO ComentarioEvento VALUES (36,29);
INSERT INTO ComentarioEvento VALUES (37,24);
INSERT INTO ComentarioEvento VALUES (38,29);
INSERT INTO ComentarioEvento VALUES (40,29);
INSERT INTO ComentarioEvento VALUES (41,30);
INSERT INTO ComentarioEvento VALUES (42,31);
INSERT INTO ComentarioEvento VALUES (43,28);
INSERT INTO ComentarioEvento VALUES (45,31);

--COMENTARIOS DAS FOTOS

INSERT INTO ComentarioFoto VALUES (7,"http://somelink.com/andro5.jpg");
INSERT INTO ComentarioFoto VALUES (17,"http://somelink.com/estacao2.jpg");
INSERT INTO ComentarioFoto VALUES (22,"http://somelink.com/twins4.jpg");
INSERT INTO ComentarioFoto VALUES (28,"http://somelink.com/pitch1.jpg");
INSERT INTO ComentarioFoto VALUES (30,"http://somelink.com/twins6.jpg");
INSERT INTO ComentarioFoto VALUES (31,"http://somelink.com/twins6.jpg");
INSERT INTO ComentarioFoto VALUES (39,"http://somelink.com/bbc4.jpg");
INSERT INTO ComentarioFoto VALUES (44,"http://somelink.com/bbc2.jpg");


--FOTOS DOS EVENTOS

INSERT INTO FotoEvento VALUES ("http://somelink.com/andro1.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/andro2.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/andro3.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/andro4.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/andro5.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/andro6.jpg",1);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub1.jpg",2);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub2.jpg",2);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub3.jpg",3);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub4.jpg",3);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub5.jpg",3);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub6.jpg",4);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub7.jpg",4);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub8.jpg",4);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub9.jpg",4);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bclub10.jpg",4);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate1.jpg",5);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate2.jpg",5);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate3.jpg",5);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate4.jpg",6);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate5.jpg",6);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate6.jpg",6);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate7.jpg",6);
INSERT INTO FotoEvento VALUES ("http://somelink.com/quilate8.jpg",6);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos1.jpg",7);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos2.jpg",7);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos3.jpg",7);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos4.jpg",7);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos5.jpg",8);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos6.jpg",8);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos7.jpg",8);
INSERT INTO FotoEvento VALUES ("http://somelink.com/kopos8.jpg",8);

INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao1.jpg",9);
INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao2.jpg",9);
INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao3.jpg",9);
INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao4.jpg",9);
INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao5.jpg",10);
INSERT INTO FotoEvento VALUES ("http://somelink.com/estacao6.jpg",10);
INSERT INTO FotoEvento VALUES ("http://somelink.com/nb1.jpg",11);
INSERT INTO FotoEvento VALUES ("http://somelink.com/nb2.jpg",11);
INSERT INTO FotoEvento VALUES ("http://somelink.com/nb3.jpg",12);
INSERT INTO FotoEvento VALUES ("http://somelink.com/nb4.jpg",12);
INSERT INTO FotoEvento VALUES ("http://somelink.com/vinil1.jpg",13);
INSERT INTO FotoEvento VALUES ("http://somelink.com/vinil2.jpg",14);
INSERT INTO FotoEvento VALUES ("http://somelink.com/vinil3.jpg",14);
INSERT INTO FotoEvento VALUES ("http://somelink.com/vinil4.jpg",14);

INSERT INTO FotoEvento VALUES ("http://somelink.com/twins1.jpg",15);
INSERT INTO FotoEvento VALUES ("http://somelink.com/twins2.jpg",15);
INSERT INTO FotoEvento VALUES ("http://somelink.com/twins3.jpg",15);
INSERT INTO FotoEvento VALUES ("http://somelink.com/twins4.jpg",16);
INSERT INTO FotoEvento VALUES ("http://somelink.com/twins5.jpg",16);
INSERT INTO FotoEvento VALUES ("http://somelink.com/twins6.jpg",16);
INSERT INTO FotoEvento VALUES ("http://somelink.com/eskada1.jpg",17);
INSERT INTO FotoEvento VALUES ("http://somelink.com/eskada2.jpg",17);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa1.jpg",18);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa2.jpg",18);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa3.jpg",18);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa4.jpg",18);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa5.jpg",18);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa6.jpg",19);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa7.jpg",19);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa8.jpg",19);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa9.jpg",19);
INSERT INTO FotoEvento VALUES ("http://somelink.com/villa10.jpg",19);
INSERT INTO FotoEvento VALUES ("http://somelink.com/gare1.jpg",20);
INSERT INTO FotoEvento VALUES ("http://somelink.com/gare2.jpg",20);
INSERT INTO FotoEvento VALUES ("http://somelink.com/gare3.jpg",20);
INSERT INTO FotoEvento VALUES ("http://somelink.com/gare4.jpg",20);
INSERT INTO FotoEvento VALUES ("http://somelink.com/gare5.jpg",20);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch1.jpg",21);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch2.jpg",21);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch3.jpg",21);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch4.jpg",21);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch5.jpg",22);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch6.jpg",22);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch7.jpg",22);
INSERT INTO FotoEvento VALUES ("http://somelink.com/pitch8.jpg",22);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops1.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops2.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops3.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops4.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops5.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops6.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops7.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops8.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops9.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops10.jpg",23);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops11.jpg",24);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops12.jpg",24);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops13.jpg",24);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops14.jpg",24);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops15.jpg",24);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops16.jpg",25);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops17.jpg",25);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops18.jpg",25);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops19.jpg",25);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops20.jpg",25);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops21.jpg",26);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops22.jpg",26);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops23.jpg",26);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops24.jpg",26);
INSERT INTO FotoEvento VALUES ("http://somelink.com/ops25.jpg",26);

INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc1.jpg",27);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc2.jpg",28);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc3.jpg",28);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc4.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc5.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc6.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc7.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc8.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/bbc9.jpg",29);
INSERT INTO FotoEvento VALUES ("http://somelink.com/sky1.jpg",30);
INSERT INTO FotoEvento VALUES ("http://somelink.com/sky2.jpg",30);
INSERT INTO FotoEvento VALUES ("http://somelink.com/hrcl1.jpg",31);
INSERT INTO FotoEvento VALUES ("http://somelink.com/hrcl2.jpg",31);
INSERT INTO FotoEvento VALUES ("http://somelink.com/hrcl3.jpg",31);


--FOTOS DAS PAGINAS

INSERT INTO FotoPagina VALUES ("http://somelink.com/andro.jpg","Grupo Andromeda");
INSERT INTO FotoPagina VALUES ("http://somelink.com/bclub.jpg","B-Club");
INSERT INTO FotoPagina VALUES ("http://somelink.com/quilate.jpg","Quilate Bar");
INSERT INTO FotoPagina VALUES ("http://somelink.com/kopos.jpg","Kopos Bar");
INSERT INTO FotoPagina VALUES ("http://somelink.com/estacao.jpg","Estação da Luz");
INSERT INTO FotoPagina VALUES ("http://somelink.com/nb.jpg","NB Club Aveiro");
INSERT INTO FotoPagina VALUES ("http://somelink.com/vinil.jpg","Vinil Bar");
INSERT INTO FotoPagina VALUES ("http://somelink.com/twins.jpg","Twins Foz");
INSERT INTO FotoPagina VALUES ("http://somelink.com/eskada.jpg","Eskada Porto");
INSERT INTO FotoPagina VALUES ("http://somelink.com/villa.jpg","VILLA Porto");
INSERT INTO FotoPagina VALUES ("http://somelink.com/gare.jpg","Gare");
INSERT INTO FotoPagina VALUES ("http://somelink.com/pitch.jpg","Pitch");
INSERT INTO FotoPagina VALUES ("http://somelink.com/ops.jpg","Optimus Primavera Sound");
INSERT INTO FotoPagina VALUES ("http://somelink.com/bbc.jpg","BBC");
INSERT INTO FotoPagina VALUES ("http://somelink.com/sky.jpg","SKY");
INSERT INTO FotoPagina VALUES ("http://somelink.com/hrcl.jpg","Hard Rock Cafe Lisboa");

--LIKES DOS EVENTOS

INSERT INTO LikeEvento VALUES ("João Gil",1);
INSERT INTO LikeEvento VALUES ("João Gil",2);
INSERT INTO LikeEvento VALUES ("João Gil",3);
INSERT INTO LikeEvento VALUES ("João Gil",4);
INSERT INTO LikeEvento VALUES ("João Gil",6);
INSERT INTO LikeEvento VALUES ("João Gil",8);
INSERT INTO LikeEvento VALUES ("João Gil",23);
INSERT INTO LikeEvento VALUES ("Sara Dinis",1);
INSERT INTO LikeEvento VALUES ("Sara Dinis",4);
INSERT INTO LikeEvento VALUES ("Sara Dinis",5);
INSERT INTO LikeEvento VALUES ("Sara Dinis",6);
INSERT INTO LikeEvento VALUES ("Sara Dinis",7);
INSERT INTO LikeEvento VALUES ("Sara Dinis",8);
INSERT INTO LikeEvento VALUES ("Sara Dinis",23);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",1);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",4);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",5);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",6);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",7);
INSERT INTO LikeEvento VALUES ("Isabel Mendes",24);
INSERT INTO LikeEvento VALUES ("João Nuno",2);
INSERT INTO LikeEvento VALUES ("João Nuno",3);
INSERT INTO LikeEvento VALUES ("João Nuno",4);
INSERT INTO LikeEvento VALUES ("João Nuno",25);
INSERT INTO LikeEvento VALUES ("Carla Baía",1);
INSERT INTO LikeEvento VALUES ("Carla Baía",2);
INSERT INTO LikeEvento VALUES ("Carla Baía",4);
INSERT INTO LikeEvento VALUES ("Carla Baía",5);
INSERT INTO LikeEvento VALUES ("Carla Baía",6);
INSERT INTO LikeEvento VALUES ("Carla Baía",23);
INSERT INTO LikeEvento VALUES ("Carla Baía",25);
INSERT INTO LikeEvento VALUES ("Raquel Bombardo",1);
INSERT INTO LikeEvento VALUES ("Raquel Bombardo",3);
INSERT INTO LikeEvento VALUES ("Raquel Bombardo",4);
INSERT INTO LikeEvento VALUES ("Raquel Bombardo",23);
INSERT INTO LikeEvento VALUES ("Raquel Bombardo",25);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",1);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",2);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",3);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",4);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",5);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",6);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",7);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",8);
INSERT INTO LikeEvento VALUES ("Miguel Mimoso",25);
INSERT INTO LikeEvento VALUES ("Afonso Guimarães",1);
INSERT INTO LikeEvento VALUES ("Afonso Guimarães",3);
INSERT INTO LikeEvento VALUES ("Afonso Guimarães",5);
INSERT INTO LikeEvento VALUES ("Afonso Guimarães",7);
INSERT INTO LikeEvento VALUES ("Afonso Guimarães",23);
INSERT INTO LikeEvento VALUES ("Ana Montana",1);
INSERT INTO LikeEvento VALUES ("Ana Montana",2);
INSERT INTO LikeEvento VALUES ("Ana Montana",3);
INSERT INTO LikeEvento VALUES ("Ana Montana",4);
INSERT INTO LikeEvento VALUES ("Ana Montana",5);
INSERT INTO LikeEvento VALUES ("Ana Montana",6);
INSERT INTO LikeEvento VALUES ("Ana Montana",7);
INSERT INTO LikeEvento VALUES ("Ana Montana",8);
INSERT INTO LikeEvento VALUES ("Ana Montana",23);

INSERT INTO LikeEvento VALUES ("Ricardo Leite",9);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",10);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",11);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",12);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",13);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",14);
INSERT INTO LikeEvento VALUES ("Ricardo Leite",23);
INSERT INTO LikeEvento VALUES ("Rita Almeida",9);
INSERT INTO LikeEvento VALUES ("Rita Almeida",10);
INSERT INTO LikeEvento VALUES ("Rita Almeida",11);
INSERT INTO LikeEvento VALUES ("Rita Almeida",12);
INSERT INTO LikeEvento VALUES ("Rita Almeida",13);
INSERT INTO LikeEvento VALUES ("Rita Almeida",14);
INSERT INTO LikeEvento VALUES ("Rita Almeida",23);
INSERT INTO LikeEvento VALUES ("Rita Almeida",24);
INSERT INTO LikeEvento VALUES ("Rui Leite",9);
INSERT INTO LikeEvento VALUES ("Rui Leite",11);
INSERT INTO LikeEvento VALUES ("Rui Leite",14);
INSERT INTO LikeEvento VALUES ("Rui Leite",23);
INSERT INTO LikeEvento VALUES ("Rui Leite",25);
INSERT INTO LikeEvento VALUES ("Nuno Taborda",11);
INSERT INTO LikeEvento VALUES ("Nuno Taborda",13);
INSERT INTO LikeEvento VALUES ("Nuno Taborda",14);
INSERT INTO LikeEvento VALUES ("Nuno Taborda",23);
INSERT INTO LikeEvento VALUES ("Nuno Taborda",24);
INSERT INTO LikeEvento VALUES ("André Patarrana",9);
INSERT INTO LikeEvento VALUES ("André Patarrana",10);
INSERT INTO LikeEvento VALUES ("André Patarrana",11);
INSERT INTO LikeEvento VALUES ("André Patarrana",12);
INSERT INTO LikeEvento VALUES ("André Patarrana",23);
INSERT INTO LikeEvento VALUES ("André Patarrana",26);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",9);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",10);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",11);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",12);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",23);
INSERT INTO LikeEvento VALUES ("Raquel Fonseca",26);

INSERT INTO LikeEvento VALUES ("Duarte Brandão",15);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",16);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",17);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",18);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",19);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",20);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",21);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",22);
INSERT INTO LikeEvento VALUES ("Duarte Brandão",23);
INSERT INTO LikeEvento VALUES ("Fernando José",15);
INSERT INTO LikeEvento VALUES ("Fernando José",16);
INSERT INTO LikeEvento VALUES ("Fernando José",22);
INSERT INTO LikeEvento VALUES ("Fernando José",23);
INSERT INTO LikeEvento VALUES ("Maria Sousa",17);
INSERT INTO LikeEvento VALUES ("Maria Sousa",18);
INSERT INTO LikeEvento VALUES ("Maria Sousa",21);
INSERT INTO LikeEvento VALUES ("Maria Sousa",23);
INSERT INTO LikeEvento VALUES ("Maria Sousa",24);
INSERT INTO LikeEvento VALUES ("Pedro João",15);
INSERT INTO LikeEvento VALUES ("Pedro João",16);
INSERT INTO LikeEvento VALUES ("Pedro João",18);
INSERT INTO LikeEvento VALUES ("Pedro João",19);
INSERT INTO LikeEvento VALUES ("Pedro João",23);
INSERT INTO LikeEvento VALUES ("Maria José",15);
INSERT INTO LikeEvento VALUES ("Maria José",16);
INSERT INTO LikeEvento VALUES ("Maria José",17);
INSERT INTO LikeEvento VALUES ("Maria José",18);
INSERT INTO LikeEvento VALUES ("Maria José",19);
INSERT INTO LikeEvento VALUES ("Maria José",20);
INSERT INTO LikeEvento VALUES ("Maria José",21);
INSERT INTO LikeEvento VALUES ("Maria José",22);
INSERT INTO LikeEvento VALUES ("Maria José",23);
INSERT INTO LikeEvento VALUES ("Joana Rita",15);
INSERT INTO LikeEvento VALUES ("Joana Rita",16);
INSERT INTO LikeEvento VALUES ("Joana Rita",17);
INSERT INTO LikeEvento VALUES ("Joana Rita",18);
INSERT INTO LikeEvento VALUES ("Joana Rita",19);
INSERT INTO LikeEvento VALUES ("Joana Rita",20);
INSERT INTO LikeEvento VALUES ("Joana Rita",21);
INSERT INTO LikeEvento VALUES ("Joana Rita",22);
INSERT INTO LikeEvento VALUES ("Joana Rita",23);
INSERT INTO LikeEvento VALUES ("Maria João",15);
INSERT INTO LikeEvento VALUES ("Maria João",17);
INSERT INTO LikeEvento VALUES ("Maria João",19);
INSERT INTO LikeEvento VALUES ("Maria João",21);
INSERT INTO LikeEvento VALUES ("Maria João",23);
INSERT INTO LikeEvento VALUES ("Maria João",25);
INSERT INTO LikeEvento VALUES ("Maria João",26);
INSERT INTO LikeEvento VALUES ("Rui Pedro",15);
INSERT INTO LikeEvento VALUES ("Rui Pedro",16);
INSERT INTO LikeEvento VALUES ("Rui Pedro",17);
INSERT INTO LikeEvento VALUES ("Rui Pedro",18);
INSERT INTO LikeEvento VALUES ("Rui Pedro",19);
INSERT INTO LikeEvento VALUES ("Rui Pedro",20);
INSERT INTO LikeEvento VALUES ("Rui Pedro",21);
INSERT INTO LikeEvento VALUES ("Rui Pedro",22);
INSERT INTO LikeEvento VALUES ("Rui Pedro",23);
INSERT INTO LikeEvento VALUES ("Rita João",16);
INSERT INTO LikeEvento VALUES ("Rita João",18);
INSERT INTO LikeEvento VALUES ("Rita João",20);
INSERT INTO LikeEvento VALUES ("Rita João",22);
INSERT INTO LikeEvento VALUES ("Rita João",23);
INSERT INTO LikeEvento VALUES ("Rita João",24);
INSERT INTO LikeEvento VALUES ("Carolina João",15);
INSERT INTO LikeEvento VALUES ("Carolina João",20);
INSERT INTO LikeEvento VALUES ("Carolina João",21);
INSERT INTO LikeEvento VALUES ("Carolina João",22);
INSERT INTO LikeEvento VALUES ("Carolina João",23);
INSERT INTO LikeEvento VALUES ("Carolina João",26);
INSERT INTO LikeEvento VALUES ("Paula Martins",15);
INSERT INTO LikeEvento VALUES ("Paula Martins",19);
INSERT INTO LikeEvento VALUES ("Paula Martins",23);
INSERT INTO LikeEvento VALUES ("João Pedro",16);
INSERT INTO LikeEvento VALUES ("João Pedro",17);
INSERT INTO LikeEvento VALUES ("João Pedro",20);
INSERT INTO LikeEvento VALUES ("João Pedro",22);
INSERT INTO LikeEvento VALUES ("João Pedro",23);
INSERT INTO LikeEvento VALUES ("João Pedro",24);
INSERT INTO LikeEvento VALUES ("Patricia João",17);
INSERT INTO LikeEvento VALUES ("Patricia João",19);
INSERT INTO LikeEvento VALUES ("Patricia João",21);
INSERT INTO LikeEvento VALUES ("Patricia João",23);
INSERT INTO LikeEvento VALUES ("Patricia João",25);
INSERT INTO LikeEvento VALUES ("António Rodrigues",15);
INSERT INTO LikeEvento VALUES ("António Rodrigues",16);
INSERT INTO LikeEvento VALUES ("António Rodrigues",17);
INSERT INTO LikeEvento VALUES ("António Rodrigues",18);
INSERT INTO LikeEvento VALUES ("António Rodrigues",19);
INSERT INTO LikeEvento VALUES ("António Rodrigues",20);
INSERT INTO LikeEvento VALUES ("António Rodrigues",21);
INSERT INTO LikeEvento VALUES ("António Rodrigues",22);
INSERT INTO LikeEvento VALUES ("António Rodrigues",23);
INSERT INTO LikeEvento VALUES ("António Rodrigues",24);

INSERT INTO LikeEvento VALUES ("Luis Lima",23);
INSERT INTO LikeEvento VALUES ("Luis Lima",25);
INSERT INTO LikeEvento VALUES ("Luis Lima",27);
INSERT INTO LikeEvento VALUES ("Luis Lima",28);
INSERT INTO LikeEvento VALUES ("Luis Lima",29);
INSERT INTO LikeEvento VALUES ("Luis Lima",30);
INSERT INTO LikeEvento VALUES ("Luis Lima",31);
INSERT INTO LikeEvento VALUES ("Mariana Machado",23);
INSERT INTO LikeEvento VALUES ("Mariana Machado",24);
INSERT INTO LikeEvento VALUES ("Mariana Machado",26);
INSERT INTO LikeEvento VALUES ("Mariana Machado",27);
INSERT INTO LikeEvento VALUES ("Mariana Machado",28);
INSERT INTO LikeEvento VALUES ("Mariana Machado",29);
INSERT INTO LikeEvento VALUES ("Mariana Machado",30);
INSERT INTO LikeEvento VALUES ("Mariana Machado",31);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",23);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",27);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",28);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",29);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",30);
INSERT INTO LikeEvento VALUES ("Rafael de Matos",31);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",23);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",25);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",27);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",29);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",30);
INSERT INTO LikeEvento VALUES ("Cristina Leonor",31);
INSERT INTO LikeEvento VALUES ("Diana Pinheiro",23);
INSERT INTO LikeEvento VALUES ("Diana Pinheiro",26);
INSERT INTO LikeEvento VALUES ("Diana Pinheiro",28);
INSERT INTO LikeEvento VALUES ("Diana Pinheiro",30);
INSERT INTO LikeEvento VALUES ("Diana Pinheiro",31);
INSERT INTO LikeEvento VALUES ("Pedro Soares",23);
INSERT INTO LikeEvento VALUES ("Pedro Soares",26);
INSERT INTO LikeEvento VALUES ("Pedro Soares",28);
INSERT INTO LikeEvento VALUES ("Pedro Soares",29);
INSERT INTO LikeEvento VALUES ("Pedro Soares",30);
INSERT INTO LikeEvento VALUES ("Renato Pereira",23);
INSERT INTO LikeEvento VALUES ("Renato Pereira",28);
INSERT INTO LikeEvento VALUES ("Renato Pereira",29);
INSERT INTO LikeEvento VALUES ("Renato Pereira",30);
INSERT INTO LikeEvento VALUES ("Renato Pereira",31);
INSERT INTO LikeEvento VALUES ("Sara Santos",23);
INSERT INTO LikeEvento VALUES ("Sara Santos",27);
INSERT INTO LikeEvento VALUES ("Sara Santos",28);
INSERT INTO LikeEvento VALUES ("Sara Santos",29);
INSERT INTO LikeEvento VALUES ("Sara Santos",30);
INSERT INTO LikeEvento VALUES ("Sara Santos",31);

INSERT INTO LikePagina VALUES ("João Gil","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("João Gil","B-Club");
INSERT INTO LikePagina VALUES ("João Gil","Kopos Bar");
INSERT INTO LikePagina VALUES ("João Gil","Quilate Bar");
INSERT INTO LikePagina VALUES ("João Gil","Twins Foz");
INSERT INTO LikePagina VALUES ("João Gil","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("João Gil","BBC");
INSERT INTO LikePagina VALUES ("Sara Dinis","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Sara Dinis","B-Club");
INSERT INTO LikePagina VALUES ("Sara Dinis","Quilate Bar");
INSERT INTO LikePagina VALUES ("Sara Dinis","Kopos Bar");
INSERT INTO LikePagina VALUES ("Sara Dinis","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Isabel Mendes","B-Club");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Quilate Bar");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Kopos Bar");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Pitch");
INSERT INTO LikePagina VALUES ("Isabel Mendes","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("João Nuno","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("João Nuno","B-Club");
INSERT INTO LikePagina VALUES ("João Nuno","Quilate Bar");
INSERT INTO LikePagina VALUES ("João Nuno","Kopos Bar");
INSERT INTO LikePagina VALUES ("João Nuno","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("João Nuno","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("João Nuno","Twins Foz");
INSERT INTO LikePagina VALUES ("Carla Baía","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Carla Baía","B-Club");
INSERT INTO LikePagina VALUES ("Carla Baía","Quilate Bar");
INSERT INTO LikePagina VALUES ("Carla Baía","Kopos Bar");
INSERT INTO LikePagina VALUES ("Carla Baía","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Carla Baía","Vinil Bar");
INSERT INTO LikePagina VALUES ("Carla Baía","Gare");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","B-Club");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","Quilate Bar");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","Kopos Bar");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Raquel Bombardo","Eskada Porto");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","B-Club");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Quilate Bar");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Kopos Bar");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Estação da Luz");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Vinil Bar");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Twins Foz");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Pitch");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Gare");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","BBC");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","SKY");
INSERT INTO LikePagina VALUES ("Miguel Mimoso","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","B-Club");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Quilate Bar");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Kopos Bar");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Eskada Porto");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","Estação da Luz");
INSERT INTO LikePagina VALUES ("Afonso Guimarães","BBC");
INSERT INTO LikePagina VALUES ("Ana Montana","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Ana Montana","B-Club");
INSERT INTO LikePagina VALUES ("Ana Montana","Quilate Bar");
INSERT INTO LikePagina VALUES ("Ana Montana","Kopos Bar");
INSERT INTO LikePagina VALUES ("Ana Montana","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Estação da Luz");
INSERT INTO LikePagina VALUES ("Ricardo Leite","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Vinil Bar");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Twins Foz");
INSERT INTO LikePagina VALUES ("Ricardo Leite","Gare");
INSERT INTO LikePagina VALUES ("Ricardo Leite","BBC");
INSERT INTO LikePagina VALUES ("Rita Almeida","Estação da Luz");
INSERT INTO LikePagina VALUES ("Rita Almeida","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Rita Almeida","Vinil Bar");
INSERT INTO LikePagina VALUES ("Rita Almeida","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Rita Almeida","Eskada Porto");
INSERT INTO LikePagina VALUES ("Rui Leite","Estação da Luz");
INSERT INTO LikePagina VALUES ("Rui Leite","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Rui Leite","Vinil Bar");
INSERT INTO LikePagina VALUES ("Rui Leite","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Rui Leite","Eskada Porto");
INSERT INTO LikePagina VALUES ("Rui Leite","Pitch");
INSERT INTO LikePagina VALUES ("Nuno Taborda","Estação da Luz");
INSERT INTO LikePagina VALUES ("Nuno Taborda","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Nuno Taborda","Vinil Bar");
INSERT INTO LikePagina VALUES ("Nuno Taborda","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Nuno Taborda","BBC");
INSERT INTO LikePagina VALUES ("Nuno Taborda","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("André Patarrana","Estação da Luz");
INSERT INTO LikePagina VALUES ("André Patarrana","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("André Patarrana","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("André Patarrana","Kopos Bar");
INSERT INTO LikePagina VALUES ("André Patarrana","Twins Foz");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","Estação da Luz");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","Vinil Bar");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","SKY");
INSERT INTO LikePagina VALUES ("Raquel Fonseca","Quilate Bar");
INSERT INTO LikePagina VALUES ("Duarte Brandão","Twins Foz");
INSERT INTO LikePagina VALUES ("Duarte Brandão","Eskada Porto");
INSERT INTO LikePagina VALUES ("Duarte Brandão","VILLA Porto");
INSERT INTO LikePagina VALUES ("Duarte Brandão","Gare");
INSERT INTO LikePagina VALUES ("Duarte Brandão","Pitch");
INSERT INTO LikePagina VALUES ("Duarte Brandão","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Fernando José","Twins Foz");
INSERT INTO LikePagina VALUES ("Fernando José","Eskada Porto");
INSERT INTO LikePagina VALUES ("Fernando José","VILLA Porto");
INSERT INTO LikePagina VALUES ("Fernando José","Gare");
INSERT INTO LikePagina VALUES ("Fernando José","Pitch");
INSERT INTO LikePagina VALUES ("Fernando José","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Fernando José","BBC");
INSERT INTO LikePagina VALUES ("Fernando José","SKY");
INSERT INTO LikePagina VALUES ("Maria Sousa","Twins Foz");
INSERT INTO LikePagina VALUES ("Maria Sousa","Eskada Porto");
INSERT INTO LikePagina VALUES ("Maria Sousa","VILLA Porto");
INSERT INTO LikePagina VALUES ("Maria Sousa","Gare");
INSERT INTO LikePagina VALUES ("Maria Sousa","Pitch");
INSERT INTO LikePagina VALUES ("Maria Sousa","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Pedro João","Twins Foz");
INSERT INTO LikePagina VALUES ("Pedro João","Eskada Porto");
INSERT INTO LikePagina VALUES ("Pedro João","VILLA Porto");
INSERT INTO LikePagina VALUES ("Pedro João","Gare");
INSERT INTO LikePagina VALUES ("Pedro João","Pitch");
INSERT INTO LikePagina VALUES ("Pedro João","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Pedro João","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Pedro João","Estação da Luz");
INSERT INTO LikePagina VALUES ("Maria José","Twins Foz");
INSERT INTO LikePagina VALUES ("Maria José","Eskada Porto");
INSERT INTO LikePagina VALUES ("Maria José","VILLA Porto");
INSERT INTO LikePagina VALUES ("Maria José","Gare");
INSERT INTO LikePagina VALUES ("Maria José","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Maria José","BBC");
INSERT INTO LikePagina VALUES ("Maria José","Vinil Bar");
INSERT INTO LikePagina VALUES ("Joana Rita","Twins Foz");
INSERT INTO LikePagina VALUES ("Joana Rita","VILLA Porto");
INSERT INTO LikePagina VALUES ("Joana Rita","Gare");
INSERT INTO LikePagina VALUES ("Joana Rita","Pitch");
INSERT INTO LikePagina VALUES ("Joana Rita","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Joana Rita","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Maria João","Twins Foz");
INSERT INTO LikePagina VALUES ("Maria João","Pitch");
INSERT INTO LikePagina VALUES ("Maria João","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Maria João","Vinil Bar");
INSERT INTO LikePagina VALUES ("Maria João","SKY");
INSERT INTO LikePagina VALUES ("Rui Pedro","Twins Foz");
INSERT INTO LikePagina VALUES ("Rui Pedro","Eskada Porto");
INSERT INTO LikePagina VALUES ("Rui Pedro","VILLA Porto");
INSERT INTO LikePagina VALUES ("Rui Pedro","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Rita João","Twins Foz");
INSERT INTO LikePagina VALUES ("Rita João","Eskada Porto");
INSERT INTO LikePagina VALUES ("Rita João","VILLA Porto");
INSERT INTO LikePagina VALUES ("Rita João","Gare");
INSERT INTO LikePagina VALUES ("Rita João","Pitch");
INSERT INTO LikePagina VALUES ("Rita João","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Rita João","B-Club");
INSERT INTO LikePagina VALUES ("Rita João","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Carolina João","Twins Foz");
INSERT INTO LikePagina VALUES ("Carolina João","Eskada Porto");
INSERT INTO LikePagina VALUES ("Carolina João","Pitch");
INSERT INTO LikePagina VALUES ("Carolina João","BBC");
INSERT INTO LikePagina VALUES ("Carolina João","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Paula Martins","Twins Foz");
INSERT INTO LikePagina VALUES ("Paula Martins","Eskada Porto");
INSERT INTO LikePagina VALUES ("Paula Martins","VILLA Porto");

INSERT INTO LikePagina VALUES ("Paula Martins","Gare");
INSERT INTO LikePagina VALUES ("Paula Martins","Pitch");
INSERT INTO LikePagina VALUES ("Paula Martins","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Paula Martins","Quilate Bar");
INSERT INTO LikePagina VALUES ("Paula Martins","Vinil Bar");
INSERT INTO LikePagina VALUES ("João Pedro","Twins Foz");
INSERT INTO LikePagina VALUES ("João Pedro","Pitch");
INSERT INTO LikePagina VALUES ("João Pedro","Gare");
INSERT INTO LikePagina VALUES ("João Pedro","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("João Pedro","Kopos Bar");
INSERT INTO LikePagina VALUES ("Patricia João","Twins Foz");
INSERT INTO LikePagina VALUES ("Patricia João","Eskada Porto");
INSERT INTO LikePagina VALUES ("Patricia João","VILLA Porto");
INSERT INTO LikePagina VALUES ("Patricia João","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Patricia João","B-Club");
INSERT INTO LikePagina VALUES ("António Rodrigues","Twins Foz");
INSERT INTO LikePagina VALUES ("António Rodrigues","Eskada Porto");
INSERT INTO LikePagina VALUES ("António Rodrigues","VILLA Porto");
INSERT INTO LikePagina VALUES ("António Rodrigues","Gare");
INSERT INTO LikePagina VALUES ("António Rodrigues","Pitch");
INSERT INTO LikePagina VALUES ("António Rodrigues","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("António Rodrigues","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("António Rodrigues","Estação da Luz");
INSERT INTO LikePagina VALUES ("António Rodrigues","Vinil Bar");
INSERT INTO LikePagina VALUES ("Luis Lima","BBC");
INSERT INTO LikePagina VALUES ("Luis Lima","SKY");
INSERT INTO LikePagina VALUES ("Luis Lima","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Luis Lima","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Luis Lima","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Luis Lima","B-Club");
INSERT INTO LikePagina VALUES ("Luis Lima","Quilate Bar");
INSERT INTO LikePagina VALUES ("Luis Lima","Kopos Bar");
INSERT INTO LikePagina VALUES ("Luis Lima","Estação da Luz");
INSERT INTO LikePagina VALUES ("Luis Lima","Twins Foz");
INSERT INTO LikePagina VALUES ("Luis Lima","VILLA Porto");
INSERT INTO LikePagina VALUES ("Luis Lima","Pitch");
INSERT INTO LikePagina VALUES ("Mariana Machado","BBC");
INSERT INTO LikePagina VALUES ("Mariana Machado","SKY");
INSERT INTO LikePagina VALUES ("Mariana Machado","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Mariana Machado","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Mariana Machado","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Mariana Machado","Vinil Bar");
INSERT INTO LikePagina VALUES ("Rafael de Matos","BBC");
INSERT INTO LikePagina VALUES ("Rafael de Matos","SKY");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Rafael de Matos","B-Club");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Quilate Bar");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Kopos Bar");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Twins Foz");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Eskada Porto");
INSERT INTO LikePagina VALUES ("Rafael de Matos","VILLA Porto");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Pitch");
INSERT INTO LikePagina VALUES ("Rafael de Matos","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Cristina Leonor","BBC");
INSERT INTO LikePagina VALUES ("Cristina Leonor","SKY");
INSERT INTO LikePagina VALUES ("Cristina Leonor","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Cristina Leonor","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","BBC");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","SKY");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","Estação da Luz");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","Vinil Bar");
INSERT INTO LikePagina VALUES ("Diana Pinheiro","Kopos Bar");
INSERT INTO LikePagina VALUES ("Pedro Soares","BBC");
INSERT INTO LikePagina VALUES ("Pedro Soares","SKY");
INSERT INTO LikePagina VALUES ("Pedro Soares","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Pedro Soares","Optimus Primavera Sound");
INSERT INTO LikePagina VALUES ("Pedro Soares","Twins Foz");
INSERT INTO LikePagina VALUES ("Pedro Soares","VILLA Porto");
INSERT INTO LikePagina VALUES ("Pedro Soares","Gare");
INSERT INTO LikePagina VALUES ("Pedro Soares","B-Club");
INSERT INTO LikePagina VALUES ("Renato Pereira","BBC");
INSERT INTO LikePagina VALUES ("Pedro Soares","Eskada Porto");
INSERT INTO LikePagina VALUES ("Pedro Soares","Pitch");
INSERT INTO LikePagina VALUES ("Pedro Soares","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Pedro Soares","NB Club Aveiro");
INSERT INTO LikePagina VALUES ("Sara Santos","BBC");
INSERT INTO LikePagina VALUES ("Sara Santos","SKY");
INSERT INTO LikePagina VALUES ("Sara Santos","Hard Rock Cafe Lisboa");
INSERT INTO LikePagina VALUES ("Sara Santos","Grupo Andromeda");
INSERT INTO LikePagina VALUES ("Sara Santos","B-Club");
INSERT INTO LikePagina VALUES ("Sara Santos","Quilate Bar");
INSERT INTO LikePagina VALUES ("Sara Santos","Kopos Bar");
INSERT INTO LikePagina VALUES ("Sara Santos","Vinil Bar");
INSERT INTO LikePagina VALUES ("Sara Santos","Twins Foz");
INSERT INTO LikePagina VALUES ("Sara Santos","Eskada Porto");
INSERT INTO LikePagina VALUES ("Sara Santos","VILLA Porto");
INSERT INTO LikePagina VALUES ("Sara Santos","Gare");
INSERT INTO LikePagina VALUES ("Sara Santos","Pitch");
INSERT INTO LikePagina VALUES ("Sara Santos","Optimus Primavera Sound");

--1.Contar número de fotos de cada evento por ordem decrescente de número de fotos

.width 40 10
SELECT nome as "Nome do Evento", COUNT(*) as "Num Fotos" FROM Evento, FotoEvento WHERE Evento.idEvento = FotoEvento.idEvento GROUP BY nome ORDER BY COUNT(*) DESC;

--2. Contar número de pessoas que foram a cada evento por ordem decrescente de número de pessoas

.width 40 11
SELECT nome as "Nome do Evento", COUNT(*) "Num pessoas" FROM Evento, Guestbook, Utilizador WHERE
Evento.idEvento = Guestbook.idEvento AND Guestbook.username = Utilizador.username
GROUP BY nome ORDER BY COUNT(*) DESC;

--3. Contar número de comentários de cada evento

.width 40 15
SELECT nome as "Nome do Evento", COUNT(*) as "Num Comentários" FROM Evento, ComentarioEvento WHERE
Evento.idEvento = ComentarioEvento.idEvento
GROUP BY nome ORDER BY COUNT(*) DESC;

--4. Calcular a média etária de cada evento (ambos os sexos)

.width 40 15
select nome as "Nome do Evento", ROUND(avg(idade),1) as "Média Etária" from Guestbook, Evento, Utilizador where Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username group by nome;


--5. Calcular número de Homens, número de Mulheres e rácio Homens/Mulheres que foram a cada evento

.width 2 50 10 12 10
SELECT A.idEvento, A."nome do evento" as "Nome do Evento", B."numero de homens" as "Nº Homens", C."numero de mulheres" as "Nº Mulheres", ROUND(CAST(B."numero de homens" AS REAL)/CAST(C."numero de mulheres" AS REAL),2)  as "Rácio H/M" FROM
(SELECT Evento.idEvento, Evento.nome as "nome do evento" FROM Evento GROUP BY Evento.idEvento) as A
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "aevent", COUNT(sexo) as "numero de homens" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username AND Utilizador.sexo = "M" GROUP BY Evento.idEvento) as B on A.idEvento = B.idEvento
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "bevent", COUNT(sexo) as "numero de mulheres" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username AND Utilizador.sexo = "F" GROUP BY Evento.idEvento) as C on A.idEvento = C.idEvento 
GROUP BY A.idEvento;

--6. Obter o número de pessoas, a média etária e o rácio Homens/Mulher para cada evento

.width 50 15 15 15 15 15
SELECT AA."nome do evento" as "Nome do Evento", A."numero de pessoas" as "Nº pessoas", ROUND(B."media etaria",2) as "Média Etária", C."numero de homens" as "Nº Homens", D."numero de mulheres" as "Nº mulheres", ROUND(CAST(C."numero de homens" AS REAL)/CAST(D."numero de mulheres" AS REAL),2)  as "Rácio H/M" FROM
(SELECT Evento.idEvento, Evento.nome as "nome do evento" FROM Evento GROUP BY Evento.idEvento) as AA
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "aevent", COUNT(*) as "numero de pessoas" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username GROUP BY Evento.idEvento) as A on AA.idEvento = A.idEvento
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "bevent", AVG(idade) as "media etaria" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username GROUP BY Evento.idEvento) as B on AA.idEvento = B.idEvento
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "cevent", COUNT(sexo) as "numero de homens" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username AND Utilizador.sexo = "M" GROUP BY Evento.idEvento) as C on AA.idEvento = C.idEvento
LEFT JOIN (
SELECT Evento.idEvento, Evento.nome as "devent", COUNT(sexo) as "numero de mulheres" FROM Guestbook, Evento, Utilizador WHERE Guestbook.idEvento = Evento.idEvento AND Guestbook.username = Utilizador.username AND Utilizador.sexo = "F" GROUP BY Evento.idEvento) as D on AA.idEvento = D.idEvento 
GROUP BY AA.idEvento ORDER BY AA."nome do evento";


--7. Obter o número de fotos, número de comentários e o número de likes para cada evento

.width 2 50 13 18 13
SELECT AA.idEvento,AA."nome do evento" as "Nome do Evento",A."numero de fotos" as "Nº Fotos",B."numero de comentarios" as "Nº Comentários",C."numero de likes" as "Nº Likes" FROM
 (SELECT Evento.idEvento, Evento.nome AS "nome do evento" FROM Evento GROUP BY Evento.idEvento) AS AA 
LEFT JOIN (
SELECT Evento.idEvento,Evento.nome as "aevent",COUNT(*) as "numero de fotos" FROM FotoEvento, Evento WHERE FotoEvento.idEvento=Evento.idEvento GROUP BY Evento.idEvento) AS A ON AA.idEvento=A.idEvento 
LEFT JOIN (
SELECT Evento.idEvento,Evento.nome as "bevent", COUNT(*) as "numero de comentarios" FROM ComentarioEvento,Evento WHERE Evento.idEvento=ComentarioEvento.idEvento GROUP BY Evento.idEvento) AS B ON AA.idEvento=B.idEvento
LEFT JOIN (SELECT Evento.idEvento,Evento.nome as "cevent", COUNT(*) as "numero de likes" FROM Evento,LikeEvento WHERE Evento.idEvento=LikeEvento.idEvento GROUP BY Evento.idEvento) as C ON AA.idEvento=C.idEvento
GROUP BY AA.idEvento
ORDER BY "numero de likes" DESC;

--1. Lista de locais ordenada por “mais likes” efectuados por amigos do utilizador

.width 20 10
SELECT nome as "Nome do Local",COUNT(nome) AS "Nº de Likes" FROM (SELECT nome FROM LikePagina,(SELECT user2 FROM segue WHERE user1="João Gil") as US WHERE US.user2=LikePagina.username) AS LL GROUP BY nome ORDER BY "Nº de Likes" DESC;

--2. Lista de eventos ordenada por “mais likes” efectuados por “amigos” do utilizador

.width 50 7
SELECT Evento.nome as "Nome do Evento", ID.Likes FROM evento,
(SELECT F.nomeF as Nome,COUNT(*) as Likes FROM
(SELECT T.user2 as userF,U.idEvento as nomeF FROM (
SELECT user2 FROM segue WHERE user1="João Gil") as T INNER JOIN (
SELECT username,idEvento from LikeEvento GROUP BY idEvento) as U ON T.user2=U.username) as F, (SELECT T2.user2 as userF,U2.idEvento as nomeF FROM (
SELECT user2 FROM segue WHERE user1="João Gil") as T2 INNER JOIN (
SELECT username,idEvento from LikeEvento) as U2 ON T2.user2=U2.username) as K WHERE K.nomeF=F.nomeF GROUP BY K.nomeF) as ID WHERE Evento.idEvento=ID.nome ORDER BY Likes DESC;


--3. Listar o TOP 5 das pessoas mais “seguidas”

.width 20 14
SELECT Utilizador.username as "Username",COUNT(Following.user2) as Seguidores FROM Utilizador,(SELECT user2 FROM Segue) AS Following WHERE Utilizador.username=Following.user2 GROUP BY Utilizador.username ORDER BY Seguidores DESC LIMIT 5;


--1. Apresentar lista de locais na localidade do utilizador

.width 20 80 20
SELECT PaginaLocal.nome as "Nome do Local",PaginaLocal.morada as "Morada",PaginaLocal.localidade as "Localidade" FROM PaginaLocal WHERE PaginaLocal.localidade=(SELECT Utilizador.localidade FROM Utilizador WHERE Utilizador.username="Duarte Brandão");

--2. Listar próximos eventos cronologicamente

.width 15 50 80 24
SELECT PaginaLocal.nome as "Nome Local",Evento.nome as "Nome do Evento",Evento.descricao as "Descrição do Evento",Evento.dataInicio as "Data e Hora de Início" FROM Evento,PaginaLocal WHERE dataInicio>date('now') AND Evento.nomePagina=PaginaLocal.nome ORDER BY Evento.dataInicio; 


--1. Calcular o valor de receita bruta, proveniente das entradas, de um evento

.width 50 15 15 15
SELECT Evento.nome AS "Nome do Evento",TH.precoH AS "Total Homens",TM.precoM as "Total Mulheres",(TH.precoH+TM.precoM) as Total FROM Evento,(SELECT Evento.idEvento,tPH.precoH as precoH FROM Evento,(SELECT Evento.precoH*B.nH as precoH FROM Evento,(SELECT COUNT(A.username) AS nH FROM (SELECT username,idEvento FROM Guestbook WHERE idEvento=23) as A,Utilizador WHERE Utilizador.username=A.username AND Utilizador.sexo="M") AS B WHERE Evento.idEvento=23) as tPH WHERE Evento.idEvento=23) as TH LEFT JOIN (SELECT Evento.idEvento,tPM.precoM as precoM FROM Evento,(SELECT Evento.precoM*D.nM as precoM FROM Evento,(SELECT COUNT(C.username) AS nM FROM (SELECT username,idEvento FROM Guestbook WHERE idEvento=23) as C,Utilizador WHERE Utilizador.username=C.username AND Utilizador.sexo="F") AS D WHERE Evento.idEvento=23) as tPM WHERE Evento.idEvento=23) as TM ON TH.idEvento=TM.idEvento WHERE Evento.idEvento=23;


--2. Listar os eventos, lucro bruto por entradas femininas, lucro bruto por entradas masculinas e lucro bruto total de cada evento de um dado local

.width 50 15 15 15
SELECT Evento.nome AS "Nome do Evento",tPM.TM AS "Receitas Mulheres",tPH.TH AS "Receitas Homens",(tPM.TM+tPH.TH) AS "Receitas Totais" FROM Evento,(SELECT pNM.idEvento,Evento.precoM*pNM.nM AS TM FROM EVENTO,(SELECT TS.idEvento,COUNT(TS.sexo) as nM FROM (SELECT GL.idEvento,Utilizador.sexo FROM Utilizador JOIN (SELECT Guestbook.idEvento,username FROM Guestbook JOIN (SELECT idEvento FROM Evento WHERE Evento.nomePagina="Optimus Primavera Sound") AS EVS ON Guestbook.idEvento=EVS.idEvento) AS GL ON Utilizador.username=GL.username)AS TS WHERE TS.sexo="F" GROUP BY TS.idEvento) as pNM WHERE Evento.idEvento=pNM.idEvento) AS tPM JOIN (SELECT pNH.idEvento,Evento.precoH*pNH.nH AS TH FROM EVENTO,(SELECT TS.idEvento,COUNT(TS.sexo) as nH FROM (SELECT GL.idEvento,Utilizador.sexo FROM Utilizador JOIN (SELECT Guestbook.idEvento,username FROM Guestbook JOIN (SELECT idEvento FROM Evento WHERE Evento.nomePagina="Optimus Primavera Sound") AS EVS ON Guestbook.idEvento=EVS.idEvento) AS GL ON Utilizador.username=GL.username)AS TS WHERE TS.sexo="M" GROUP BY TS.idEvento) as pNH WHERE Evento.idEvento=pNH.idEvento) AS tPH ON tPM.idEvento=tPH.idEvento WHERE Evento.idEvento=tPM.idEvento;

--3. Calcular o valor de receita bruta total, proveniente das entradas, de um local

.width 50 15
SELECT Evento.nomePagina AS "Nome do Local",SUM(Tabela."Receitas Totais") as "Receitas Totais do Local" FROM Evento,(SELECT Evento.nome AS "Nome do Evento",tPM.TM AS "Receitas Mulheres",tPH.TH AS "Receitas Homens",(tPM.TM+tPH.TH) AS "Receitas Totais" FROM Evento,(SELECT pNM.idEvento,Evento.precoM*pNM.nM AS TM FROM EVENTO,(SELECT TS.idEvento,COUNT(TS.sexo) as nM FROM (SELECT GL.idEvento,Utilizador.sexo FROM Utilizador JOIN (SELECT Guestbook.idEvento,username FROM Guestbook JOIN (SELECT idEvento FROM Evento WHERE Evento.nomePagina="Optimus Primavera Sound") AS EVS ON Guestbook.idEvento=EVS.idEvento) AS GL ON Utilizador.username=GL.username)AS TS WHERE TS.sexo="F" GROUP BY TS.idEvento) as pNM WHERE Evento.idEvento=pNM.idEvento) AS tPM JOIN (SELECT pNH.idEvento,Evento.precoH*pNH.nH AS TH FROM EVENTO,(SELECT TS.idEvento,COUNT(TS.sexo) as nH FROM (SELECT GL.idEvento,Utilizador.sexo FROM Utilizador JOIN (SELECT Guestbook.idEvento,username FROM Guestbook JOIN (SELECT idEvento FROM Evento WHERE Evento.nomePagina="Optimus Primavera Sound") AS EVS ON Guestbook.idEvento=EVS.idEvento) AS GL ON Utilizador.username=GL.username)AS TS WHERE TS.sexo="M" GROUP BY TS.idEvento) as pNH WHERE Evento.idEvento=pNH.idEvento) AS tPH ON tPM.idEvento=tPH.idEvento WHERE Evento.idEvento=tPM.idEvento) AS Tabela WHERE Tabela."Nome do Evento"=Evento.nome;
