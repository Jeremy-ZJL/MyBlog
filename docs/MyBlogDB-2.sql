-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 47.102.86.225    Database: MyBlogDB
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
-- Table structure for table `article_articlepost`
--

DROP TABLE IF EXISTS `article_articlepost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_articlepost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `created_time` date NOT NULL,
  `updated_time` date NOT NULL,
  `status` varchar(1) NOT NULL,
  `likes` int(10) unsigned NOT NULL,
  `topped` tinyint(1) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `article_articlepost_category_id_ec977995_fk_article_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `article_articlepost_category_id_ec977995_fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `article_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_articlepost`
--

LOCK TABLES `article_articlepost` WRITE;
/*!40000 ALTER TABLE `article_articlepost` DISABLE KEYS */;
INSERT INTO `article_articlepost` VALUES (1,'Jeremy','测试篇1','测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试','2020-01-17','2020-01-17','p',1000,1,1),(2,'Jeremy','测试篇2','测试 测试 测试 测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',100,0,1),(3,'Jeremy','测试篇3','测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',1000,0,1),(4,'Jeremy','测试篇4','测试 测试 测试 测试 测试','2020-01-17','2020-01-19','p',0,1,1),(5,'Jeremy','测试篇5','测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',0,0,1),(6,'Jeremy','测试篇6','测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',0,0,1),(7,'Jeremy','测试篇7','<p>测试 测试 测试 测试 测试</p>\r\n\r\n<p>## sdf&nbsp;</p>','2020-01-17','2020-01-23','p',1,0,1),(8,'Jeremy','测试篇8','测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',0,0,1),(9,'Jeremy','测试篇9','测试 测试 测试 测试 测试','2020-01-17','2020-01-17','p',0,0,1),(10,'Jeremy','测试篇10','测试 测试 测试 测试 测试','2020-01-17','2020-01-18','p',0,1,1),(11,'Jeremy','测试篇11','<p># 标题一</p><p>## 标题二</p><p>### 标题三</p><p>&gt; fadsfadsfag</p>','2020-01-17','2020-01-23','p',0,0,1),(12,'Jeremy','测试篇12','<p>## 7. 首页### 7.1 轮播图功能实现#### 7.1.1 安装依赖模块和配置##### 7.1.1.1 图片处理模块 - pillow```bashpip install pillow```##### 7.1.1.2 上传文件相关配置- `settings/dev.py`文件：```python# 访问静态文件的url地址前缀STATIC_URL = \'/static/\'# 设置django的静态文件目录STATICFILES_DIRS = [    os.path.join(BASE_DIR, \"statics\")]# 项目中存储上传文件的根目录[暂时配置]，注意，static目录需要手动创建否则上传文件时报错MEDIA_ROOT = os.path.join(BASE_DIR, \"statics\")# 访问上传文件的url地址前缀MEDIA_URL =\"/media/\"```- 在`xadmin`中输出上传文件的`url`地址时, 必须要让路由识别上传文件的`media`开头的地址- **所以在总路由`urls.py`新增代码：**```python# 在url中配置media请求的url # 首先需要导入下面的库 和在settings 中配置的 MEDIA_ROOT(上传路径)from django.urls import path, re_pathfrom django.conf import settingsfrom django.views.static import serveurlpatterns = [    ... ...    # 配置url 固定的 里面的内容不能改的    re_path(r\'media/(?P.*)\', serve, {\'document_root\': settings.MEDIA_ROOT}),]```* * *#### 7.1.2 创建轮播图的模型因为当前功能是`drf`的第一个功能，所以我们先创建一个子应用`home`，创建在`luffy/apps`目录下![fa0063907b0d6a5d14003a57cf1eca70.png](en-resource://database/844:1)- 注册`home`子应用，因为子应用的位置发生了改变，所以为了原来子应用的注册写法，所以新增一个导包路径：* `settings/dev.py````pythonBASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))# 新增一个系统导包路径import syssys.path.insert(0,os.path.join(BASE_DIR,\"apps\"))INSTALLED_APPS = [	# 注意，加上drf框架的注册	    \'rest_framework\',        # 子应用    \'home\',]```&gt; 注意，pycharm会路径错误的提示。* 模型：`home/models.py````pythonfrom django.db import models# Create your models here.class BannerInfo(models.Model):    \"\"\"    轮播图    \"\"\"    # upload_to 存储子目录，真实存放地址会使用settings/dev.py配置中的MADIE_ROOT + upload_to    image = models.ImageField(upload_to=\'banner\', verbose_name=\'轮播图\', null=True,blank=True)    name = models.CharField(max_length=150, verbose_name=\'轮播图名称\')    note = models.CharField(max_length=150, verbose_name=\'备注信息\')    link = models.CharField(max_length=150, verbose_name=\'轮播图广告地址\')    orders = models.IntegerField(verbose_name=\'显示顺序\')    is_show=models.BooleanField(verbose_name=\"是否上架\",default=False)    is_delete=models.BooleanField(verbose_name=\"逻辑删除\",default=False)    class Meta:        db_table = \'ly_banner\'        verbose_name = \'轮播图\'        verbose_name_plural = verbose_name    def __str__(self):        return self.name```- 新增模型后需要进行数据迁移```bashpython manage.py makemigrationspython manage.py migrate```</p>','2020-01-18','2020-01-23','p',0,1,1),(13,'Jeremy','测试篇13','### 8.3 Django REST framework JWT   \r\n在用户注册或登录后，我们想记录用户的登录状态，或者为用户创建身份认证的凭证。我们不再使用Session认证机制，而使用Json Web Token认证机制。&gt;**Json Web Token**(JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准(RFC 7519).&gt;该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景。&gt;JWT的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源，也可以增加一些额外的其它业务逻辑所必须的声明信息，该token也可直接被用于认证，也可被加密。[知乎 - Server端的认证神器——JWT](<a href=\"https://zhuanlan.zhihu.com/p/27370773\" rel=\"nofollow\">https://zhuanlan.zhihu.com/p/27370773</a>)[什么是 JWT -- JSON WEB TOKEN](<a href=\"https://www.jianshu.com/p/576dbf44b2ae\" rel=\"nofollow\">https://www.jianshu.com/p/576dbf44b2ae</a>)#### 8.3.1 JWT - 介绍JWT就是一段字符串，由三段信息构成的，将这三段信息文本用 ` .` 链接一起就构成了Jwt字符串。就像这样：```sheyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ```* 第一部分我们称它为**头部**（header），* 第二部分我们称其为**载荷**（payload），类似于飞机上承载的物品* 第三部分是**签证**（signature）。##### 8.3.1.1 **头部**（header）jwt的头部承载两部分信息：* 声明类型，这里是jwt* 声明加密的算法 通常直接使用 HMAC SHA256完整的头部就像下面这样的JSON：```json{  \'typ\': \'JWT\',  \'alg\': \'HS256\'}```然后将头部进行base64加密（该加密是可以对称解密的),构成了第一部分.```eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9```##### 8.3.1.2 **载荷**（payload）载荷就是存放有效信息的地方。这个名字像是特指飞机上承载的货品，这些有效信息包含三个部分：* 标准中注册的声明* 公共的声明* 私有的声明**标准中注册的声明**(建议但不强制使用) ：* **iss**：jwt签发者；* **sub**：jwt所面向的用户；* **aud**：接收jwt的一方；* **exp**：jwt的过期时间，这个过期时间必须要大于签发时间；* **nbf**：定义在什么时间之前，该jwt都是不可用的；* **iat**：jwt的签发时间；* **jti**：jwt的唯一身份标识，主要用来作为一次性token,从而回避时序攻击；**公共的声明**：公共的声明可以添加任何的信息，一般添加用户的相关信息或其他业务需要的必要信息.但不建议添加敏感信息，因为该部分在客户端可解密.**私有的声明**：私有声明是提供者和消费者所共同定义的声明，一般不建议存放敏感信息，因为base64是对称解密的，意味着该部分信息可以归类为明文信息。定义一个payload:```json{  \"sub\": \"1234567890\",  \"name\": \"John Doe\",  \"admin\": true}```然后将其进行base64加密，得到JWT的第二部分。```jsoneyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9```##### 8.3.1.3 **签证**（signature）JWT的第三部分是一个签证信息，这个签证信息由三部分组成：* header (base64后的)* payload (base64后的)* secret这个部分需要base64加密后的header和base64加密后的payload使用 `.` 连接组成的字符串，然后通过`header`中声明的加密方式进行加盐`secret` 组合加密，然后就构成了jwt的第三部分。```python# python 使用base64模块的算法,对数据进行编码转换[可以理解是加密]import base64data_dict = {    \"name\":\"xiaoming\"}data_str = str(data_dict)data1 = base64.b64encode(data_str)print(data1)   # \'eyduYW1lJzogJ3hpYW9taW5nJ30=\'data2 = base64.b64decode(data1)print(data2)   # \"{\'name\': \'xiaoming\'}\"```&gt;**注意**：secret是保存在服务器端的，jwt的签发生成也是在服务器端的，secret就是用来进行jwt的签发和jwt的验证，所以，它就是你服务端的私钥，在任何场景都不应该流露出去。一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。&gt;关于签发和核验JWT，我们可以使用Django REST framework JWT扩展来完成。&gt;[文档网站](<a href=\"http://jpadilla.github.io/django-rest-framework-jwt/\" rel=\"nofollow\">http://jpadilla.github.io/django-rest-framework-jwt/</a>)\r\n![](/media/editor\\image_20200130152913675857.png)','2020-01-19','2020-01-30','p',0,0,1),(15,'Jeremy','git的使用','## 如何多人协同开发同一个项目？\r\n使用代码版本控制[version control]软件,\r\n目前市面上比较流行的代码版本控制器有: git,svn,csv\r\n\r\n### 1、使用git管理代码版本\r\n本项目使用git管理项目代码，代码库放在gitee码云平台。（注意，公司中通常放在gitlab私有服务器中）\r\n\r\n#### 1.1、Git 的诞生\r\n2005 年 4 月3 日，Git 是目前世界上最先进的分布式版本控制系统（没有之一）\r\n作用：源代码管理\r\n\r\n**为什么要进行源代码管理?**\r\n\r\n* 方便多人协同开发\r\n* 方便版本控制\r\n\r\n#### 1.2、git与svn区别\r\n\r\nSVN 都是集中控制管理的，也就是有一个中央服务器，大家都把代码提交到中央服务器，而 git 是分布式的版本控制工具，也就是说没有中央服务器，每个节点的地位平等。\r\n\r\n**SVN**\r\n![27bece63507237b62bbc1972c584669d.png](en-resource://database/787:1)\r\n\r\n**Git**\r\n![142c985f3b2ab1ac181034f6836c6f82.png](en-resource://database/786:1)\r\n\r\n\r\n>注意:\r\n>    git 的使用分两种不同模式:\r\n>        1. 本地开发管理\r\n>        2. 远程开发管理\r\n\r\nGit工作区、暂存区和版本库\r\n![e2f929ab5359621eecf415f0fdbca546.png](en-resource://database/788:1)\r\n\r\n### 2、工作区介绍\r\n就是在你本要电脑磁盘上能看到的目录。\r\n\r\n\r\n### 2、暂存区介绍\r\n一般存放在【.git】目录下的index文件(.git/index) 中，所以我们把暂存区有时也叫作索引。\r\n\r\n### 3、版本库介绍\r\n工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库。git中的head/master是分支，是版本库。\r\n\r\n**git项目仓库的本地搭建**\r\n```html\r\ncd进入到自己希望存储代码的目录路径，并创建本地仓库.git\r\n新创建的本地仓库.git是个空仓库\r\n\r\n  cd 目录路径\r\n  git init gitdemo  # 如果没有声明目录,则自动把当前目录作为git仓库\r\n```\r\n\r\n创建仓库\r\n![dd1fe21fd7c15e07b317c2815c4b3564.png](en-resource://database/790:1)\r\n\r\n* * *\r\n\r\n**仓库目录的结构**\r\n```bash\r\nbranches/   分支管理目录\r\nconfig      当前项目仓木的配置信息\r\ndescription 当前项目的描述\r\nHEAD        当前项目仓库的当前版本信息\r\nhooks       当前项目仓库的钩子目录[可以利用这个目录下面的文件实现自己拉去代码到服务器]\r\ninfo        仓库相关信息\r\nobjects     仓库版本信息\r\nrefs        引用信息\r\n```\r\n\r\n* * *\r\n\r\n**配置用户名和邮箱**\r\n```bash\r\ngit config --global user.name \'jeremy\'\r\ngit config --global user.email \'865889915@qq.com\'\r\n```\r\n![f72a05976e62de9760ff8884e34b46e0.png](en-resource://database/791:1)\r\n\r\n* * *\r\n\r\n**查看仓库状态**\r\n```bash\r\ngit status\r\n\r\ngit status –s 简约显示\r\n```\r\n\r\n* 红色表示新建文件或者新修改的文件,都在工作区.\r\n* 绿色表示文件在暂存区\r\n* 新建的`login.py`文件在工作区，需要添加到暂存区并提交到仓库区\r\n\r\n![ad28b346075e4738e79b474c4d5ef4bf.png](en-resource://database/789:1)\r\n\r\n上图表示： 暂时没有新文件需要提交到暂存区\r\n\r\n* * *\r\n\r\n**添加文件到暂存区**\r\n```bash\r\n  # 添加项目中所有文件\r\n  git add .\r\n  或者\r\n  # 添加指定文件\r\n  git add login.py\r\n```\r\n例如： 创建3个文件 ，并查看状态.\r\n\r\n* * *\r\n\r\n**提交到版本库**\r\n```bash\r\n git commit -am \"版本描述\"\r\n```\r\n\r\n* * *\r\n\r\n**手动删除文件**\r\n```bash\r\n手动操作删除 或者 在命令行下 使用 rm 文件名 删除 都是表示在工作区删除.\r\n对于这种删除,如果还原,则可以使用 git checkout 文件名\r\n```\r\n![b389bae423da525cfa708d04aa59fd7a.png](en-resource://database/794:1)\r\n\r\n* * *\r\n\r\n**版本删除**\r\n```bash\r\n如果使用 git rm 文件名, 这种操作属于暂存区删除,这种删除无法直接git checkout 文件名 来还原.\r\n如果直接执行git checkout 命令,则报错如下:\r\n```\r\n![5a38f5658fdfb97782184f8aeb3f0618.png](en-resource://database/793:1)\r\n\r\n```bash\r\n如果要还原在暂存区中删除的文件,必须先执行 git reset head\r\n```\r\n![14ea933479afc2006997a5e603dedc4a.png](en-resource://database/792:1)\r\n\r\n* * *\r\n\r\n**查看历史版本[查看日志]**\r\n```bash\r\ngit log   或者   git reflog\r\n \r\n过滤查看日志\r\n  git log –p \r\n  退出按【q】键\r\n  ctrl+f向下分页\r\n  ctrl+b 向上分页\r\n\r\n显示指定日期之后的日志   git log --after  \'2018-11-6\'\r\n显示指定日期之前的日志   git log --before \'2018-11-6\'\r\n\r\n指定显示指定开发者的日志  git log --author \'lisi\'\r\n```\r\n\r\n* * *\r\n\r\n**回退版本**\r\n* * *\r\n* **方案一：**\r\n    * `HEAD`表示当前最新版本\r\n    * `HEAD^`表示当前最新版本的前一个版本\r\n    * `HEAD^^`表示当前最新版本的前两个版本，以此类推...\r\n    * `HEAD~1`表示当前最新版本的前一个版本\r\n    * `HEAD~10`表示当前最新版本的前10个版本，以此类推...\r\n\r\n```bash\r\ngit reset --hard HEAD^\r\n```\r\n\r\n* * *\r\n\r\n* **方案二：当版本非常多时可选择的方案**\r\n    * 通过每个版本的版本号回退到指定版本\r\n    \r\n```bash\r\ngit reset --hard 版本号\r\n```\r\n***\r\n**取消暂存**\r\n***\r\n```bash\r\ngit reset head\r\ngit reset <file> ：从暂存区恢复到工作文件\r\ngit reset -- ：从暂存区恢复到工作文件\r\n```\r\n\r\n* * *\r\n\r\n### 查看文件状态\r\n\r\n**针对与文件所处的不同分区，文件所处的状态:**\r\n* (1)未追踪, 文件第一次出现在工作区, 版本库还没有存储该文件的状态\r\n* (2)已追踪, 只要第一次,git add了文件, 文件就是已追踪\r\n* (3)未修改, 文件在工作区未被编辑\r\n* (4)已修改, 文件在工作区被修改\r\n* (5)未暂存, 文件已修改, 但是没有add到暂存区\r\n* (6)已暂存, 已经将修改的文件add到暂存区\r\n* (7)未提交, 已暂存的文件, 没有commit提交. 处于暂存区\r\n* (8)已提交, 提交到版本库的文件修改,只有commit以后才会有仓库的版本号生成\r\n\r\n* * *\r\n\r\n**注意：**\r\n\r\n### 2、在gitee平台创建工程\r\n\r\n#### 1） 创建私有项目库 \r\n\r\n#### 2）克隆项目到本地\r\n```bash\r\ngit clone 仓库地址\r\n注意，如果当前目录下出现git仓库同名目录时，会克隆失败。\r\n```\r\n![0919c1f81ac3149e69ad8c483eef7d1f.png](en-resource://database/795:1)\r\n\r\n#### 3）创建并切换分支到dev\r\n```bash\r\n# git branch dev      # 创建本地分支dev,dev是自定义\r\n# git checkout dev    # 切换本地分支代码\r\ngit checkout -b dev   # 这里是上面两句代码的简写\r\n```\r\n\r\n**git提交**\r\n```bash\r\ngit add 代码目录\r\ngit status\r\ngit commit -m \'添加项目代码\'\r\n```\r\n\r\n**推送到远端**\r\n```bash\r\ngit push origin dev:dev\r\n```\r\n\r\n**如果推送代码,出现以下提示: git pull ....,则表示当前本地的代码和线上的代码版本不同.**\r\n```bash\r\n1. 把线上的代码执行以下命令,拉取到本地,进行同步\r\ngit pull\r\n\r\n2. 根据提示,移除多余的冲突的文件,也可以删除.\r\n完成这些步骤以后,再次add,commit,push即可.\r\n```','2020-01-19','2020-01-30','p',0,1,1),(16,'Jeremy','测试篇15','- **手动安装**\r\n    - 执行脚本：`sh adminset/install/server/server_install.sh`\r\n    - 1、安装过程中需要输入管理员数据库等交互信息，如果安装中断只需再次执行脚本`server_install.sh`即可\r\n    - 2、安装过程中会生成`rsa密钥`，位于`/root/.ssh` 目录下，如果已经存在，忽略即可。\r\n    - 手动安装交互信息说明\r\n        - 1、如果系统开启了selinux会提示：`Do you want to disabled selinux?[yes/no]` | 选择yes。(默认yes)\r\n        - 2、YUM源选择提示：`Do you want to use an internet yum repository?[yes/no]` | 没有本地的yum源请选择yes，如果有本地的YUM源（包括epel源）请选择no。(默认值yes)\r\n        - 3、数据库选择提示：`Do you want to create a new mysql database?[yes/no]` | 本地没有数据库选择yes自动下载安装mariadb数据库，如已经存在mysql或mariadb数据库选择no，然后填写相关信息主机、端口、用户名、密码。(默认值yes)\r\n        - 4、mongodb选择提示：`Do you want to create a new Mongodb?[yes/no]` | 本地没有mongodb选择yes自动下载安装mongodb数据库，如已经存在mongodb数据库选择no，然后填写相关信息主机、端口、用户名、密码。(默认值yes)\r\n        - 5、创建超管用户提示：`Please create your adminset\' super admin:` 输入超管用户名、邮件、密码。\r\n    - 访问：`http://your_server_ip`\r\n\r\n```python\r\n#!/usr/bin/env python3\r\n# -*- coding:utf-8 -*-\r\n\r\nimport subprocess\r\n\r\n\r\ndef collect():\r\n    filter_keys = [\'Manufacturer\', \'Serial Number\', \'Product Name\', \'UUID\', \'Wake-up Type\']\r\n    raw_data = {}\r\n\r\n    for key in filter_keys:\r\n        try:\r\n            res = subprocess.Popen(\"sudo dmidecode -t system|grep \'%s\'\" % key,\r\n                                   stdout=subprocess.PIPE, shell=True)\r\n            result = res.stdout.read().decode()\r\n            data_list = result.split(\':\')\r\n\r\n            if len(data_list) > 1:\r\n                raw_data[key] = data_list[1].strip()\r\n            else:\r\n                raw_data[key] = \'\'\r\n        except Exception as e:\r\n            print(e)\r\n            raw_data[key] = \'\'\r\n\r\n    data = dict()\r\n    data[\'asset_type\'] = \'server\'\r\n    data[\'manufacturer\'] = raw_data[\'Manufacturer\']\r\n    data[\'sn\'] = raw_data[\'Serial Number\']\r\n    data[\'model\'] = raw_data[\'Product Name\']\r\n    data[\'uuid\'] = raw_data[\'UUID\']\r\n    data[\'wake_up_type\'] = raw_data[\'Wake-up Type\']\r\n\r\n    data.update(get_os_info())\r\n    data.update(get_cpu_info())\r\n    data.update(get_ram_info())\r\n    data.update(get_nic_info())\r\n    # data.update(get_disk_info())  # 硬盘信息收集有问题\r\n    return data\r\n\r\n\r\ndef get_os_info():\r\n    \"\"\"\r\n    获取操作系统信息\r\n    :return:\r\n    \"\"\"\r\n    distributor = subprocess.Popen(\"lsb_release -a|grep \'Distributor ID\'\",\r\n                                   stdout=subprocess.PIPE, shell=True)\r\n    distributor = distributor.stdout.read().decode().split(\":\")\r\n\r\n    release = subprocess.Popen(\"lsb_release -a|grep \'Description\'\",\r\n                               stdout=subprocess.PIPE, shell=True)\r\n\r\n    release = release.stdout.read().decode().split(\":\")\r\n    data_dic = {\r\n        \"os_distribution\": distributor[1].strip() if len(distributor) > 1 else \"\",\r\n        \"os_release\": release[1].strip() if len(release) > 1 else \"\",\r\n        \"os_type\": \"Linux\",\r\n    }\r\n    return data_dic\r\n```\r\n![](/media/editor\\image_20200130115101869804.png)','2020-01-30','2020-01-30','p',0,0,1);
/*!40000 ALTER TABLE `article_articlepost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_articlepost_tags`
--

DROP TABLE IF EXISTS `article_articlepost_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_articlepost_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articlepost_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `article_articlepost_tags_articlepost_id_tags_id_9b9e31f0_uniq` (`articlepost_id`,`tags_id`) USING BTREE,
  KEY `article_articlepost_tags_tags_id_98ce6882_fk_article_tags_id` (`tags_id`) USING BTREE,
  CONSTRAINT `article_articlepost__articlepost_id_ec19821a_fk_article_a` FOREIGN KEY (`articlepost_id`) REFERENCES `article_articlepost` (`id`),
  CONSTRAINT `article_articlepost_tags_tags_id_98ce6882_fk_article_tags_id` FOREIGN KEY (`tags_id`) REFERENCES `article_tags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_articlepost_tags`
--

LOCK TABLES `article_articlepost_tags` WRITE;
/*!40000 ALTER TABLE `article_articlepost_tags` DISABLE KEYS */;
INSERT INTO `article_articlepost_tags` VALUES (1,1,1),(2,2,1),(3,2,2),(4,2,3),(5,3,1),(6,4,1),(7,5,1),(8,5,3),(9,7,3),(10,8,2),(11,9,2),(13,11,1),(12,12,1),(14,15,1),(15,16,1);
/*!40000 ALTER TABLE `article_articlepost_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_category`
--

DROP TABLE IF EXISTS `article_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_category`
--

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
INSERT INTO `article_category` VALUES (1,'Python');
/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_tags`
--

DROP TABLE IF EXISTS `article_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_tags`
--

LOCK TABLES `article_tags` WRITE;
/*!40000 ALTER TABLE `article_tags` DISABLE KEYS */;
INSERT INTO `article_tags` VALUES (1,'tags1'),(2,'tags2'),(3,'tags3'),(4,'python基础');
/*!40000 ALTER TABLE `article_tags` ENABLE KEYS */;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  `codename` varchar(100) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry','add_logentry',1),(2,'Can change log entry','change_logentry',1),(3,'Can delete log entry','delete_logentry',1),(4,'Can view log entry','view_logentry',1),(5,'Can add permission','add_permission',2),(6,'Can change permission','change_permission',2),(7,'Can delete permission','delete_permission',2),(8,'Can view permission','view_permission',2),(9,'Can add group','add_group',3),(10,'Can change group','change_group',3),(11,'Can delete group','delete_group',3),(12,'Can view group','view_group',3),(13,'Can add user','add_user',4),(14,'Can change user','change_user',4),(15,'Can delete user','delete_user',4),(16,'Can view user','view_user',4),(17,'Can add content type','add_contenttype',5),(18,'Can change content type','change_contenttype',5),(19,'Can delete content type','delete_contenttype',5),(20,'Can view content type','view_contenttype',5),(21,'Can add session','add_session',6),(22,'Can change session','change_session',6),(23,'Can delete session','delete_session',6),(24,'Can view session','view_session',6),(25,'Can add Bookmark','add_bookmark',7),(26,'Can change Bookmark','change_bookmark',7),(27,'Can delete Bookmark','delete_bookmark',7),(28,'Can view Bookmark','view_bookmark',7),(29,'Can add User Setting','add_usersettings',8),(30,'Can change User Setting','change_usersettings',8),(31,'Can delete User Setting','delete_usersettings',8),(32,'Can view User Setting','view_usersettings',8),(33,'Can add User Widget','add_userwidget',9),(34,'Can change User Widget','change_userwidget',9),(35,'Can delete User Widget','delete_userwidget',9),(36,'Can view User Widget','view_userwidget',9),(37,'Can add log entry','add_log',10),(38,'Can change log entry','change_log',10),(39,'Can delete log entry','delete_log',10),(40,'Can view log entry','view_log',10),(41,'Can add revision','add_revision',11),(42,'Can change revision','change_revision',11),(43,'Can delete revision','delete_revision',11),(44,'Can view revision','view_revision',11),(45,'Can add version','add_version',12),(46,'Can change version','change_version',12),(47,'Can delete version','delete_version',12),(48,'Can view version','view_version',12),(49,'Can add 分类信息','add_category',13),(50,'Can change 分类信息','change_category',13),(51,'Can delete 分类信息','delete_category',13),(52,'Can view 分类信息','view_category',13),(53,'Can add tags','add_tags',14),(54,'Can change tags','change_tags',14),(55,'Can delete tags','delete_tags',14),(56,'Can view tags','view_tags',14),(57,'Can add 文章列表','add_articlepost',15),(58,'Can change 文章列表','change_articlepost',15),(59,'Can delete 文章列表','delete_articlepost',15),(60,'Can view 文章列表','view_articlepost',15);
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
  `date_joined` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$JDgcvscW3u2w$C02C979k7Vkifj3EPkTMTfmECyNdkomk3HCoBN6PEPA=','2020-01-23 03:15:49.557377',1,'jeremy','','','865889915@qq.com',1,1,'2020-01-17 07:57:00.000000');
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`) USING BTREE,
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`) USING BTREE,
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60);
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
  `action_time` datetime(6) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(15,'article','articlepost'),(13,'article','category'),(14,'article','tags'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(11,'reversion','revision'),(12,'reversion','version'),(6,'sessions','session'),(7,'xadmin','bookmark'),(10,'xadmin','log'),(8,'xadmin','usersettings'),(9,'xadmin','userwidget');
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
  `applied` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-01-17 07:56:52.185781'),(2,'contenttypes','0002_remove_content_type_name','2020-01-17 07:56:52.551978'),(3,'auth','0001_initial','2020-01-17 07:56:53.891898'),(4,'admin','0001_initial','2020-01-17 07:56:55.178856'),(5,'admin','0002_logentry_user','2020-01-17 07:56:55.493945'),(6,'article','0001_initial','2020-01-17 07:56:56.561191'),(7,'reversion','0001_squashed_0004_auto_20160611_1202','2020-01-17 07:56:57.608761'),(8,'sessions','0001_initial','2020-01-17 07:56:58.279517'),(9,'xadmin','0001_initial','2020-01-17 07:56:59.154178'),(10,'xadmin','0002_log','2020-01-17 07:57:00.029490'),(11,'xadmin','0003_auto_20160715_0100','2020-01-17 07:57:00.406911'),(12,'article','0002_auto_20200123_1135','2020-01-23 03:36:06.233304');
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
  `expire_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  KEY `django_session_expire_date_a5c62663` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8jnzwjh42ttv77csdrckrhnxcgqtf2gg','MWFjNmYxYzcyMjEyMzVlMDY5M2EyNDM0YTE3NzUzOWQ1MThlYThmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==','2020-02-13 07:29:20.034884'),('kztmoegavvfu1awof6rexggm50l5smq1','MWFjNmYxYzcyMjEyMzVlMDY5M2EyNDM0YTE3NzUzOWQ1MThlYThmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==','2020-02-02 13:26:05.138528');
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
  `date_created` datetime(6) DEFAULT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `reversion_revision_user_id_17095f45_fk_auth_user_id` (`user_id`) USING BTREE,
  KEY `reversion_revision_date_created_96f7c20c` (`date_created`) USING BTREE,
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`) USING BTREE,
  KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`) USING BTREE,
  CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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
  `action_time` datetime(6) DEFAULT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`) USING BTREE,
  KEY `xadmin_log_user_id_bb16a176_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2020-01-17 07:58:44.756513','192.168.5.44','1','Python','create','已添加。',13,1),(2,'2020-01-17 07:59:52.619128','192.168.5.44','1','测试篇','create','已添加。',15,1),(3,'2020-01-17 08:00:35.982821','192.168.5.44','1','测试篇','change','没有字段被修改。',15,1),(4,'2020-01-17 08:03:24.589688','192.168.5.44','1','tags1','create','已添加。',14,1),(5,'2020-01-17 08:03:33.226048','192.168.5.44','2','tags2','create','已添加。',14,1),(6,'2020-01-17 08:03:42.866154','192.168.5.44','3','tags3','create','已添加。',14,1),(7,'2020-01-17 08:04:05.716918','192.168.5.44','1','测试篇1','change','修改 title 和 tags',15,1),(8,'2020-01-17 08:04:29.821339','192.168.5.44','2','测试篇2','create','已添加。',15,1),(9,'2020-01-17 08:04:51.741819','192.168.5.44','1','测试篇1','change','修改 topped',15,1),(10,'2020-01-17 08:05:33.293865','192.168.5.44','1','jeremy','change','修改 last_login 和 user_permissions',4,1),(11,'2020-01-17 08:05:47.107905','192.168.5.44','1','jeremy','change','没有字段被修改。',4,1),(12,'2020-01-17 09:33:14.230037','192.168.5.44','3','测试篇3','create','已添加。',15,1),(13,'2020-01-17 09:33:28.550317','192.168.5.44','4','测试篇4','create','已添加。',15,1),(14,'2020-01-17 09:33:46.968656','192.168.5.44','5','测试篇5','create','已添加。',15,1),(15,'2020-01-17 09:34:01.382785','192.168.5.44','6','测试篇6','create','已添加。',15,1),(16,'2020-01-17 09:34:21.003006','192.168.5.44','7','测试篇7','create','已添加。',15,1),(17,'2020-01-17 09:34:36.898515','192.168.5.44','8','测试篇8','create','已添加。',15,1),(18,'2020-01-17 09:34:52.855171','192.168.5.44','9','测试篇9','create','已添加。',15,1),(19,'2020-01-17 09:35:11.814729','192.168.5.44','10','测试篇10','create','已添加。',15,1),(20,'2020-01-17 09:35:25.427807','192.168.5.44','11','测试篇11','create','已添加。',15,1),(21,'2020-01-18 02:03:11.204033','192.168.5.44','10','测试篇10','change','修改 topped',15,1),(22,'2020-01-18 02:07:19.430692','192.168.5.44','12','测试篇12','create','已添加。',15,1),(23,'2020-01-19 01:18:18.426842','192.168.5.44','11','测试篇11','change','修改 tags',15,1),(24,'2020-01-19 01:18:40.304039','192.168.5.44','13','测试篇13','create','已添加。',15,1),(25,'2020-01-19 01:18:41.757602','192.168.5.44','14','测试篇13','create','已添加。',15,1),(26,'2020-01-19 01:18:53.714002','192.168.5.44',NULL,'','delete','批量删除 1 个 文章列表',NULL,1),(27,'2020-01-19 02:12:23.992097','192.168.5.44','13','测试篇13','change','修改 status',15,1),(28,'2020-01-19 02:16:56.876197','192.168.5.44','4','测试篇4','change','修改 topped',15,1),(29,'2020-01-19 03:44:02.057272','192.168.5.44','15','git的使用','create','已添加。',15,1),(30,'2020-01-19 06:44:45.794804','192.168.5.44','13','测试篇13','change','修改 body 和 status',15,1),(31,'2020-01-19 06:44:57.162109','192.168.5.44','15','git的使用','change','修改 status',15,1),(32,'2020-01-19 06:46:15.331057','192.168.5.44','15','git的使用','change','修改 status',15,1),(33,'2020-01-19 10:09:37.283921','192.168.5.44','12','测试篇12','change','修改 body',15,1),(34,'2020-01-19 12:52:53.430838','192.168.5.44','12','测试篇12','change','修改 body',15,1),(35,'2020-01-19 12:53:02.707476','192.168.5.44','13','测试篇13','change','修改 body',15,1),(36,'2020-01-19 13:05:29.185300','192.168.5.44','15','git的使用','change','修改 body',15,1),(37,'2020-01-21 08:44:59.429512','219.132.138.58','4','python基础','create','已添加。',14,1),(38,'2020-01-23 06:54:42.750238','127.0.0.1','7','测试篇7','change','修改 body',15,1),(39,'2020-01-23 07:02:08.800862','127.0.0.1','15','git的使用','change','没有字段被修改。',15,1),(40,'2020-01-23 07:41:43.125088','127.0.0.1','12','测试篇12','change','没有字段被修改。',15,1),(41,'2020-01-23 08:27:06.875343','127.0.0.1','15','git的使用','change','修改 body',15,1),(42,'2020-01-23 08:29:16.986168','127.0.0.1','13','测试篇13','change','修改 body',15,1),(43,'2020-01-23 08:29:25.644046','127.0.0.1','12','测试篇12','change','修改 body',15,1),(44,'2020-01-23 08:30:36.592843','127.0.0.1','11','测试篇11','change','修改 body',15,1),(45,'2020-01-30 03:37:06.023339','127.0.0.1','15','git的使用','change','没有字段被修改。',15,1),(46,'2020-01-30 03:51:47.429386','127.0.0.1','16','测试篇15','create','已添加。',15,1),(47,'2020-01-30 05:48:49.687903','127.0.0.1','15','git的使用','change','修改 body',15,1),(48,'2020-01-30 07:28:21.753124','127.0.0.1','16','测试篇15','change','没有字段被修改。',15,1),(49,'2020-01-30 07:29:18.043889','127.0.0.1','13','测试篇13','change','修改 body',15,1);
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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',1),(2,'site-theme','/static/xadmin/css/themes/bootstrap-xadmin.css',1);
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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `xadmin_userwidget_user_id_c159233a_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2020-01-30 19:55:00
