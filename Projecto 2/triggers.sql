-- TRIGGERS

-- Alerta antes de inserir um passageiro caso o número de Lugares Vagos para essa boleia seja zero
CREATE TRIGGER IF NOT EXISTS validaNpassageiros
BEFORE INSERT ON Passageiro
BEGIN
	SELECT RAISE(ABORT, 'Não pode inserir esse passageiro porque já não há lugares vagos')
	WHERE EXISTS (SELECT * FROM Boleia
			WHERE idBoleia=NEW.boleia
			AND nLugaresVagos=0);
END;

-- Actualiza o número de passageiros de uma Boleia após a inserção de um passageiro dessa Boleia
CREATE TRIGGER IF NOT EXISTS actualizarPassageiros
AFTER INSERT ON Passageiro
BEGIN
	UPDATE Boleia set nLugaresVagos=(nLugaresVagos-1) WHERE idBoleia=NEW.boleia;
END;

-- Actualiza o FeedBack de um Utilizador após a inserção de um feedback em que esse Utilizador é o receptor
CREATE TRIGGER IF NOT EXISTS actualizarFeedback
AFTER INSERT ON Feedback
BEGIN
	UPDATE Utilizador set classificacao=(SELECT ROUND(AVG(classificacao),1)
						FROM Feedback
						WHERE receptor=NEW.receptor)
	WHERE idUtilizador=NEW.receptor;
END;
