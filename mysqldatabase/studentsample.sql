CREATE DATABASE `student_database`;

USE `student_database`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
    `id` INT NOT NULL,
    `media_id` INT NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT into `user`(`id`,`media_id`,`name`) VALUES (1,101,'Suraj'),
(2,102,'Rohan'),
(3,103,'Roop'),
(4,104,'Ravi');

DROP TABLE IF EXISTS `media`;

CREATE TABLE `media`(
    `id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `path` VARCHAR(70) NOT NULL,
    `filetype` VARCHAR(20) NOT NULL,
    `filesize` DECIMAL NOT NULL,
    PRIMARY KEY (`id`)
    -- CONSTRAINT FK_usermedia FOREIGN KEY(`user_id`) REFERENCES user(`id`)
);

INSERT into `media` (`id`,`user_id`,`path`,`filetype`,`filesize`)
VALUES
(101,1,'x','doc',25.01),
(102,2,'y','zip',12.24);

DROP TABLE IF EXISTS `comment_has_media`;

CREATE TABLE `comment_has_media`(
    `comment_id` INT NOT NULL,
    `comment_bug_project_id` INT NOT NULL,
    `comment_bug_id` INT NOT NULL,
    `media_id` INT NOT NULL,
    PRIMARY KEY (`comment_id`)
);

INSERT into `comment_has_media` (`comment_id`, `comment_bug_project_id`, `comment_bug_id`, `media_id` )
VALUES
(101,11,45,1),
(102,21,55,2);


DROP TABLE IF EXISTS `bug_has_media`;
CREATE TABLE `bug_has_media`(
    `bug_id` INT NOT NULL,
    `bug_project_id` INT NOT NULL,
    `media_id` INT NOT NULL,
    PRIMARY KEY (`bug_id`)
    -- CONSTRAINT FK_bugmedia FOREIGN KEY(`bug_id`) REFERENCES `media`(`id`)
);

INSERT into  `bug_has_media`(`bug_id`,`bug_project_id`,`media_id` )
VALUES
(101,11,1),
(102,21,4);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment`(
    `id` INT NOT NULL,
    `bug_project_id` INT NOT NULL,
    `bug_id` INT NOT NULL,
    `text` TEXT,
    PRIMARY KEY (`id`)
    -- CONSTRAINT FK_comment FOREIGN KEY(`id`) REFERENCES `comment_has_media`(`media_id`)
);

INSERT into  `comment`(`id`,`bug_project_id`,`bug_id`,`text` )
VALUES
(1,11,101,'syntax'),
(2,21,404,'error');


DROP TABLE IF EXISTS `bug`;
CREATE TABLE `bug`(
    `id` INT NOT NULL,
    `project_id` INT NOT NULL,
    `name` VARCHAR(45),
    PRIMARY KEY (`id`)
    -- CONSTRAINT FK_commentbug FOREIGN KEY(`id`) REFERENCES `comment`(`id`)
    );

    INSERT into  `bug`(`id`,`project_id`,`name` )
VALUES

(1,11,'syntax error'),
(2,21,'h');


DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`(
    `id` INT NOT NULL,
    `name` VARCHAR(45),
    PRIMARY KEY (`id`)
    -- CONSTRAINT FK_project FOREIGN KEY(`id`) REFERENCES `comment`(`id`)
    );

    INSERT into  `project`(`id`,`name` )
VALUES
(1,'angular'),
(2,'javascript');

DROP TABLE IF EXISTS `project_has_user`;
CREATE TABLE `project_has_user`(
    `project_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    -- `manager_name` VARCHAR(50) NOT NULL, 
    PRIMARY KEY (`project_id`)
    --  CONSTRAINT FK_projectuser FOREIGN KEY(`user_id`) REFERENCES `user`(`id`)
    );

    INSERT into  `project_has_user`(`project_id`,`user_id` )
VALUES
(101,1);








