from django.db import connection
from django.db import models

class Student():
    @classmethod
    def get_basic_info(cls, sid):
        with connection.cursor() as cursor:
            table = "student INNER JOIN class ON student.class_code = class.code INNER JOIN major ON class.major_code = major.code INNER JOIN school ON major.school_code = school.code"
            select = "select student.sid as id, student.sname as name, student.email as email, student.gender as gender, student.date_of_admission as date, student.native_place as place, student.class_code as class_code, major.major_name as major_name, major.code as major_code, school.school_name as shcool_name, school.code as school_code"
            SQL = select + " from " + table + " where student.sid = %s"
            cursor.execute(SQL, [sid])
            result = cursor.fetchone()
        return result
    
    @classmethod
    def get_email(cls, sid):
        with connection.cursor() as cursor:
            cursor.execute(f"select get_student_email('{sid}')")
            result = cursor.fetchone()
        return result[0]
    
    @classmethod
    def update_email(cls, sid, new_email):
        with connection.cursor() as cursor:
            cursor.callproc('update_student_email', [sid, new_email, 0])
            cursor.execute('SELECT @_update_student_email_2')  # 获取输出参数
            result = cursor.fetchone()
            return result[0]
    
    @classmethod
    def update_profile_picture(cls, sid, path):
        with connection.cursor() as cursor:
            cursor.callproc('update_profile_picture', [sid, path])
    
    @classmethod
    def get_student_image_path(cls, sid):
        with connection.cursor() as cursor:
            cursor.execute(f"select get_student_image_path('{sid}')")
            result = cursor.fetchone()
        return result[0]


class CourseInstance():
    @classmethod
    def get_all_course_info(cls):
        with connection.cursor() as cursor:
            cursor.callproc('get_all_course_info', [])
            result = cursor.fetchall()
        return result

    @classmethod
    def update_course_state(cls, cid, course_number, new_state):
        with connection.cursor() as cursor:
            cursor.callproc('update_course_state', [cid, course_number, new_state])

class SelectCourse():
    @classmethod
    def student_select_course(cls, sid, course_cid, course_number):
        with connection.cursor() as cursor:
            cursor.callproc('student_select_course', [sid, course_cid, course_number, 0])
            cursor.execute('SELECT @_student_select_course_3')  # 获取输出参数
            result = cursor.fetchone()
        return result[0]
    
    @classmethod
    def get_selected_cource(cls, sid):
        with connection.cursor() as cursor:
            cursor.callproc('get_selected_cource', [sid])
            result = cursor.fetchall()
        return result

    @classmethod
    def student_quit_course(cls, sid, course_cid, course_number):
        with connection.cursor() as cursor:
            cursor.callproc('student_quit_course', [sid, course_cid, course_number, 0])
            cursor.execute('SELECT @_student_quit_course_3')  # 获取输出参数
            result = cursor.fetchone()
        return result[0]
    
    @classmethod
    def get_course_score(cls, sid):
        with connection.cursor() as cursor:
            cursor.callproc('get_course_score', [sid])
            result = cursor.fetchall()
        return result
    
    @classmethod
    def get_selected_student(cls, cid, course_number):
        with connection.cursor() as cursor:
            cursor.callproc('get_selected_student', [cid, course_number])
            result = cursor.fetchall()
        return result
    
    @classmethod
    def change_score(cls, cid, course_number, sid, new_score):
        with connection.cursor() as cursor:
            cursor.callproc('change_score', [cid, course_number, sid, new_score])
            
class School():
    @classmethod
    def get_all_school(cls):
        with connection.cursor() as cursor:
            cursor.execute('SELECT * from school')
            result = cursor.fetchall()
        return result

class Image(models.Model):
    name = models.CharField(max_length=64)
    image = models.ImageField(upload_to='images')

def add_image(name, path):
    with connection.cursor() as cursor:
        cursor.callproc('add_image', [name, path])

class Teacher():
    @classmethod
    def get_teacher_info(cls, tid):
        with connection.cursor() as cursor:
            cursor.callproc('get_teacher_info', [tid])
            result = cursor.fetchone()
            return result
        
    @classmethod
    def get_teached_course(cls, tid):
        with connection.cursor() as cursor:
            cursor.callproc('get_teached_course', [tid])
            result = cursor.fetchall()
            return result