########Question 1
	Select M.name
    FROM Member M
    Where M.memberId In
    (Select P.PlayerId
    from player P
    Where P.PlayerId In
		(SELECT TM.memberId
		FROM TeamMember TM
		WHERE TM.TeamId IN
			(SELECT TeamId 
			From Team T
			Where T.Year="2018" && T.Country ="Australia"
			)));

########Question 2
SELECT Distinct Name
	FROM Member M
    Where M.MemberId in
    	(Select PlayerId
    	From Goals G
    	Where G.Count < 1);

########Question 3
Select MatchID
From `Match` 
Where HomeTeamId in
	(Select Distinct Tm.teamId
	From team Tm, Tournament T
	Where Tm.country=T.country )
OR
	AwayTeamID in
	(Select Distinct Tm.teamId
	From team Tm, Tournament T
	Where Tm.country=T.country )
AND
	MatchID in
    (Select MatchId
    From PoolGame)
;






########Question 4
Select Name
From Member 
Where Member.MemberID IN
	(SELECT PlayerID 
	FROM Player WHERE HomeClubName IN
		(SELECT HomeClubName 
		FROM HomeClub
		WHERE country = 'England')
	AND PlayerId IN
		(SELECT MemberId 
		FROM TeamMember
		WHERE teamId IN 
			(SELECT TeamId 
			FROM TEAM 
			WHERE Country='Australia')));

########Question 5
Select TeamId
from TeamMember
Where TeamMember.MemberId IN 
	(Select staffId 
	From supportstaff)
AND TeamMember.Year="2018"
Group By TeamMember.TeamId
Order By count(*) DESC;

########Question 6
Select M.Name, Sum(count)
From Saves S, Member M
Where PlayerId in(
	Select PlayerId 
	From Player) And S.PlayerId=M.MemberId
    Group by PlayerId;

########Question 7
SELECT max(cnt)
FROM
	(Select count(*) as cnt
	FROM ticket T
	Group by T.matchId) c

########Question 8
Select Member.Name
From Member
Where Member.MemberId In(
Select Distinct PlayerId 
From Goals
Where Goals.PlayerId In (
	Select  GP.PlayerId
	From Goals GP
	Where GP.MatchId IN(
		Select E.EliminationId
		From EliminationGame E)	 
	Group By PlayerId
	Having Sum(count) >= ALL 
		(Select Sum(count)
		From Goals GP
		Where GP.MatchId IN
			(Select E.EliminationId
			From EliminationGame E)	 
			Group By PlayerId
    )));

########Question 9
SELECT  Country
From Team
Group by Country
Having count(Country)>=(
SELECT Count(Year)
From Tournament);

########Question 10
Select Name
From Member
Where Member.MemberID IN 
	(Select PlayerId
	From Goals 
	Where Goals.MatchId IN(
		Select MatchId 
		From `Match` M
		Where M.HomeTeamId in 
			(Select TeamId
			From Team 
			Where Team.Country = "Iceland")
		OR 
		M.AwayTeamId in 
			(Select TeamId
			From Team 
			Where Team.Country = "Iceland")
)
Group by PlayerId
Having count(*)=(Select Count(*)
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
)));




    



	





























    




