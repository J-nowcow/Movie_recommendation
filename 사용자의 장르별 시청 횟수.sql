CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `사용자의 장르별 시청 횟수` AS
    SELECT 
        `g`.`Genre` AS `Genre`, COUNT(`g`.`Genre`) AS `count(Genre)`
    FROM
        (`user_has_movie` `u`
        JOIN `genre_has_movie` `g` ON ((`u`.`Movie_Code` = `g`.`Movie_Code`)))
    WHERE
        (`u`.`User_ID` = 0)
    GROUP BY `g`.`Genre`
    ORDER BY COUNT(`g`.`Genre`) DESC