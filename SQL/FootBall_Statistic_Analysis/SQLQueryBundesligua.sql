/*
Bundesliga sql analysis challenge
*/

--1 : Calcule le nombre moyen de buts marqués par match pour chaque équipe.

SELECT HomeTeam, AVG(FTHG) as Average_goal_when_home
FROM dbo.Bundesliga23
GROUP BY HomeTeam
Order by Average_goal_when_home DESC;

SELECT AwayTeam, AVG(FTAG) as Average_goal_when_away
FROM dbo.Bundesliga23
GROUP BY AwayTeam
ORDER BY Average_goal_when_away desc;

SELECT Team, AVG(TotalGoals) as AverageTotalGoals
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoals FROM dbo.Bundesliga23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoals FROM dbo.Bundesliga23
) AS CombinedGoal
GROUP BY Team;

/*
Identifie les équipes ayant la meilleure attaque 
(plus grand nombre de buts marqués) 
et la meilleure défense (moins de buts encaissés).
*/

-- A : (plus grand nombre de buts marqués) 

SELECT Team, SUM(TotalGoal) as SumOfTotalGoalAsBestoffence
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal FROM dbo.Bundesliga23
UNION ALL
SELECT AwayTeam as Team, FTAG as TotalGoal FROM dbo.Bundesliga23
) as TotaledGoal
GROUP BY Team
Order by SumOfTotalGoalAsBestoffence DESC;


-- B : (moins de buts encaissés).
SELECT Team, SUM(TotalGoalConceded) as SumOfTotalGoalConcededAsBestDedense
FROM (
SELECT HomeTeam as Team, FTAG as TotalGoalConceded FROM dbo.Bundesliga23
UNION ALL
SELECT AwayTeam as Team, FTHG as TotalGoalConceded FROM dbo.Bundesliga23
) as ConcededGoal
GROUP BY Team
Order by SumOfTotalGoalConcededAsBestDedense ASC;

/*
Crée des graphiques pour visualiser ces statistiques.
*/

DROP TABLE if exists BestAttackAndDefense;
-- Create the BestAttackAndDefense table (if it doesn't exist)
CREATE TABLE BestAttackAndDefense
(
    TeamName VARCHAR(250),
    TotalScoredGoal INT,
    TotalConceledGoal INT
);

INSERT INTO BestAttackAndDefense (TeamName, TotalScoredGoal, TotalConceledGoal)
SELECT Team, SUM(TotalGoal) as TotalScoredGoal, SUM(TotalGoalConceled) as TotalConceledGoal
FROM (
SELECT HomeTeam as Team, FTHG as TotalGoal, FTAG as TotalGoalConceled FROM dbo.Bundesliga23
UNION ALL 
SELECT AwayTeam as Team, FTAG as TotalGoal, FTHG as TotalGoalConceled FROM dbo.Bundesliga23
) as CombinedData
GROUP BY team;


SELECT * FROM BestAttackAndDefense
ORDER BY TotalConceledGoal asc;


