
PRAGMA foreign_keys = ON;
.mode columns
.headers on

DROP TABLE IF EXISTS Utilizador;
DROP TABLE IF EXISTS Marca;
DROP TABLE IF EXISTS Modelo;
DROP TABLE IF EXISTS Combustivel;
DROP TABLE IF EXISTS Carro;
DROP TABLE IF EXISTS RegraUtilizacao;
DROP TABLE IF EXISTS RegraCarro;
DROP TABLE IF EXISTS Conforto;
DROP TABLE IF EXISTS ConfortoCarro;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Trajecto;
DROP TABLE IF EXISTS Paragem;
DROP TABLE IF EXISTS Boleia;
DROP TABLE IF EXISTS Passageiro;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Pagamento;

CREATE TABLE Utilizador(
	idUtilizador INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome NVARCHAR2(50),
	sexo NVARCHAR2(50) CHECK (sexo=="M" OR sexo=="F"),
	dataNascimento DATE,
	email NVARCHAR2(50) UNIQUE,
	username NVARCHAR2(50) UNIQUE,
	password NVARCHAR2(50),
	classificacao FLOAT DEFAULT 0.0
);

CREATE TABLE Marca(
	idMarca INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome NVARCHAR2(50) UNIQUE
);

CREATE TABLE Modelo(
	idModelo INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome NVARCHAR2(50),
	marca INTEGER NOT NULL REFERENCES Marca(idMarca)
);

CREATE TABLE Combustivel(
	idCombustivel INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome NVARCHAR2(50) UNIQUE
);

CREATE TABLE Carro(
	idCarro INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	consumo FLOAT CHECK (consumo > 0.0),
	anoRegisto INT CHECK (anoRegisto > 1984),
	dono INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	combustivel INTEGER NOT NULL REFERENCES Combustivel(idCombustivel),
	modelo INTEGER NOT NULL REFERENCES Modelo(idModelo)
);

CREATE TABLE RegraUtilizacao(
	idRegra INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	descricao NVARHCAR2(100)
);

CREATE TABLE RegraCarro(
	regra INTEGER NOT NULL REFERENCES RegraUtilizacao(idRegra),
	carro INTEGER NOT NULL REFERENCES Carro(idCarro),
	CONSTRAINT pk_CondicaoCarro PRIMARY KEY (regra, carro)
);

CREATE TABLE Conforto(
	idConforto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	descricao NVARHCAR2(100)
);

CREATE TABLE ConfortoCarro(
	conforto INTEGER NOT NULL REFERENCES Conforto(idConforto),
	carro INTEGER NOT NULL REFERENCES Carro(idCarro),
	CONSTRAINT pk_ConfortoCarro PRIMARY KEY (conforto, carro)
);

CREATE TABLE Cidade(
	idCidade INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome NVARHCAR2(50) UNIQUE
);

CREATE TABLE Trajecto(
	idTrajecto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	origem INTEGER NOT NULL REFERENCES Cidade(idCidade),
	destino INTEGER NOT NULL REFERENCES Cidade(idCidade)
);

CREATE TABLE Paragem(
	trajecto NOT NULL REFERENCES Trajecto(idTrajecto),
	paragem NOT NULL REFERENCES Cidade(idCidade),
	CONSTRAINT pk_Paragem PRIMARY KEY (trajecto, paragem)
);

CREATE TABLE Boleia(
	idBoleia INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	datapartida DATETIME,
	datachegada DATETIME,
	precoTotal FLOAT CHECK (precoTotal > 0.0),
	precoMala FLOAT CHECK (precoMala > 0.0),
	nLugaresVagos INT CHECK (nLugaresVagos >= 0 AND nLugaresVagos < 5),
	trajecto INTEGER NOT NULL REFERENCES Trajecto(idTrajecto),
	carro INTEGER NOT NULL REFERENCES Carro(idCarro),
	idCondutor INTEGER NOT NULL REFERENCES Utilizador(idUtilizador)
);

CREATE TABLE Passageiro(
	passageiro INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	boleia INTEGER NOT NULL REFERENCES Boleia(idBoleia),
	levamala BOOLEAN, 
	CONSTRAINT pk_Condutor PRIMARY KEY (passageiro, boleia)
);

CREATE TABLE Feedback(
	idFeedback INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	boleia INTEGER NOT NULL REFERENCES Boleia(idBoleia),
	emissor INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	receptor INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	descricao NVARCHAR2(100),
	classificacao INT NOT NULL CHECK (classificacao > 0 AND classificacao < 6)
);

CREATE TABLE Pagamento(
	idPagamento INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	boleia INTEGER NOT NULL REFERENCES Boleia(idBoleia),
	emissor INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	receptor INTEGER NOT NULL REFERENCES Utilizador(idUtilizador),
	descricao NVARCHAR2(100),
	valor FLOAT NOT NULL CHECK (valor > 0),
	data DATE,
	estadoPagamento BOOLEAN
);
