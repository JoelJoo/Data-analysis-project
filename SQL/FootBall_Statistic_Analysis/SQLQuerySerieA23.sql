/*
SerieA23 sql analysis challenge
*/

--1 : Calcule le nombre moyen de buts marqués par match pour chaque équipe.

-- A match a domicile
SELECT HomeTeam, AVG(FTHG) as AvergeGoalWhenHome
FROM SerieA23
GROUP BY HomeTeam
ORDER BY AvergeGoalWhenHome desc;

-- B match a l'exterieur
SELECT AwayTeam, AVG(FTAG) as AvergeGoalWhenAway
FROM SerieA23
GROUP BY AwayTeam
ORDER BY AvergeGoalWhenAway desc;

-- C match a domicile et a l'exterieur
SELECT Team, AVG(TotalGoal) as AverageGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal FROM SerieA23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoal FROM SerieA23
) as CombinedGoal
GROUP BY Team
ORDER BY AverageGoal desc;

/*
Identifie les équipes ayant la meilleure attaque 
(plus grand nombre de buts marqués) 
et la meilleure défense (moins de buts encaissés).
*/

-- A : (plus grand nombre de buts marqués a domicile)
SELECT HomeTeam, SUM(FTHG) as TotalGoalWhenHome
FROM SerieA23
GROUP BY HomeTeam
ORDER BY TotalGoalWhenHome desc;

-- B : (plus grand nombre de buts marqués a l'exterieur)
SELECT AwayTeam, SUM(FTAG) as TotalGoalWhenAway
FROM SerieA23
GROUP BY AwayTeam
ORDER BY TotalGoalWhenAway desc;

-- C : (plus grand nombre de buts marqués a l'exterieur comme a l'exterieur)
SELECT Team, SUM(TotalGoal) as SumTotalGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal FROM SerieA23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoal FROM SerieA23
) as GlobalSumTotalGoal
GROUP BY Team
ORDER BY SumTotalGoal desc;

-- AA : (moins de buts encaissés a domicile).
SELECT HomeTeam, SUM(FTAG) as ConceledTotalGoalWhenAway
FROM SerieA23
GROUP BY HomeTeam
ORDER BY ConceledTotalGoalWhenAway asc;

-- AB : (moins de buts encaissés a l'exterieur).
SELECT AwayTeam, SUM(FTHG) as ConceledGoalWhenAway
FROM SerieA23
GROUP BY AwayTeam
ORDER BY ConceledGoalWhenAway asc;

-- AB : (moins de buts encaissés a l'exterieur comme a domicile).
SELECT Team, SUM(TotalConceledGoal) as TotalGoalConceled
FROM (
SELECT HomeTeam AS Team, FTAG as TotalConceledGoal FROM SerieA23
UNION ALL
SELECT AwayTeam AS Team, FTHG as TotalConceledGoal FROM SerieA23
) as GlobalTotalGoalConceled
group by Team
ORDER BY TotalGoalConceled asc;


/*
Crée des graphiques pour visualiser ces statistiques.
*/

DROP TABLE IF exists SerieA23BestAttackAndDefense
CREATE TABLE SerieA23BestAttackAndDefense 
(TeamName varchar(250),
ScoredGoal int,
ConceledGoal int
)

INSERT INTO SerieA23BestAttackAndDefense (TeamName, ScoredGoal, ConceledGoal)
SELECT Team, SUM(ScoredGoal) as TotalScoredGoal, SUM(ConceledGoal) as TotalConceledGoal
FROM (
SELECT HomeTeam as Team, FTHG as ScoredGoal, FTAG as ConceledGoal FROM SerieA23
UNION ALL
SELECT AwayTeam as Team, FTAG as ScoredGoal, FTHG as ConceledGoal FROM SerieA23
) as GlobalTotalConceledGoal
GROUP BY Team;

SELECT * FROM SerieA23BestAttackAndDefense;