from django.db import models
from django.contrib.auth.models import User  # 导入内建的User模型。


# Create your models here.


class Category(models.Model):
    """
    存储文章的分类信息
    """
    name = models.CharField(max_length=100, verbose_name='分类')

    class Meta:
        verbose_name = '分类'
        verbose_name_plural = '分类'

    def __str__(self):
        return self.name


class Tags(models.Model):
    """
    存储文章的tags信息
    """
    name = models.CharField(max_length=100,  verbose_name='标签')

    class Meta:
        verbose_name = '标签'
        verbose_name_plural = '标签'

    def __str__(self):
        return self.name


class ArticlePost(models.Model):
    """
    用于存储文章正文和其相关的属性
    """
    STATUS_CHOICES = (
        ('d', '草稿'),
        ('p', '发布'),
    )

    # 文章作者。
    author = models.CharField(max_length=100, verbose_name='作者')

    # 文章标题
    title = models.CharField(max_length=255, verbose_name='标题')

    # 文章正文。保存大量文本使用 TextField
    body = models.TextField(verbose_name='正文')

    # 文章创建时间。参数 auto_now_add=True 每当对象被创建时，设为当前日期，常用于保存创建日期(注意，它是不可修改的)。
    created_time = models.DateField(auto_now_add=True, verbose_name='创建时间')

    # 文章更新时间。参数 auto_now=True 每当对象被保存时将字段设为当前日期，常用于保存最后修改时间。
    updated_time = models.DateField(auto_now=True, verbose_name='更新时间')

    # 文章状态
    status = models.CharField(max_length=1, choices=STATUS_CHOICES, verbose_name='文章状态')

    # 点赞数
    likes = models.PositiveIntegerField(default=0, verbose_name='点赞数')

    # 是否置顶，BooleanField 存储布尔值（True或者False），默认（default）为False
    topped = models.BooleanField(default=False, verbose_name='置顶')

    # 分类
    # 文章的分类，ForeignKey即数据库中的外键。外键的定义是：如果数据库中某个表的列的值是另外一个表的主键。
    # 外键定义了一个一对多的关系，这里即一篇文章对应一个分类，而一个分类下可能有多篇文章。
    # 详情参考django官方文档关于ForeinKey的说明，
    # on_delete=models.SET_NULL表示删除某个分类（category）后该分类下所有的Article的外键设为null（空）
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.SET_NULL, verbose_name='分类')

    # Tags. 用于存储标签
    tags = models.ManyToManyField(Tags, blank=True, verbose_name='标签')

    # 内部类 class Meta 用于给 model 定义元数据
    class Meta:
        # ordering 指定模型返回的数据的排列顺序
        # '-created_time' 表明数据应该以倒序排列
        # ordering = ['-created_time']
        verbose_name = '文章列表'
        verbose_name_plural = '文章列表'

    # 函数 __str__ 定义当调用对象的 str() 方法时的返回值内容
    def __str__(self):
        return self.title  # 将文章标题返回













