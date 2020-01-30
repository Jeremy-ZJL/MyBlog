from django.urls import path
from . import views

# 正在部署的应用的名称
app_name = 'article'

urlpatterns = [
    path('', views.indexViews, name='indexViews'),
    path('detail/<int:aid>/', views.detail, name='detail'),  # 文章详情
    # path('article-create/', views.ArtCreate.as_view(), name='article_create'),  # 写文章
    # path('test/', views.test),
    path('archives/<int:year>/<int:month>/', views.archive, name='archive'),
]
