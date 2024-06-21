from django.shortcuts import render, redirect
from django.http import HttpResponseForbidden, HttpResponse
from django.core.paginator import Paginator
from .models import *
from .forms import *

def start_page(request):
    context = {
    }
    return render(request, 'start_page.html', context=context)

def basic_info(request):
    user = request.user
    is_student = user.groups.filter(name='Student').exists()
    is_teacher = user.groups.filter(name='Teacher').exists()
    if is_student:
        sid = user.username
        info = Student.get_basic_info(sid=sid)
        image_path = Student.get_student_image_path(sid)
        # print(image_path)
        context = {
            'username': user.username,
            'image_path': image_path,
            'info': info,
            'is_student': is_student,
            'is_teacher': is_teacher,
        }
    if is_teacher:
        tid = user.username
        info = Teacher.get_teacher_info(tid)
        context = {
            'username': user.username,
            'info': info,
            'is_student': is_student,
            'is_teacher': is_teacher,
        }
    return render(request, 'basic_info.html', context=context)

def change_email(request):
    user = request.user
    error = False
    is_student = user.groups.filter(name='Student').exists()
    if is_student:
        sid = user.username
        old_email = Student.get_email(sid=sid)
    if request.method == 'POST':
        form = new_email_form(request.POST)
        if form.is_valid():
            new_email = form.cleaned_data.get('new_email')
            result = Student.update_email(sid, new_email)
            if result == 1:
                return redirect('basic_info')
            else:
                error = True
    else:
        form = new_email_form(initial={})

    context = {
        'old_email': old_email,
        'form': form,
        'error': error,
        'is_student': is_student,
    }
    return render(request, 'change_email.html', context=context)

def all_course(request):
    course_list = CourseInstance.get_all_course_info()
    form = CourseSearchForm(request.GET)
    is_student = request.user.groups.filter(name='Student').exists()
    if form.is_valid():
        course_name = form.cleaned_data.get('course_name')
        department = form.cleaned_data.get('department')
        if course_name:
            course_list = [course for course in course_list if course_name in course[0]]
        if department:
            course_list = [course for course in course_list if course[11] == int(department)]

    paginator = Paginator(course_list, 5)  # 每页显示5个课程
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'username': request.user.username,
        'form': form,
        'page_obj': page_obj,
        'is_student': is_student,
    }
    return render(request, 'all_course.html', context=context)

def course_detail(request, cid, course_number):
    course_list = CourseInstance.get_all_course_info()
    course = 0
    for tmp in course_list:
        if tmp[1] == cid and tmp[2] == int(course_number):
            course = tmp

    context = {
        'username': request.user.username,
        'is_student': True,
        'is_teacher': False,
        'course': course,
        'cid': cid,
        'course_number': course_number,
    }
    return render(request, 'course_detail.html', context=context)

def select_course(request):
    user = request.user
    is_student = user.groups.filter(name='Student').exists()
    if user.groups.filter(name='Student').exists() and request.method == 'POST':
        sid = user.username
        cid = request.POST.get('course_cid')
        course_number = request.POST.get('course_number')
        result = SelectCourse.student_select_course(sid, cid, course_number)
        is_student = request.user.groups.filter(name='Student').exists()

        print("xxxc", result)
        context = {
            'username': request.user.username,
            'is_student': is_student,
            'result': result,
        }
        return render(request, 'select_course.html', context=context)
    else:
        return HttpResponseForbidden('您没有权限访问这个页面。')
    
def selected_course(request):
    sid = request.user.username
    is_student = request.user.groups.filter(name='Student').exists()
    course_list = SelectCourse.get_selected_cource(sid)

    paginator = Paginator(course_list, 2)  # 每页显示10个课程
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'username': request.user.username,
        'page_obj': page_obj,
        'is_student': is_student,
    }
    return render(request, 'selected_course.html', context=context)

def quit_course(request):
    user = request.user
    is_student = user.groups.filter(name='Student').exists()
    if user.groups.filter(name='Student').exists() and request.method == 'POST':
        sid = user.username
        cid = request.POST.get('course_cid')
        course_number = request.POST.get('course_number')
        result = SelectCourse.student_quit_course(sid, cid, course_number)        
        context = {
            'username': request.user.username,
            'result': result,
            'is_student': is_student,
        }
        return render(request, 'quit_course.html', context=context)
    else:
        return HttpResponseForbidden('您没有权限访问这个页面。')
    
def my_score(request):
    is_student = request.user.groups.filter(name='Student').exists()
    if request.user.groups.filter(name='Student').exists():
        sid = request.user.username
        score_list = SelectCourse.get_course_score(sid)
        context = {
            'username': request.user.username,
            'score_list': score_list,
            'is_student': is_student,
        }
        return render(request, 'my_score.html', context=context)
    else:
        return HttpResponseForbidden('您没有权限访问这个页面。')
    
def teached_course(request):
    if request.user.groups.filter(name='Teacher').exists():
        tid = request.user.username
        course_list = Teacher.get_teached_course(tid)

    paginator = Paginator(course_list, 2)  # 每页显示10个课程
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'username': request.user.username,
        'page_obj': page_obj,
        'is_student': False,
        'is_teacher': True,
    }
    return render(request, 'teached_course.html', context=context)

def course_management_basic(request, cid, course_number):
    if request.method == 'POST':
        rev_form = SetCourseStateForm(request.POST)
        if rev_form.is_valid():
            new_state = rev_form.cleaned_data.get('new_state')
            CourseInstance.update_course_state(cid, course_number, new_state)
            
    course_list = CourseInstance.get_all_course_info()
    course = 0
    for tmp in course_list:
        if tmp[1] == cid and tmp[2] == int(course_number):
            course = tmp
    cur_state = course[7]
    init = {
        'new_state': cur_state,
    }
    send_form = SetCourseStateForm(initial=init)

    context = {
        'form': send_form,
        'course': course,
        'cid': cid,
        'course_number': course_number,
    }
    return render(request, 'course_management_basic.html', context=context)

def change_score(request, cid, course_number):
    if request.method == 'POST':
        rev_form = ScoreForm(request.POST)
        if rev_form.is_valid():
            sid = rev_form.cleaned_data.get('sid')
            score = rev_form.cleaned_data.get('score')
            SelectCourse.change_score(cid, int(course_number), sid, score)
    send_form = ScoreForm(initial={})
    student_list = SelectCourse.get_selected_student(cid, course_number)
    context = {
        'cid': cid,
        'course_number': course_number,
        'form': send_form,
        'student_list': student_list,
    }
    return render(request, 'change_score.html', context=context)

def add_student(request, cid, course_number):
    result = 1
    if request.method == 'POST':
        rev_form = AddStudentForm(request.POST)
        if rev_form.is_valid():
            sid = rev_form.cleaned_data.get('sid')
            result = SelectCourse.student_select_course(sid, cid, course_number)

    student_list = SelectCourse.get_selected_student(cid, course_number)
    send_form = AddStudentForm(initial={})
    context = {
        'result': result,
        'form': send_form,
        'student_list': student_list,
        'cid': cid,
        'course_number': course_number,
    }
    return render(request, 'add_student.html', context=context)

from django.core.files.base import ContentFile
import os
from django.conf import settings
from django.core.files.storage import default_storage

def upload_image(request):
    if request.method == 'POST':
        name = request.FILES.get('image').name
        new_image = Image(
            name = name,
            image = request.FILES.get('image'),
        )
        new_image.save()
        url = new_image.image.url
        add_image(name, url)
        if request.user.groups.filter(name='Student').exists():
            sid = request.user.username
            Student.update_profile_picture(sid, url)
        
        return redirect('basic_info') 