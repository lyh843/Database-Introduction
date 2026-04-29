-- 姓名：李云浩
-- 学号：241880324
-- 提交前请确保本次实验独立完成，若有参考请注明并致谢。

SHOW DATABASES;
USE phonemon;

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1
SELECT COUNT(*) speciesCount
FROM species
WHERE LOWER(description) LIKE "%this%";

SELECT COUNT(*) speciesCount
FROM species
WHERE LOWER(description) REGEXP '(^|[^a-z])this([^a-z]|$)';
-- END Q1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2
SELECT username, SUM(power) totalPhonemonPower
FROM player, phonemon
WHERE (username='Cook' OR username='Hughes') AND phonemon.player = player.id
GROUP BY username;
-- END Q2
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3
SELECT title, Count(player.id) numberOfPlayers
FROM team, player
WHERE team.id = player.team
GROUP BY team.title
ORDER BY Count(player.id) DESC;
-- END Q3

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q4
SELECT species.id idSpecies, species.title title
FROM species, type
WHERE type.title = 'Grass' AND (type.id = species.type1 OR type.id = species.type2);
-- END Q4

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q5
SELECT P1.id idPlayer, P1.username username
FROM player P1
where NOT EXISTS(
    SELECT P1.id
    FROM purchase, item
    WHERE purchase.item = item.id AND item.type = 'F' AND purchase.player = P1.id
);
-- END Q5

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q6
SELECT player.level level, SUM(item.price * purchase.quantity) totalAmountSpentByAllPlayersAtLevel
FROM player
JOIN purchase ON player.id = purchase.player
JOIN item ON purchase.item = item.id
GROUP BY player.level
ORDER BY totalAmountSpentByAllPlayersAtLevel DESC;
-- END Q6

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q7
SELECT item.id item, item.title title, Count(*) numTimesPurchased
FROM purchase
JOIN item ON purchase.item = item.id
GROUP BY item.id, item.title
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM purchase
        GROUP BY item
    ) temp
);
-- END Q7

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q8
SELECT player.id playerID, player.username username, numberDistinctFoodItemsPurchased
FROM player
JOIN purchase
-- END Q8

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q9
SELECT numberOfPhonemonPairs, distanceX

-- END Q9

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q10

-- END Q10