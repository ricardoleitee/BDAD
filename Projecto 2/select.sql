--TOP 10 Condutores com mais boleias criadas, ordenados por classificação decrescente
.width 30 20 5 10 15
SELECT nome,username,CAST(strftime('%Y.%m%d','now') - strftime('%Y.%m%d',datanascimento) as int) as idade, nboleias, classificacao
FROM Utilizador, (SELECT idUtilizador,COUNT(*) as nboleias
					FROM Utilizador, Boleia
					WHERE Utilizador.idUtilizador = Boleia.idcondutor
					GROUP BY idUtilizador
					ORDER BY nboleias DESC LIMIT 10) as v
WHERE Utilizador.idUtilizador = v.idUtilizador
ORDER BY classificacao DESC;


--TOP 10 condutores com melhor classificação, ordenados por quem recebeu mais feedbacks
.width 30 20 5 10 15
SELECT nome,username,CAST(strftime('%Y.%m%d','now') - strftime('%Y.%m%d',datanascimento) as int) as idade, nfeedbacks, classificacaoFROM Utilizador, (SELECT idUtilizador,COUNT(*) as nfeedbacks
					FROM Utilizador, Boleia, Feedback
					WHERE Utilizador.idUtilizador = Boleia.idcondutor
						AND Feedback.boleia = Boleia.idBoleia
						AND Feedback.receptor = Boleia.idCondutor
					GROUP BY idUtilizador ORDER BY nfeedbacks DESC LIMIT 10) as v
WHERE Utilizador.idUtilizador = v.idUtilizador
ORDER BY nfeedbacks DESC;

--Quantos passageiros já transportou cada condutor, ordenados por número decrescente de passageiros
.width 30 15
SELECT nome,COUNT(*) as npassageiros
FROM Utilizador,Boleia,Passageiro
WHERE Utilizador.idUtilizador = Boleia.idCondutor
	AND Boleia.idBoleia = Passageiro.boleia
	GROUP BY idCondutor
	ORDER BY npassageiros DESC;

--Para um determinado trajecto qual a média dos preços de cada boleia (Trajecto com id=1)
.width 10 5
SELECT idTrajecto, ROUND(AVG(precoTotal),1) as media
FROM Trajecto, Boleia
WHERE Trajecto.idTrajecto = Boleia.trajecto
AND idTrajecto=1
GROUP BY idTrajecto;

-- Condutores em cada trajecto ordenados por número de boleias criadas
.width 30 10 8
SELECT nome, idTrajecto, COUNT(*) as nboleias
FROM Boleia, Trajecto, Utilizador
WHERE Boleia.trajecto = Trajecto.idTrajecto
	AND Boleia.idCondutor = Utilizador.idUtilizador
GROUP BY trajecto,idCondutor
ORDER BY nboleias DESC;

--Para um determinado trajecto, a lista de condutores de esse trajecto, por ordem decrescente de número de boleias dadas por cada condutor (Trajecto com id=4)
.width 30 10 8
SELECT nome, idTrajecto, COUNT(*) as nboleias
FROM Boleia, Trajecto, Utilizador
WHERE Boleia.trajecto = Trajecto.idTrajecto
	AND Boleia.idCondutor = Utilizador.idUtilizador
	AND idTrajecto = 4
	GROUP BY nome
	ORDER BY nboleias DESC;

--Num determinado período quais são as boleias disponíveis para um determinado trajecto ordenado por preço total da boleia (Trajecto com id=78 e Data de partida entre “2014-08-01” e “2014-09-01”)
.width 8 10 19 19 10 13
SELECT idBoleia,idTrajecto, datapartida, datachegada, precoTotal, nLugaresVagos
FROM Boleia, Trajecto
WHERE Trajecto.idTrajecto = Boleia.trajecto
	AND datapartida BETWEEN "2014-08-01"
	AND "2014-09-01" AND idTrajecto=1
	AND nLugaresVagos > 0
GROUP BY idBoleia
ORDER BY precoTotal ASC;

--Número médio de passageiros por trajecto
.width 10 5
SELECT idTrajecto, ROUND(AVG(npassageiros),1) as media
FROM Trajecto, (SELECT trajecto, COUNT(*) as npassageiros
				FROM Passageiro, Boleia
				WHERE Passageiro.boleia = Boleia.idBoleia
				GROUP BY idBoleia) as a
WHERE a.trajecto = Trajecto.idTrajecto
GROUP BY idTrajecto;
