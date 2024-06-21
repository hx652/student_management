USE `lab2`;
INSERT INTO `lab2`.`school` (`code`, `school_name`) VALUES (1, '计算机科学与技术学院');
INSERT INTO `lab2`.`school` (`code`, `school_name`) VALUES (4, '数学学院');
INSERT INTO `lab2`.`school` (`code`, `school_name`) VALUES (2, '电子信息工程学院');
INSERT INTO `lab2`.`school` (`code`, `school_name`) VALUES (3, '机械工程学院');


INSERT INTO `lab2`.`major` (`code`, `major_name`, `school_code`) VALUES (1, '计算机科学与技术', 1);
INSERT INTO `lab2`.`major` (`code`, `major_name`, `school_code`) VALUES (2, '软件工程', 1);
INSERT INTO `lab2`.`major` (`code`, `major_name`, `school_code`) VALUES (3, '电子信息工程', 2);
INSERT INTO `lab2`.`major` (`code`, `major_name`, `school_code`) VALUES (4, '机械工程', 3);
INSERT INTO `lab2`.`major` (`code`, `major_name`, `school_code`) VALUES (5, '应用数学', 4);

INSERT INTO `lab2`.`class` (`code`, `major_code`) VALUES (1, 1);
INSERT INTO `lab2`.`class` (`code`, `major_code`) VALUES (2, 1);
INSERT INTO `lab2`.`class` (`code`, `major_code`) VALUES (3, 2);
INSERT INTO `lab2`.`class` (`code`, `major_code`) VALUES (4, 3);

INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB001', '张三', 'zhangsan@example.com', 'M', '2020-09-01', '北京市', 1);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB002', '李四', 'lisi@example.com', 'F', '2020-09-01', '上海市', 1);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB003', '王五', 'wangwu@example.com', 'M', '2020-09-01', '广州市', 2);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB004', '赵六', 'zhaoliu@example.com', 'F', '2020-09-01', '深圳市', 3);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB005', '钱七', 'qianqi@example.com', 'M', '2020-09-01', '广州市', 4);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB006', '孙八', 'sunba@example.com', 'F', '2020-09-01', '北京市', 3);
INSERT INTO `lab2`.`student` (`sid`, `sname`, `email`, `gender`, `date_of_admission`, `native_place`, `class_code`) VALUES ('PB007', '李九', 'lijiu@example.com', 'M', '2020-09-01', '上海市', 2);


INSERT INTO `lab2`.`teacher` (`tid`, `tname`, `email`, `gender`, `school_code`) VALUES ('T001', 'John Doe', 'johndoe@email.com', 'M', 1);
INSERT INTO `lab2`.`teacher` (`tid`, `tname`, `email`, `gender`, `school_code`) VALUES ('T002', 'Jane Smith', 'janesmith@email.com', 'F', 2);
INSERT INTO `lab2`.`teacher` (`tid`, `tname`, `email`, `gender`, `school_code`) VALUES ('T003', 'Jim Brown', 'jimbrown@email.com', 'M', 4);
INSERT INTO `lab2`.`teacher` (`tid`, `tname`, `email`, `gender`, `school_code`) VALUES ('T004', 'GG Bond', 'GG Bondn@email.com', 'F', 4);

INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('CS101', '计算机科学入门', 60, 4.0);
INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('CS144', '计算机网络', 80, 3.5);
INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('MATH201', '数学分析', 80, 4.5);
INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('MATH202', '线性代数', 80, 4.0);
INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('MATH204', '图论', 80, 3.5);
INSERT INTO `lab2`.`course` (`cid`, `cname`, `credit_hours`, `credit`) VALUES ('EE101', '电路基础', 80, 4.0);

INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '计算机楼101', 'CS101', 'T001', -1, 90, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '信息楼202', 'CS144', 'T001', -1, 80, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '数学楼303', 'MATH201', 'T003', -1, 100, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (2, '数学楼302', 'MATH201', 'T003', -1, 100, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '数学楼401', 'MATH202', 'T004', -1, 100, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (2, '数学楼402', 'MATH202', 'T004', -1, 100, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '数学楼505', 'MATH204', 'T004', -1, 100, 0);
INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '工程馆303', 'EE101', 'T002', -1, 100, 0);


-- INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '主楼101', 'CS101', 'T001', -1, 50, 0);
-- INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (2, '主楼102', 'CS101', 'T002', -1, 50, 0);
-- INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (3, '主楼103', 'CS101', 'T003', -1, 50, 0);
-- INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '科学楼202', 'MATH201', 'T002', -1, 40, 0);
-- INSERT INTO `lab2`.`course_instance` (`course_number`, `classroom_location`, `course_cid`, `teacher_tid`, `state`, `max_student_number`, `cur_student_number`) VALUES (1, '工程馆303', 'PHY301', 'T003', -1, 30, 0);



