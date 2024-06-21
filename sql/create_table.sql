-- MySQL Script generated by MySQL Workbench
-- Sat Jun 15 10:33:32 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lab2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab2` DEFAULT CHARACTER SET utf8 ;
USE `lab2` ;

DROP TABLE IF EXISTS school, major, class, student, teacher, course, course_instance, select_course, image;
DROP FUNCTION IF EXISTS get_student_email;
DROP PROCEDURE IF EXISTS update_student_email;
DROP PROCEDURE IF EXISTS get_all_course_info;
DROP PROCEDURE IF EXISTS student_select_course;
DROP PROCEDURE IF EXISTS get_selected_cource;
DROP PROCEDURE IF EXISTS student_quit_course;
DROP PROCEDURE IF EXISTS get_cource_score;
DROP PROCEDURE IF EXISTS get_selected_student;
DROP PROCEDURE IF EXISTS change_score;
DROP PROCEDURE IF EXISTS update_course_state;
DROP PROCEDURE IF EXISTS add_image;
DROP PROCEDURE IF EXISTS update_profile_picture;
DROP TRIGGER IF EXISTS `lab2`.`update_enrollment_after_insert`;
DROP TRIGGER IF EXISTS `lab2`.`update_enrollment_after_delete`;
DROP PROCEDURE IF EXISTS get_teacher_info;
DROP PROCEDURE IF EXISTS get_teached_course;
DROP FUNCTION IF EXISTS get_student_image_path;

-- -----------------------------------------------------
-- Table `lab2`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`school` (
  `code` INT NOT NULL,
  `school_name` VARCHAR(100) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`major` (
  `code` INT NOT NULL,
  `major_name` VARCHAR(100) NULL,
  `school_code` INT NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_major_school1_idx` (`school_code` ASC) VISIBLE,
  CONSTRAINT `fk_major_school1`
    FOREIGN KEY (`school_code`)
    REFERENCES `lab2`.`school` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`class` (
  `code` INT NOT NULL,
  `major_code` INT NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_class_major1_idx` (`major_code` ASC) VISIBLE,
  CONSTRAINT `fk_class_major1`
    FOREIGN KEY (`major_code`)
    REFERENCES `lab2`.`major` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`student` (
  `sid` CHAR(5) NOT NULL,
  `sname` VARCHAR(50) NULL,
  `email` VARCHAR(45) NULL,
  `gender` CHAR(1) NULL,
  `date_of_admission` DATE NULL,
  `native_place` VARCHAR(100) NULL,
  `class_code` INT NOT NULL,
  `image_id` INT NULL,
  PRIMARY KEY (`sid`),
  INDEX `fk_student_class1_idx` (`class_code` ASC) VISIBLE,
  CONSTRAINT `fk_student_class1`
    FOREIGN KEY (`class_code`)
    REFERENCES `lab2`.`class` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `lab2`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`teacher` (
  `tid` CHAR(4) NOT NULL,
  `tname` VARCHAR(50) NULL,
  `email` VARCHAR(45) NULL,
  `gender` CHAR(1) NULL,
  `school_code` INT NOT NULL,
  PRIMARY KEY (`tid`),
  INDEX `fk_teacher_school1_idx` (`school_code` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_school1`
    FOREIGN KEY (`school_code`)
    REFERENCES `lab2`.`school` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`course` (
  `cid` VARCHAR(20) NOT NULL,
  `cname` VARCHAR(100) NULL,
  `credit_hours` DECIMAL NULL,
  `credit` FLOAT NULL,
  PRIMARY KEY (`cid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`course_instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`course_instance` (
  `course_number` INT NOT NULL,
  `classroom_location` VARCHAR(100) NULL,
  `course_cid` VARCHAR(20) NOT NULL,
  `teacher_tid` CHAR(4) NOT NULL,
  `state` INT NULL DEFAULT -1,
  `max_student_number` INT NULL DEFAULT 100,
  `cur_student_number` INT NULL DEFAULT 0,
  PRIMARY KEY (`course_number`, `course_cid`),
  INDEX `fk_course_instance_course_idx` (`course_cid` ASC) VISIBLE,
  INDEX `fk_course_instance_teacher1_idx` (`teacher_tid` ASC) VISIBLE,
  CONSTRAINT `fk_course_instance_course`
    FOREIGN KEY (`course_cid`)
    REFERENCES `lab2`.`course` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_instance_teacher1`
    FOREIGN KEY (`teacher_tid`)
    REFERENCES `lab2`.`teacher` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab2`.`select_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`select_course` (
  `course_instance_course_number` INT NOT NULL,
  `course_instance_course_cid` VARCHAR(20) NOT NULL,
  `student_sid` CHAR(5) NOT NULL,
  `score` DECIMAL NULL,
  PRIMARY KEY (`course_instance_course_cid`, `student_sid`),
  INDEX `fk_course_instance_has_student_student1_idx` (`student_sid` ASC) VISIBLE,
  INDEX `fk_course_instance_has_student_course_instance1_idx` (`course_instance_course_number` ASC, `course_instance_course_cid` ASC) VISIBLE,
  CONSTRAINT `fk_course_instance_has_student_course_instance1`
    FOREIGN KEY (`course_instance_course_number` , `course_instance_course_cid`)
    REFERENCES `lab2`.`course_instance` (`course_number` , `course_cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_instance_has_student_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `lab2`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lab2`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab2`.`image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `path` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `path_UNIQUE` (`path` ASC) VISIBLE)
ENGINE = InnoDB;

DELIMITER $$ 
CREATE PROCEDURE update_student_email(IN sid CHAR(5), IN new_email VARCHAR(45), OUT result INT)
BEGIN
  START TRANSACTION;
  UPDATE student SET email = new_email WHERE student.sid = sid;
  SET result = ROW_COUNT();
  IF result > 0 THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END $$

CREATE FUNCTION get_student_email(sid CHAR(5)) RETURNS VARCHAR(45)
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(45);
    SELECT email INTO result FROM student WHERE student.sid = sid;
    RETURN result;
END $$

CREATE PROCEDURE get_all_course_info()
BEGIN
	select course.cname as a0, course.cid as a1, course_instance.course_number as a2, course.credit_hours as a3, course.credit as a4, school.school_name as a5, teacher.tname as a6, course_instance.state as a7, course_instance.classroom_location as a8, course_instance.cur_student_number as a9, course_instance.max_student_number as a10, school.code as a11
    from course_instance INNER JOIN course ON course_instance.course_cid = course.cid INNER JOIN teacher ON course_instance.teacher_tid = teacher.tid INNER JOIN school ON teacher.school_code = school.code
    ORDER BY `a1` ASC;
END $$

CREATE PROCEDURE student_select_course(
    IN sid CHAR(5), 
    IN cid VARCHAR(20), 
    IN course_number INT,
	OUT result INT
)
BEGIN
    DECLARE cur_student_number INT;
    DECLARE max_student_number INT;
    DECLARE is_enrolled INT;

    -- 检查学生是否已选过课程
    SELECT COUNT(*) INTO is_enrolled
    FROM select_course
    WHERE select_course.student_sid = sid AND select_course.course_instance_course_cid = cid;

    IF is_enrolled > 0 THEN
        SET result = -1; -- 学生已选过此课程
    ELSE
        -- 检查课堂是否已满
        SELECT cur_student_number, max_student_number INTO cur_student_number, max_student_number
        FROM course_instance
        WHERE course_instance.course_cid = cid AND course_instance.course_number = course_number;

        IF cur_student_number >= max_student_number THEN
            SET result = -2; -- 课堂已满
        ELSE
            -- 检查是否正在选课状态
            SELECT state INTO @state FROM course_instance WHERE course_instance.course_cid = cid AND course_instance.course_number = course_number;
            IF @state != -1 THEN
                SET result = -3; -- 非选课状态
            ELSE
                -- 开始事务
                START TRANSACTION;

                -- 插入选课记录
                INSERT INTO select_course (`course_instance_course_cid`, `course_instance_course_number`, `student_sid`) VALUES (cid, course_number, sid);

				        -- 修改选课人数
                UPDATE course_instance SET course_instance.cur_student_number = course_instance.cur_student_number + 1 WHERE course_instance.course_cid = cid AND course_instance.course_number = course_number;

                -- 提交事务
                COMMIT;

                SET result = 0; -- 选课成功
            END IF;
        END IF;
    END IF;
END $$

CREATE PROCEDURE get_selected_cource(IN sid CHAR(5))
BEGIN
	select course.cname as a0, course.cid as a1, course_instance.course_number as a2, course.credit as a3, teacher.tname as a4
    from select_course INNER JOIN course ON select_course.course_instance_course_cid = course.cid INNER JOIN course_instance ON select_course.course_instance_course_cid = course_instance.course_cid AND select_course.course_instance_course_number = course_instance.course_number INNER JOIN teacher ON course_instance.teacher_tid = teacher.tid
    where select_course.student_sid = sid;
END $$

CREATE PROCEDURE student_quit_course(
    IN sid CHAR(5), 
    IN cid VARCHAR(20), 
    IN course_number INT,
    OUT result INT
)
BEGIN
    DECLARE is_enrolled INT;
    DECLARE course_state INT;

    -- 检查学生是否已选过课程
    SELECT COUNT(*) INTO is_enrolled
    FROM select_course
    WHERE select_course.student_sid = sid AND select_course.course_instance_course_cid = cid AND select_course.course_instance_course_number = course_number;

    IF is_enrolled = 0 THEN
        SET result = -1; -- 学生未选过此课程
    ELSE
        -- 检查课程状态是否允许退课
        SELECT course_instance.state INTO course_state FROM course_instance WHERE course_instance.course_cid = cid AND course_instance.course_number = course_number;
        IF course_state != -1 THEN
            SET result = -2; -- 课程状态不允许退课
        ELSE
            -- 开始事务
            START TRANSACTION;

            -- 删除选课记录
            DELETE FROM select_course 
            WHERE select_course.`course_instance_course_cid` = cid AND select_course.`course_instance_course_number` = course_number AND select_course.`student_sid` = sid;


            -- 提交事务
            COMMIT;

            SET result = 0; -- 退课成功
        END IF;
    END IF;
END $$

CREATE PROCEDURE get_course_score(IN sid CHAR(5))
BEGIN
	select course.cname as a0, course.credit as a1, select_course.score as a2
    from select_course INNER JOIN course ON select_course.course_instance_course_cid = course.cid
    where select_course.student_sid = sid and select_course.score is not null;
END $$

CREATE PROCEDURE get_selected_student(IN course_cid VARCHAR(20), IN course_number INT)
BEGIN
	select student.sid as a0, student.sname as a1, select_course.score as a2
    from select_course INNER JOIN student ON select_course.student_sid = student.sid
    where select_course.course_instance_course_cid = course_cid and select_course.course_instance_course_number = course_number;
END $$


CREATE PROCEDURE change_score(IN course_cid VARCHAR(20), IN course_number INT, IN sid CHAR(5), IN new_score INT)
BEGIN
	update select_course
	set select_course.score = new_score
    where select_course.course_instance_course_cid = course_cid and select_course.course_instance_course_number = course_number and select_course.student_sid = sid;
END $$

CREATE PROCEDURE update_course_state(IN course_cid VARCHAR(20), IN course_number INT, IN new_state INT)
BEGIN
	update course_instance
	set course_instance.state = new_state
    where course_instance.course_cid = course_cid and course_instance.course_number = course_number;
END $$

CREATE PROCEDURE add_image(IN i_name VARCHAR(45), IN i_path VARCHAR(100))
BEGIN
	INSERT INTO image (`name`, `path`) VALUES (i_name, i_path);
END $$

CREATE PROCEDURE update_profile_picture(IN sid CHAR(5), IN i_path VARCHAR(100))
BEGIN
	DECLARE i_id INT;
    SELECT image.id INTO i_id
    FROM image
    WHERE image.path = i_path;
    
    UPDATE student
    SET student.image_id = i_id
    WHERE student.sid = sid;
END $$

CREATE FUNCTION get_student_image_path(sid CHAR(5)) RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE i_id INT;
    DECLARE i_path VARCHAR(100);
    
    SELECT student.image_id INTO i_id
	FROM student
    WHERE student.sid = sid;
    
    SELECT image.path INTO i_path
    FROM image
    WHERE image.id = i_id;
    
    RETURN i_path;
END $$

# -- 选课时更新选课人数
# CREATE TRIGGER update_enrollment_after_insert
# AFTER INSERT ON select_course
# FOR EACH ROW
# BEGIN
#     UPDATE course_instance
#     SET course_instance.cur_student_number = course_instance.cur_student_number + 1
#     WHERE course_instance.course_number = NEW.course_instance_course_number
#       AND course_instance.course_cid = NEW.course_instance_course_cid;
# END $$

-- 退课时更新选课人数
CREATE TRIGGER update_enrollment_after_delete
AFTER DELETE ON select_course
FOR EACH ROW
BEGIN
    UPDATE course_instance
    SET course_instance.cur_student_number = course_instance.cur_student_number - 1
    WHERE course_instance.course_number = OLD.course_instance_course_number
      AND course_instance.course_cid = OLD.course_instance_course_cid;
END $$

CREATE PROCEDURE get_teacher_info(IN id CHAR(4))
BEGIN
    SELECT teacher.tid as a0, teacher.tname as a1, teacher.email as a2, teacher.gender as a3, teacher.school_code as a4, school.school_name as a5
    FROM teacher INNER JOIN school ON teacher.school_code = school.code
    WHERE teacher.tid = id;
END $$

CREATE PROCEDURE get_teached_course(IN tid CHAR(4))
BEGIN
	select course.cname as a0, course.cid as a1, course_instance.course_number as a2
    from course_instance INNER JOIN course ON course_instance.course_cid = course.cid INNER JOIN teacher ON course_instance.teacher_tid = teacher.tid
    WHERE teacher.tid = tid
    ORDER BY `a1` ASC;
END $$
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
