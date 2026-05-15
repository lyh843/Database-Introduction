# 《数据库概论》实验一：用 SQL 进行数据操作 实验报告

**姓名：** 李云浩		**学号：** 241880324		**联系方式：** 2641805259@qq.com

---

## 实验环境

操作系统为 windows，采用 VS code ide 以及其中的 SQLTools 插件进行代码编写与运行。MySQL 版本是 8.0.46-winx64.

## 实验过程

**题目一**

```mysql
SELECT COUNT(*) speciesCount
FROM species
WHERE description LIKE "%this%";
```

![image-20260505112013634](/t1.png)

采用通配符`%`，从而找到含有字符串"this"的 description.

**题目二**

```mysql
SELECT player.username username, SUM(phonemon.power) totalPhonemonPower
FROM player
JOIN phonemon ON phonemon.player=player.id
where (player.username="Cook" OR player.username="Hughes")
GROUP BY player.id;
```

![image-20260505112246851](/t2.png)

利用`Group BY`，告诉`SUM`应该对每个不同的`player.id`的`player.power`进行求和。

**‘题目三**

```mysql
SELECT team.title title, COUNT(*) numberOfPlayers
FROM team
JOIN player ON player.team = team.id
GROUP BY team.id
ORDER BY numberOfPlayers DESC;
```

![image-20260505112450903](/t3.png)

利用`Group BY`对每个不同的`team.id`中利用`COUNT(*)`进行计数；并利用`ORDER BY`以及`DESC`使结果降序列出。

**题目四**

```mysql
SELECT species.id idSpecies, species.title title
FROM species, type
where type.title = "grass" AND (species.type1 = type.id OR species.type2 = type.id);
```

![image-20260505112524448](/t4.png)

在`where`语句中执行复合条件查询。

**题目五**

```mysql
SELECT player.id idPlayer, player.username username
FROM player
where NOT EXISTS(
    SELECT *
    FROM purchase
    JOIN item ON purchase.item = item.id
    WHERE item.type='F' AND purchase.player = player.id
);
```

![image-20260505112616414](t5.png)

利用`NOT EXISTS`找出不存在在购买过食物名单的人，从而确定没有购买过食物的`player`.

**题目六**

```mysql
SELECT player.level level, SUM(item.price * purchase.quantity)totalAmountSpentByAllPlayersAtLevel
FROM player
JOIN purchase ON purchase.player = player.id
JOIN item ON item.id = purchase.item
GROUP BY player.level
ORDER BY totalAmountSpentByAllPlayersAtLevel DESC;
```

![image-20260505112653866](t6.png)

利用`Group BY`对每个不同的`player.level`中利用`SUM`进行计数；并利用`ORDER BY`以及`DESC`使结果降序列出。

**题目七**

```mysql
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
```

![image-20260505112719340](t7.png)

采用`having`语句对`COUNT(*)`的结果进行进一步约束。

**题目八**

```mysql
SELECT player.id playerID, player.username username, COUNT(DISTINCT food.id) numberDistinctFoodItemsPurchased
FROM player
JOIN purchase ON purchase.player = player.id
JOIN food ON food.id = purchase.item
GROUP by player.id, player.username
HAVING COUNT(DISTINCT food.id) = (
    SELECT COUNT(*)
    FROM food
);
```

![image-20260505112743514](t8.png)

同样采用`having`语句来对`COUNT`的结果进行约束。

**题目九**

```mysql
SELECT COUNT(*) numberOfPhonemonPairs, ROUND(
    SQRT(
        (p1.latitude - p2.latitude) * (p1.latitude - p2.latitude) + 
        (p1.longitude - p2.longitude) * (p1.longitude - p2.longitude)
    ) * 100, 2
) distanceX
FROM phonemon p1
JOIN phonemon p2 ON p2.id > p1.id
GROUP BY distanceX
HAVING distanceX = (
    SELECT MIN(
        ROUND(
            SQRT(
                (p3.latitude - p4.latitude) * (p3.latitude - p4.latitude) + 
                (p3.longitude - p4.longitude) * (p3.longitude - p4.longitude)
            ) * 100, 2
        )
    )
    FROM phonemon p3
    JOIN phonemon p4 ON p3.id > p4.id
);
```

![image-20260505112806130](t9.png)

同样采用`having`语句来对`ROUND`的结果进行约束。同时通过嵌套查询确定最小的距离。

**题目十**

```mysql
SELECT player.username username, type.title typeTitle
FROM player
JOIN type
WHERE NOT EXISTS(
    SELECT *
    FROM species
    WHERE (species.type1 = type.id OR species.type2 = type.id) AND NOT EXISTS(
        SELECT *
        FROM phonemon
        where phonemon.species = species.id AND phonemon.player = player.id
    )
);
```

![image-20260505112823591](t10.png)

双重`NOT EXISTS`来实现符号表达式中的除法功能。

---

## 实验中遇到的困难及解决办法

感觉作为初次的SQL实验，在实验文档中可以给出较为详细的环境配置方法，以及相关工具的简单使用教学。

## 参考文献及致谢

主要参考课程PPT为主，在实验中遇到了一些思考后仍不太能解决的问题时有借助 AI 工具。