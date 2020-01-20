import xadmin
from xadmin import views
from .models import ArticlePost
from .models import Category
from .models import Tags


class BaseSetting(object):
    """xadmin的基本配置"""
    enable_themes = True  # 开启主题切换功能
    use_bootswatch = True  # 引导控制菜单


xadmin.site.register(views.BaseAdminView, BaseSetting)


class GlobalSettings(object):
    """xadmin的全局配置"""
    site_title = "Jeremy"  # 设置站点标题
    site_footer = "Jeremy个人博客"  # 设置站点的页脚
    menu_style = "accordion"  # 设置菜单折叠


xadmin.site.register(views.CommAdminView, GlobalSettings)


class ArticlePostAdmin:
    """文章管理类"""
    list_display = ['title', 'author', 'likes', 'category', 'tags',
                    'created_time', 'updated_time', 'topped', 'status']


xadmin.site.register(ArticlePost, ArticlePostAdmin)


class CategoryAdmin:
    """
    分类
    """
    list_display = ['name']


xadmin.site.register(Category, CategoryAdmin)


class TagsAdmin:
    """
    标签
    """
    list_display = ['name']


xadmin.site.register(Tags, TagsAdmin)


