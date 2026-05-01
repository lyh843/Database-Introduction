-- 姓名：李云浩
-- 学号：241880324
-- 提交前请确保本次实验独立完成，若有参考请注明并致谢。

SHOW DATABASES;
USE phonemon;

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1
SELECT COUNT(*) speciesCount
FROM species
WHERE description LIKE "%this%";
-- END Q1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2
SELECT player.username username, SUM(phonemon.power) totalPhonemonPower
FROM player
JOIN phonemon ON phonemon.player=player.id
where (player.username="Cook" OR player.username="Hughes")
GROUP BY player.id;
-- END Q2
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3
SELECT team.title title, COUNT(*) numberOfPlayers
FROM team
JOIN player ON player.team = team.id
GROUP BY team.id;
-- END Q3

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q4
SELECT species.id idSpecies, species.title title
FROM species, type
where type.title = "grass" AND (species.type1 = type.id OR species.type2 = type.id);
-- END Q4

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q5
SELECT player.id idPlayer, player.username username
FROM player
where NOT EXISTS(
    SELECT *
    FROM purchase
    JOIN item ON purchase.item = item.id
    WHERE item.type='F' AND purchase.player = player.id
);
-- END Q5

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q6
SELECT player.level level, SUM(item.price * purchase.quantity)totalAmountSpentByAllPlayersAtLevel
FROM player
JOIN purchase ON purchase.player = player.id
JOIN item ON item.id = purchase.item
GROUP BY player.level
ORDER BY totalAmountSpentByAllPlayersAtLevel DESC;
-- END Q6

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q7
SELECT item.id item, item.title title, COUNT(*) numTimesPurchased
FROM purchase
JOIN item ON purchase.item = item.id
GROUP BY item.id
HAVING COUNT(*)=(
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) cnt
        FROM purchase
        GROUP BY purchase.item
    ) temp
);
-- END Q7

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q8
SELECT player.id playerID, player.username username, COUNT(DISTINCT food.id) numberDistinctFoodItemsPurchased
FROM player
JOIN purchase ON purchase.player = player.id
JOIN food ON food.id = purchase.item
GROUP by player.id, player.username
HAVING COUNT(DISTINCT food.id) = (
    SELECT COUNT(*)
    FROM food
);
-- END Q8

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q9
SELECT COUNT(*) numberOfPhonemonPairs, MIN(
    ROUND(
        SQRT(
            (p1.latitude - p2.latitude) * (p1.latitude - p2.latitude) + 
            (p1.longitude - p2.longitude) * (p1.longitude - p2.longitude)
        ) * 100, 2
    )
) distanceX
FROM phonemon p1
JOIN phonemon p2 ON p2.id > p1.id;
-- END Q9

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q10
SELECT DISTINCT player.username username, type.title typeTitle
FROM player
JOIN type
where NOT EXISTS (
    SELECT *
    FROM species
    where (species.type1 = type.id OR species.type2 = type.id) AND
        NOT EXISTS (
            SELECT *
            FROM phonemon
            where phonemon.player = player.id AND phonemon.species = species.id
        )
);
-- END Q10