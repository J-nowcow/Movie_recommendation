CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `나이대별 선호 장르` AS
    SELECT 
        `g`.`Genre` AS `Genre`, COUNT(`g`.`Genre`) AS `count(Genre)`
    FROM
        ((`user` `u`
        JOIN `user_has_movie` `m` ON ((`u`.`User_ID` = `m`.`User_ID`)))
        JOIN `genre_has_movie` `g` ON ((`m`.`Movie_Code` = `g`.`Movie_Code`)))
    WHERE
        (`u`.`Age` BETWEEN 20 AND 29)
    GROUP BY `g`.`Genre`
    ORDER BY COUNT(`g`.`Genre`) DESC