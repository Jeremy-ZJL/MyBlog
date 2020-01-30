from django.shortcuts import render
from .models import ArticlePost  # 模型类
from .models import Tags
from django.core.paginator import Paginator

from markdown import Markdown  # 导入markdown

# Create your views here.


def indexViews(request):
    """
    文章列表页
    """
    art_obj = ArticlePost.objects.filter(status='p').order_by('-topped', 'title', '-created_time')
    tag_obj = Tags.objects.all()

    # 每页显示 1 篇文章
    paginator = Paginator(art_obj, 10)
    # 获取 url 中的页码
    page = int(request.GET.get('page', 1))
    # 将导航对象相应的页码内容返回给 articles
    art_obj = paginator.get_page(page)

    # 默认按照11个页码展示
    if paginator.num_pages > 11:
        if page - 5 < 1:
            page_range = range(1, 12)
        elif page + 5 > paginator.num_pages:
            page_range = range(paginator.num_pages - 10, paginator.num_pages + 1)
        else:
            page_range = range(page - 5, page + 6)
    else:
        page_range = paginator.page_range

    content = {'articles': art_obj,
               'tags': tag_obj,
               'page_range': page_range,
               'd_page': page,
               }

    return render(request, 'index.html', content)


def detail(request, aid):
    """
    文章详情
    :param request:
    :param aid: 文章主键
    :return:
    """

    # 取出相应的文章
    article = ArticlePost.objects.filter(id=aid).first()

    # 上一篇
    article_previous = ArticlePost.objects.filter(id__gt=aid).all().order_by('id').first()
    # 下一篇
    article_next = ArticlePost.objects.filter(id__lt=aid).all().order_by('-id').first()

    # 将markdown语法渲染成html样式
    md = Markdown(
        extensions=[
            # 包含 缩写、表格等常用扩展
            'markdown.extensions.extra',
            # 语法高亮扩展
            'markdown.extensions.codehilite',
            'markdown.extensions.toc',
        ])
    article.body = md.convert(article.body)
    article.toc = md.toc

    # 需要传递给模板的对象
    content = {'article': article,
               'article_previous': article_previous,
               'article_next': article_next
               }
    return render(request, 'detail.html', content)


# 文章归档
def archive(request, year, month):
    article_list = ArticlePost.objects.filter(created_time__year=year, created_time__month=month)
    return render(request, '', context={'article_list': article_list})





