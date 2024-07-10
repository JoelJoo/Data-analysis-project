/*
La liga sql analysis challenge
*/

--1 : Calcule le nombre moyen de buts marqués par match pour chaque équipe.

-- A match a domicile

SELECT HomeTeam, AVG(FTHG) as AverageHometeamGoal
FROM LaLiga23
GROUP BY HomeTeam;

-- B match a l'exterieur

SELECT AwayTeam, AVG(FTAG) as AverageAwayTeamGoal
FROM LaLiga23
GROUP BY AwayTeam;

-- C match a domicile et a l'exterieur

SELECT Team, AVG(TotalGoal) as AverageTotalGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal from LaLiga23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoal from LaLiga23
) as GlobalAverageTotalGoal
GROUP BY Team
ORDER BY AverageTotalGoal DESC;

/*
Identifie les équipes ayant la meilleure attaque 
(plus grand nombre de buts marqués) 
et la meilleure défense (moins de buts encaissés).
*/

-- A : (plus grand nombre de buts marqués a domicile)
SELECT HomeTeam, SUM(FTHG) as SUMOfGoalWhenHome
FROM LaLiga23
GROUP BY HomeTeam
Order By SUMOfGoalWhenHome desc;


-- B : (plus grand nombre de buts marqués a l'exterieur)
SELECT AwayTeam, SUM(FTAG) as SUMOfGoalWhenAway
FROM LaLiga23
GROUP BY AwayTeam
ORDER BY SUMOfGoalWhenAway desc;


-- C : (plus grand nombre de buts marqués a l'exterieur comme a l'exterieur)
SELECT Team, SUM(TotalGoal) as TotalScoredGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal FROM LaLiga23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoal FROM LaLiga23
) as CombinedTotalGoal
GROUP BY Team
ORDER BY TotalScoredGoal desc;


-- AA : (moins de buts encaissés a domicile).
SELECT HomeTeam, SUM(FTAG) as ConceledGoalAtHome
FROM LaLiga23
GROUP BY HomeTeam
ORDER BY ConceledGoalAtHome asc;


-- AB : (moins de buts encaissés a l'exterieur).
SELECT AwayTeam, SUM(FTHG) as ConceledGoalWhenAway
FROM LaLiga23
GROUP BY AwayTeam
ORDER BY ConceledGoalWhenAway asc;


-- AB : (moins de buts encaissés a l'exterieur comme a domicile).
SELECT Team, SUM(TotalConceledGoal) as ConceledGoal
FROM (
SELECT HomeTeam as Team, FTAG as TotalConceledGoal FROM LaLiga23
UNION ALL
SELECT AwayTeam as Team, FTHG as TotalConceledGoal FROM LaLiga23
) as GlobalConceledGoal
GROUP BY Team
ORDER BY ConceledGoal asc;

/*
Crée des graphiques pour visualiser ces statistiques.
*/

DROP TABLE IF exists LaLiga23BestAttackAndDefense;
CREATE TABLE LaLiga23BestAttackAndDefense
(TeamName varchar(250),
ScoredGoal int,
ConceledGoal int
);

INSERT INTO LaLiga23BestAttackAndDefense (TeamName, ScoredGoal, ConceledGoal)
SELECT Team, SUM(TotalScored) as TotalScoredGoal, SUM(TotalConceled) as TotalConceledGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalScored, FTAG as TotalConceled FROM LaLiga23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalScored, FTHG as TotalConceled FROM LaLiga23
) as GlobalTotalConceledGoal
GROUP BY Team;

SELECT * FROM LaLiga23BestAttackAndDefense;
