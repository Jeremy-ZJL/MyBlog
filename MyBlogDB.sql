-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: MyBlogDB
-- ------------------------------------------------------
-- Server version	5.7.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `MyBlogDB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `MyBlogDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `MyBlogDB`;

--
-- Table structure for table `article_articlepost`
--

DROP TABLE IF EXISTS `article_articlepost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_articlepost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_articlepost_author_id_b855d44d_fk_auth_user_id` (`author_id`),
  CONSTRAINT `article_articlepost_author_id_b855d44d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_articlepost`
--

LOCK TABLES `article_articlepost` WRITE;
/*!40000 ALTER TABLE `article_articlepost` DISABLE KEYS */;
INSERT INTO `article_articlepost` VALUES (2,'fadsf','# 一级标题\r\n\r\n## 二级标题\r\n\r\n### 三级标题\r\n\r\n#### 四级标题\r\n\r\n- 列表项1\r\n- 列表项2\r\n- 列表项3\r\n\r\n> 这是一段引用\r\n\r\n\r\n```python\r\ndef detail(request, pk):\r\n    post = get_object_or_404(Post, pk=pk)\r\n    return render(request, \'blog/detail.html\', context={\'post\': post})\r\n```','2019-10-10 07:50:00.000000','2019-10-12 01:11:59.721404',1),(3,'测试篇','[TOC]\r\n\r\n## 7. 首页\r\n\r\n### 7.1 轮播图功能实现\r\n\r\n#### 7.1.1 安装依赖模块和配置\r\n\r\n##### 7.1.1.1 图片处理模块 - pillow\r\n```bash\r\npip install pillow\r\n```\r\n\r\n##### 7.1.1.2 上传文件相关配置\r\n\r\n- `settings/dev.py`文件：\r\n```python\r\n# 访问静态文件的url地址前缀\r\nSTATIC_URL = \'/static/\'\r\n\r\n# 设置django的静态文件目录\r\nSTATICFILES_DIRS = [\r\n    os.path.join(BASE_DIR, \"statics\")\r\n]\r\n\r\n# 项目中存储上传文件的根目录[暂时配置]，注意，static目录需要手动创建否则上传文件时报错\r\nMEDIA_ROOT = os.path.join(BASE_DIR, \"statics\")\r\n\r\n# 访问上传文件的url地址前缀\r\nMEDIA_URL =\"/media/\"\r\n```\r\n\r\n- 在`xadmin`中输出上传文件的`url`地址时, 必须要让路由识别上传文件的`media`开头的地址\r\n\r\n- **所以在总路由`urls.py`新增代码：**\r\n```python\r\n# 在url中配置media请求的url \r\n# 首先需要导入下面的库 和在settings 中配置的 MEDIA_ROOT(上传路径)\r\nfrom django.urls import path, re_path\r\nfrom django.conf import settings\r\nfrom django.views.static import serve\r\n\r\nurlpatterns = [\r\n    ... ...\r\n    # 配置url 固定的 里面的内容不能改的\r\n    re_path(r\'media/(?P<path>.*)\', serve, {\'document_root\': settings.MEDIA_ROOT}),\r\n]\r\n```\r\n\r\n* * *\r\n#### 7.1.2 创建轮播图的模型\r\n\r\n因为当前功能是`drf`的第一个功能，所以我们先创建一个子应用`home`，创建在`luffy/apps`目录下\r\n\r\n![fa0063907b0d6a5d14003a57cf1eca70.png](en-resource://database/844:1)\r\n\r\n- 注册`home`子应用，因为子应用的位置发生了改变，所以为了原来子应用的注册写法，所以新增一个导包路径：\r\n* `settings/dev.py`\r\n```python\r\nBASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))\r\n\r\n# 新增一个系统导包路径\r\nimport sys\r\nsys.path.insert(0,os.path.join(BASE_DIR,\"apps\"))\r\n\r\nINSTALLED_APPS = [\r\n	# 注意，加上drf框架的注册	\r\n    \'rest_framework\',\r\n    \r\n    # 子应用\r\n    \'home\',\r\n]\r\n```\r\n> 注意，pycharm会路径错误的提示。\r\n\r\n* 模型：`home/models.py`\r\n```python\r\nfrom django.db import models\r\n\r\n# Create your models here.\r\nclass BannerInfo(models.Model):\r\n    \"\"\"\r\n    轮播图\r\n    \"\"\"\r\n    # upload_to 存储子目录，真实存放地址会使用settings/dev.py配置中的MADIE_ROOT + upload_to\r\n    image = models.ImageField(upload_to=\'banner\', verbose_name=\'轮播图\', null=True,blank=True)\r\n    name = models.CharField(max_length=150, verbose_name=\'轮播图名称\')\r\n    note = models.CharField(max_length=150, verbose_name=\'备注信息\')\r\n    link = models.CharField(max_length=150, verbose_name=\'轮播图广告地址\')\r\n    orders = models.IntegerField(verbose_name=\'显示顺序\')\r\n    is_show=models.BooleanField(verbose_name=\"是否上架\",default=False)\r\n    is_delete=models.BooleanField(verbose_name=\"逻辑删除\",default=False)\r\n\r\n    class Meta:\r\n        db_table = \'ly_banner\'\r\n        verbose_name = \'轮播图\'\r\n        verbose_name_plural = verbose_name\r\n\r\n    def __str__(self):\r\n        return self.name\r\n```\r\n\r\n- 新增模型后需要进行数据迁移\r\n```bash\r\npython manage.py makemigrations\r\npython manage.py migrate\r\n```\r\n\r\n#### 7.1.3 轮播图序列化器\r\n\r\n- 序列化器：`home/serializers.py`\r\n```python\r\nfrom rest_framework.serializers import ModelSerializer\r\nfrom .models import BannerInfo\r\nclass BannerInfoSerializer(ModelSerializer):\r\n    \"\"\"轮播图序列化器\"\"\"\r\n    class Meta:\r\n        model=BannerInfo\r\n        fields = (\"image\",\"link\")\r\n```\r\n\r\n#### 7.1.4 轮播图视图代码\r\n\r\n- 视图代码：`views.py`\r\n```python\r\nfrom django.db.models import Q\r\nfrom rest_framework.generics import ListAPIView\r\nfrom .models import BannerInfo\r\nfrom .serializers import BannerInfoSerializer\r\nclass BannerInfoListAPIView(ListAPIView):\r\n    \"\"\"\r\n    轮播图列表\r\n    \"\"\"\r\n    queryset = BannerInfo.objects.filter( Q(is_show=True) & Q(is_delete=False) ).order_by(\"-orders\")\r\n    serializer_class = BannerInfoSerializer\r\n```\r\n\r\n#### 7.1.5 路由代码\r\n\r\n- 把`home`的路由`urls.py`注册到总路由\r\n```python\r\nfrom django.urls import path,include\r\n\r\nurlpatterns = [\r\n    path(\'admin/\', admin.site.urls),\r\n    path(\'\', include(\"home.urls\")),\r\n]\r\n```\r\n\r\n* 子应用`home`的路由：`home/urls.py`\r\n```python\r\nfrom django.urls import path,re_path\r\nfrom . import views\r\n\r\nurlpatterns = [\r\n    path(r\"banner/\",views.BannerInfoListAPIView.as_view()),\r\n]\r\n```\r\n\r\n* 访问http://api.luffycity.cn:8000/banner/，可视化API效果：\r\n\r\n![7305e4be8a52269ff8d3fb27a703413a.png](en-resource://database/846:1)\r\n\r\n\r\n#### 7.1.6 安装xadmin\r\n\r\n1. **安装**\r\n```bash\r\npip install https://codeload.github.com/sshwsfc/xadmin/zip/django2\r\n```\r\n\r\n* * *\r\n\r\n2. **在配置文件中注册如下应用**\r\n\r\n```python\r\nINSTALLED_APPS = [\r\n    ...\r\n    \'xadmin\',\r\n    \'crispy_forms\',\r\n    \'reversion\',\r\n    ...\r\n]\r\n\r\n# 修改使用中文界面\r\nLANGUAGE_CODE = \'zh-Hans\'\r\n\r\n# 修改时区\r\nTIME_ZONE = \'Asia/Shanghai\'\r\n```\r\n\r\n* * *\r\n\r\n3. **进行数据库迁移，因为`xadmin`有建立自己的数据库模型类**\r\n```bash\r\npython manage.py makemigrations\r\npython manage.py migrate\r\n```\r\n\r\n* * *\r\n\r\n4. **在总路由中添加`xadmin`的路由信息**\r\n```python\r\nimport xadmin\r\n# version模块自动注册需要版本控制的 Model\r\nfrom xadmin.plugins import xversion\r\n\r\nxadmin.autodiscover()\r\nxversion.register_models()\r\n\r\nurlpatterns = [\r\n    . . .\r\n    path(r\'xadmin/\', xadmin.site.urls),\r\n]\r\n```\r\n\r\n* * *\r\n\r\n5. **创建超级用户**\r\n```bash\r\npython manage.py createsuperuser\r\n```\r\n![5cefbd913c1cd6c36bfb96d0ff8943b1.png](en-resource://database/845:1)\r\n\r\n#### 7.1.7 `xadmin`设置基本站点配置信息\r\n\r\n* 新建文件`home/adminx.py` \r\n```python\r\nimport xadmin\r\nfrom xadmin import views\r\n\r\nclass BaseSetting(object):\r\n    \"\"\"xadmin的基本配置\"\"\"\r\n    enable_themes = True  # 开启主题切换功能\r\n    use_bootswatch = True\r\n\r\nxadmin.site.register(views.BaseAdminView, BaseSetting)\r\n\r\nclass GlobalSettings(object):\r\n    \"\"\"xadmin的全局配置\"\"\"\r\n    site_title = \"路飞学城\"  # 设置站点标题\r\n    site_footer = \"路飞学城有限公司\"  # 设置站点的页脚\r\n    menu_style = \"accordion\"  # 设置菜单折叠\r\n\r\nxadmin.site.register(views.CommAdminView, GlobalSettings)\r\n```\r\n\r\n#### 7.1.8 注册模型到`xadmin`中\r\n\r\n- 在当前子应用中创建`adminx.py`，添加如下代码\r\n```python\r\n# 轮播图\r\nfrom .models import BannerInfo\r\n\r\nclass BannerInfoModelAdmin(object):\r\n    list_display=[\"name\",\"orders\",\"is_show\"]\r\n\r\nxadmin.site.register(BannerInfo, BannerInfoModelAdmin)\r\n```\r\n\r\n#### 7.1.9 修改后端`xadmin`中子应用名称\r\n\r\n- `apps.py`\r\n```python\r\nfrom django.apps import AppConfig\r\n\r\nclass HomeConfig(AppConfig):\r\n    name = \'home\'\r\n    verbose_name = \'我的首页\'\r\n```\r\n\r\n- `__init__.py`\r\n```python\r\ndefault_app_config = \"home.apps.HomeConfig\"\r\n```\r\n\r\n**然后：给轮播图添加测试数据**\r\n\r\n#### 7.1.10 轮播图获取数据\r\n* `Banner.vue`代码：\r\n```html\r\n<template>\r\n  <div class=\"banner\">\r\n    <el-carousel trigger=\"click\" height=\"480px\">\r\n      <el-carousel-item :key=\"key\" v-for=\"item,key in banner_list\">\r\n        <a :href=\"item.link\"><img :src=\"item.image\"></a>\r\n      </el-carousel-item>\r\n    </el-carousel>\r\n  </div>\r\n</template>\r\n\r\n<script>\r\n    export default {\r\n        name: \"Banner\",\r\n        data() {\r\n            return {\r\n                banner_list: [],\r\n            };\r\n        },\r\n        created() {\r\n            // 获取轮播图\r\n            this.$axios.get(this.$settings.Host + \"/banner/\").then(response => {\r\n                console.log(response.data);\r\n                this.banner_list = response.data\r\n            }).catch(error => {\r\n                console.log(error.response);\r\n            });\r\n        }\r\n    }\r\n</script>\r\n\r\n<style scoped>\r\n  .el-carousel__item h3 {\r\n    color: #475669;\r\n    font-size: 18px;\r\n    opacity: 0.75;\r\n    line-height: 300px;\r\n    margin: 0;\r\n  }\r\n\r\n  .el-carousel__item:nth-child(2n) {\r\n    background-color: #99a9bf;\r\n  }\r\n\r\n  .el-carousel__item:nth-child(2n+1) {\r\n    background-color: #d3dce6;\r\n  }\r\n\r\n  img {\r\n    width: 100%;\r\n  }\r\n</style>\r\n```','2019-10-12 01:12:00.000000','2019-10-12 01:13:05.870509',1),(4,'1','1','2019-10-12 03:18:00.000000','2019-10-12 03:18:58.582742',1),(5,'2','2','2019-10-12 03:18:00.000000','2019-10-12 03:19:04.830808',1),(6,'3','3','2019-10-12 03:19:00.000000','2019-10-12 03:19:10.775067',1),(7,'4','4','2019-10-12 03:19:00.000000','2019-10-12 03:19:16.461791',1),(8,'5','5','2019-10-12 03:19:00.000000','2019-10-12 03:19:23.767503',1),(9,'6','6','2019-10-12 03:19:00.000000','2019-10-12 03:19:28.212789',1),(10,'7','7','2019-10-12 03:19:00.000000','2019-10-12 03:19:33.597514',1),(11,'8','8','2019-10-12 03:19:00.000000','2019-10-12 03:19:37.426914',1),(12,'9','9','2019-10-12 03:19:00.000000','2019-10-12 03:19:44.074915',1),(13,'测试篇10','10','2019-10-12 03:20:00.000000','2019-10-12 03:20:21.120313',1),(14,'测试篇11','11','2019-10-12 03:20:00.000000','2019-10-12 03:20:27.012625',1),(15,'测试篇12','12','2019-10-12 03:20:00.000000','2019-10-12 03:20:31.899869',1),(16,'13','13','2019-10-12 06:57:00.000000','2019-10-12 06:57:13.510551',1),(17,'15','15','2019-10-12 06:57:00.000000','2019-10-12 06:57:18.353987',1),(18,'16','16','2019-10-12 06:57:00.000000','2019-10-12 06:57:22.766157',1),(19,'23','23','2019-10-12 06:57:00.000000','2019-10-12 06:57:27.028218',1),(20,'234','423','2019-10-12 06:57:00.000000','2019-10-12 06:57:30.778088',1),(21,'234','234','2019-10-12 06:57:00.000000','2019-10-12 06:57:34.255343',1),(22,'34','34','2019-10-12 06:57:00.000000','2019-10-12 06:57:38.619939',1),(23,'234','423','2019-10-12 06:57:00.000000','2019-10-12 06:57:42.733468',1),(24,'23','23','2019-10-12 06:57:00.000000','2019-10-12 06:57:52.151993',1),(25,'4','3','2019-10-12 06:57:00.000000','2019-10-12 06:57:55.594943',1);
/*!40000 ALTER TABLE `article_articlepost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add article post',7,'add_articlepost'),(26,'Can change article post',7,'change_articlepost'),(27,'Can delete article post',7,'delete_articlepost'),(28,'Can view article post',7,'view_articlepost'),(29,'Can add Bookmark',8,'add_bookmark'),(30,'Can change Bookmark',8,'change_bookmark'),(31,'Can delete Bookmark',8,'delete_bookmark'),(32,'Can view Bookmark',8,'view_bookmark'),(33,'Can add User Setting',9,'add_usersettings'),(34,'Can change User Setting',9,'change_usersettings'),(35,'Can delete User Setting',9,'delete_usersettings'),(36,'Can view User Setting',9,'view_usersettings'),(37,'Can add User Widget',10,'add_userwidget'),(38,'Can change User Widget',10,'change_userwidget'),(39,'Can delete User Widget',10,'delete_userwidget'),(40,'Can view User Widget',10,'view_userwidget'),(41,'Can add log entry',11,'add_log'),(42,'Can change log entry',11,'change_log'),(43,'Can delete log entry',11,'delete_log'),(44,'Can view log entry',11,'view_log'),(45,'Can add revision',12,'add_revision'),(46,'Can change revision',12,'change_revision'),(47,'Can delete revision',12,'delete_revision'),(48,'Can view revision',12,'view_revision'),(49,'Can add version',13,'add_version'),(50,'Can change version',13,'change_version'),(51,'Can delete version',13,'delete_version'),(52,'Can view version',13,'view_version');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$xPQQHlRqnbSs$dBLPHMWl8HEqYdiXhSQ3YzRU0qvNPsPwhy0jFdS4mG8=','2019-10-10 07:25:29.716265',1,'jeremy','','','865889915@qq.com',1,1,'2019-10-10 07:25:06.175766');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'article','articlepost'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(12,'reversion','revision'),(13,'reversion','version'),(6,'sessions','session'),(8,'xadmin','bookmark'),(11,'xadmin','log'),(9,'xadmin','usersettings'),(10,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-10-09 14:50:10.269018'),(2,'auth','0001_initial','2019-10-09 14:50:10.368177'),(3,'admin','0001_initial','2019-10-09 14:50:10.480050'),(4,'admin','0002_logentry_remove_auto_add','2019-10-09 14:50:10.528048'),(5,'admin','0003_logentry_add_action_flag_choices','2019-10-09 14:50:10.536031'),(6,'article','0001_initial','2019-10-09 14:50:10.556017'),(7,'contenttypes','0002_remove_content_type_name','2019-10-09 14:50:10.606992'),(8,'auth','0002_alter_permission_name_max_length','2019-10-09 14:50:10.622968'),(9,'auth','0003_alter_user_email_max_length','2019-10-09 14:50:10.635963'),(10,'auth','0004_alter_user_username_opts','2019-10-09 14:50:10.645971'),(11,'auth','0005_alter_user_last_login_null','2019-10-09 14:50:10.666942'),(12,'auth','0006_require_contenttypes_0002','2019-10-09 14:50:10.669941'),(13,'auth','0007_alter_validators_add_error_messages','2019-10-09 14:50:10.677949'),(14,'auth','0008_alter_user_username_max_length','2019-10-09 14:50:10.698924'),(15,'auth','0009_alter_user_last_name_max_length','2019-10-09 14:50:10.717914'),(16,'auth','0010_alter_group_name_max_length','2019-10-09 14:50:10.728920'),(17,'auth','0011_update_proxy_permissions','2019-10-09 14:50:10.737915'),(18,'sessions','0001_initial','2019-10-09 14:50:10.748906'),(19,'reversion','0001_squashed_0004_auto_20160611_1202','2019-10-10 07:22:35.299346'),(20,'xadmin','0001_initial','2019-10-10 07:22:35.411282'),(21,'xadmin','0002_log','2019-10-10 07:22:35.478244'),(22,'xadmin','0003_auto_20160715_0100','2019-10-10 07:22:35.558195');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0ga94kosx0qe7p30gqfsc13dlxhem3ml','NTVmMTk5ZGEyZjQ5OGNjYTI2MGE1OWYwYTkyOTA5NDJkNTcxMzk3Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5M2VlYzI2NDE2OWVmZjEzZTI3NzQ0MzJhYmIxMGZkYjU3NTg2ZmJkIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==','2019-11-02 04:41:19.368998');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_revision`
--

DROP TABLE IF EXISTS `reversion_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reversion_revision_user_id_17095f45_fk_auth_user_id` (`user_id`),
  KEY `reversion_revision_date_created_96f7c20c` (`date_created`),
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_revision`
--

LOCK TABLES `reversion_revision` WRITE;
/*!40000 ALTER TABLE `reversion_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_version`
--

DROP TABLE IF EXISTS `reversion_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`),
  KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`),
  CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_version`
--

LOCK TABLES `reversion_version` WRITE;
/*!40000 ALTER TABLE `reversion_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id` (`user_id`),
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_auth_user_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2019-10-10 07:39:11.553752','127.0.0.1','1','测试篇','create','已添加。',7,1),(2,'2019-10-10 07:46:22.168024','127.0.0.1','1','测试篇','change','修改 body',7,1),(3,'2019-10-10 07:50:19.677764','127.0.0.1','1','测试篇','change','没有字段被修改。',7,1),(4,'2019-10-10 07:50:41.179019','127.0.0.1','2','fadsf','create','已添加。',7,1),(5,'2019-10-10 07:51:33.915026','127.0.0.1','2','fadsf','change','修改 body',7,1),(6,'2019-10-10 07:52:27.128012','127.0.0.1',NULL,'','delete','批量删除 1 个 article post',NULL,1),(7,'2019-10-10 07:52:50.896884','127.0.0.1','2','fadsf','change','修改 body',7,1),(8,'2019-10-10 08:11:47.363267','127.0.0.1','2','fadsf','change','没有字段被修改。',7,1),(9,'2019-10-11 14:59:27.868372','127.0.0.1','2','fadsf','change','修改 body',7,1),(10,'2019-10-12 00:55:34.207248','127.0.0.1','2','fadsf','change','修改 body',7,1),(11,'2019-10-12 00:55:45.913117','127.0.0.1','2','fadsf','change','修改 body',7,1),(12,'2019-10-12 00:56:20.074038','127.0.0.1','2','fadsf','change','修改 body',7,1),(13,'2019-10-12 00:56:44.638919','127.0.0.1','2','fadsf','change','修改 body',7,1),(14,'2019-10-12 00:57:04.156064','127.0.0.1','2','fadsf','change','修改 body',7,1),(15,'2019-10-12 00:57:26.548207','127.0.0.1','2','fadsf','change','修改 body',7,1),(16,'2019-10-12 00:57:44.064763','127.0.0.1','2','fadsf','change','修改 body',7,1),(17,'2019-10-12 00:57:59.546085','127.0.0.1','2','fadsf','change','修改 body',7,1),(18,'2019-10-12 01:00:49.385322','127.0.0.1','2','fadsf','change','修改 body',7,1),(19,'2019-10-12 01:11:59.722393','127.0.0.1','2','fadsf','change','没有字段被修改。',7,1),(20,'2019-10-12 01:12:33.306787','127.0.0.1','3','测试篇','create','已添加。',7,1),(21,'2019-10-12 01:13:05.873509','127.0.0.1','3','测试篇','change','没有字段被修改。',7,1),(22,'2019-10-12 03:18:58.583728','127.0.0.1','4','1','create','已添加。',7,1),(23,'2019-10-12 03:19:04.830808','127.0.0.1','5','2','create','已添加。',7,1),(24,'2019-10-12 03:19:10.777071','127.0.0.1','6','3','create','已添加。',7,1),(25,'2019-10-12 03:19:16.461791','127.0.0.1','7','4','create','已添加。',7,1),(26,'2019-10-12 03:19:23.768502','127.0.0.1','8','5','create','已添加。',7,1),(27,'2019-10-12 03:19:28.213787','127.0.0.1','9','6','create','已添加。',7,1),(28,'2019-10-12 03:19:33.599499','127.0.0.1','10','7','create','已添加。',7,1),(29,'2019-10-12 03:19:37.426914','127.0.0.1','11','8','create','已添加。',7,1),(30,'2019-10-12 03:19:44.075914','127.0.0.1','12','9','create','已添加。',7,1),(31,'2019-10-12 03:20:21.121313','127.0.0.1','13','测试篇10','create','已添加。',7,1),(32,'2019-10-12 03:20:27.013624','127.0.0.1','14','测试篇11','create','已添加。',7,1),(33,'2019-10-12 03:20:31.900869','127.0.0.1','15','测试篇12','create','已添加。',7,1),(34,'2019-10-12 06:57:13.511559','127.0.0.1','16','13','create','已添加。',7,1),(35,'2019-10-12 06:57:18.353987','127.0.0.1','17','15','create','已添加。',7,1),(36,'2019-10-12 06:57:22.767160','127.0.0.1','18','16','create','已添加。',7,1),(37,'2019-10-12 06:57:27.029226','127.0.0.1','19','23','create','已添加。',7,1),(38,'2019-10-12 06:57:30.778088','127.0.0.1','20','234','create','已添加。',7,1),(39,'2019-10-12 06:57:34.256349','127.0.0.1','21','234','create','已添加。',7,1),(40,'2019-10-12 06:57:38.619939','127.0.0.1','22','34','create','已添加。',7,1),(41,'2019-10-12 06:57:42.734464','127.0.0.1','23','234','create','已添加。',7,1),(42,'2019-10-12 06:57:52.152991','127.0.0.1','24','23','create','已添加。',7,1),(43,'2019-10-12 06:57:55.594943','127.0.0.1','25','4','create','已添加。',7,1);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',1);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-10 20:30:22
