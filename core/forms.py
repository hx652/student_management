from django import forms
from .models import *

class new_email_form(forms.Form):
    new_email = forms.EmailField(label='new email', help_text='请在此输入新邮箱')

class CourseSearchForm(forms.Form):
    course_name = forms.CharField(required=False, label='课程名')
    school_list = list(School.get_all_school())
    school_list.insert(0, ('', ''))
    department = forms.ChoiceField(choices=school_list, required=False, label='开课学院')

class ScoreForm(forms.Form):
    sid = forms.CharField(label='学号', max_length=5)
    score = forms.IntegerField(label='成绩')
    
class AddStudentForm(forms.Form):
    sid = forms.CharField(label='学号', max_length=5)

class SetCourseStateForm(forms.Form):
    options = [(-1, '正在选课'), (0, '正在进行'), (1, '已结束')]
    new_state = forms.ChoiceField(choices=options, label='课程状态')