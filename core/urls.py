from django.urls import path, re_path
from core import views

urlpatterns = [
    path("", views.start_page, name='start_page'),
    path("basic_info/", views.basic_info, name='basic_info'),
    path("change_email/", views.change_email, name='change_email'),
    path("all_course/", views.all_course, name='all_course'),
    path("select_course/", views.select_course, name='select_course'),
    path("selected_course/", views.selected_course, name='selected_course'),
    path("quit_course/", views.quit_course, name='quit_course'),
    path("my_score/", views.my_score, name='my_score'),
    re_path(r'course_detail/(?P<cid>[\w-]+)\.(?P<course_number>\d+)/$', views.course_detail, name='course_detail'),
    re_path(r'course_management_basic/(?P<cid>[\w-]+)\.(?P<course_number>\d+)/$', views.course_management_basic, name='course_management_basic'),
    re_path(r'change_score/(?P<cid>[\w-]+)\.(?P<course_number>\d+)/$', views.change_score, name='change_score'),
    re_path(r'add_student/(?P<cid>[\w-]+)\.(?P<course_number>\d+)/$', views.add_student, name='add_student'),
    path("upload_image/", views.upload_image, name='upload_image'),
    path("teached_course/", views.teached_course, name='teached_course'),
]