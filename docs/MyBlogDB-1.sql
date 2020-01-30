/*
 Navicat Premium Data Transfer

 Source Server         : myblog
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : 47.102.86.225:3399
 Source Schema         : MyBlogDB

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 20/01/2020 10:46:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_articlepost
-- ----------------------------
DROP TABLE IF EXISTS `article_articlepost`;
CREATE TABLE `article_articlepost`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_time` date NOT NULL,
  `updated_time` date NOT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `likes` int(10) UNSIGNED NOT NULL,
  `topped` tinyint(1) NOT NULL,
  `category_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_articlepost_category_id_ec977995_fk_article_category_id`(`category_id`) USING BTREE,
  CONSTRAINT `article_articlepost_category_id_ec977995_fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `article_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_articlepost
-- ----------------------------
INSERT INTO `article_articlepost` VALUES (1, 'Jeremy', '测试篇1', '测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试\r\n测试', '2020-01-17', '2020-01-17', 'p', 1000, 1, 1);
INSERT INTO `article_articlepost` VALUES (2, 'Jeremy', '测试篇2', '测试 测试 测试 测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 100, 0, 1);
INSERT INTO `article_articlepost` VALUES (3, 'Jeremy', '测试篇3', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 1000, 0, 1);
INSERT INTO `article_articlepost` VALUES (4, 'Jeremy', '测试篇4', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-19', 'p', 0, 1, 1);
INSERT INTO `article_articlepost` VALUES (5, 'Jeremy', '测试篇5', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (6, 'Jeremy', '测试篇6', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (7, 'Jeremy', '测试篇7', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 1, 0, 1);
INSERT INTO `article_articlepost` VALUES (8, 'Jeremy', '测试篇8', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (9, 'Jeremy', '测试篇9', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-17', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (10, 'Jeremy', '测试篇10', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-18', 'p', 0, 1, 1);
INSERT INTO `article_articlepost` VALUES (11, 'Jeremy', '测试篇11', '测试 测试 测试 测试 测试', '2020-01-17', '2020-01-19', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (12, 'Jeremy', '测试篇12', '## 7. 首页\r\n\r\n### 7.1 轮播图功能实现\r\n\r\n#### 7.1.1 安装依赖模块和配置\r\n\r\n##### 7.1.1.1 图片处理模块 - pillow\r\n```bash\r\npip install pillow\r\n```\r\n\r\n##### 7.1.1.2 上传文件相关配置\r\n\r\n- `settings/dev.py`文件：\r\n```python\r\n# 访问静态文件的url地址前缀\r\nSTATIC_URL = \'/static/\'\r\n\r\n# 设置django的静态文件目录\r\nSTATICFILES_DIRS = [\r\n    os.path.join(BASE_DIR, \"statics\")\r\n]\r\n\r\n# 项目中存储上传文件的根目录[暂时配置]，注意，static目录需要手动创建否则上传文件时报错\r\nMEDIA_ROOT = os.path.join(BASE_DIR, \"statics\")\r\n\r\n# 访问上传文件的url地址前缀\r\nMEDIA_URL =\"/media/\"\r\n```\r\n\r\n- 在`xadmin`中输出上传文件的`url`地址时, 必须要让路由识别上传文件的`media`开头的地址\r\n\r\n- **所以在总路由`urls.py`新增代码：**\r\n```python\r\n# 在url中配置media请求的url \r\n# 首先需要导入下面的库 和在settings 中配置的 MEDIA_ROOT(上传路径)\r\nfrom django.urls import path, re_path\r\nfrom django.conf import settings\r\nfrom django.views.static import serve\r\n\r\nurlpatterns = [\r\n    ... ...\r\n    # 配置url 固定的 里面的内容不能改的\r\n    re_path(r\'media/(?P<path>.*)\', serve, {\'document_root\': settings.MEDIA_ROOT}),\r\n]\r\n```\r\n\r\n* * *\r\n#### 7.1.2 创建轮播图的模型\r\n\r\n因为当前功能是`drf`的第一个功能，所以我们先创建一个子应用`home`，创建在`luffy/apps`目录下\r\n\r\n![fa0063907b0d6a5d14003a57cf1eca70.png](en-resource://database/844:1)\r\n\r\n- 注册`home`子应用，因为子应用的位置发生了改变，所以为了原来子应用的注册写法，所以新增一个导包路径：\r\n* `settings/dev.py`\r\n```python\r\nBASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))\r\n\r\n# 新增一个系统导包路径\r\nimport sys\r\nsys.path.insert(0,os.path.join(BASE_DIR,\"apps\"))\r\n\r\nINSTALLED_APPS = [\r\n	# 注意，加上drf框架的注册	\r\n    \'rest_framework\',\r\n    \r\n    # 子应用\r\n    \'home\',\r\n]\r\n```\r\n> 注意，pycharm会路径错误的提示。\r\n\r\n* 模型：`home/models.py`\r\n```python\r\nfrom django.db import models\r\n\r\n# Create your models here.\r\nclass BannerInfo(models.Model):\r\n    \"\"\"\r\n    轮播图\r\n    \"\"\"\r\n    # upload_to 存储子目录，真实存放地址会使用settings/dev.py配置中的MADIE_ROOT + upload_to\r\n    image = models.ImageField(upload_to=\'banner\', verbose_name=\'轮播图\', null=True,blank=True)\r\n    name = models.CharField(max_length=150, verbose_name=\'轮播图名称\')\r\n    note = models.CharField(max_length=150, verbose_name=\'备注信息\')\r\n    link = models.CharField(max_length=150, verbose_name=\'轮播图广告地址\')\r\n    orders = models.IntegerField(verbose_name=\'显示顺序\')\r\n    is_show=models.BooleanField(verbose_name=\"是否上架\",default=False)\r\n    is_delete=models.BooleanField(verbose_name=\"逻辑删除\",default=False)\r\n\r\n    class Meta:\r\n        db_table = \'ly_banner\'\r\n        verbose_name = \'轮播图\'\r\n        verbose_name_plural = verbose_name\r\n\r\n    def __str__(self):\r\n        return self.name\r\n```\r\n\r\n- 新增模型后需要进行数据迁移\r\n```bash\r\npython manage.py makemigrations\r\npython manage.py migrate\r\n```', '2020-01-18', '2020-01-19', 'p', 0, 1, 1);
INSERT INTO `article_articlepost` VALUES (13, 'Jeremy', '测试篇13', '### 8.3 Django REST framework JWT\r\n\r\n&emsp;&emsp; 在用户注册或登录后，我们想记录用户的登录状态，或者为用户创建身份认证的凭证。我们不再使用Session认证机制，而使用Json Web Token认证机制。\r\n\r\n>**Json Web Token**(JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准(RFC 7519).\r\n>该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景。\r\n>JWT的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源，也可以增加一些额外的其它业务逻辑所必须的声明信息，该token也可直接被用于认证，也可被加密。\r\n\r\n[知乎 - Server端的认证神器——JWT](https://zhuanlan.zhihu.com/p/27370773)\r\n[什么是 JWT -- JSON WEB TOKEN](https://www.jianshu.com/p/576dbf44b2ae)\r\n\r\n\r\n#### 8.3.1 JWT - 介绍\r\n\r\nJWT就是一段字符串，由三段信息构成的，将这三段信息文本用 ` .` 链接一起就构成了Jwt字符串。就像这样：\r\n\r\n```sh\r\neyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\r\n.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9\r\n.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ\r\n```\r\n* 第一部分我们称它为**头部**（header），\r\n* 第二部分我们称其为**载荷**（payload），类似于飞机上承载的物品\r\n* 第三部分是**签证**（signature）。\r\n\r\n##### 8.3.1.1 **头部**（header）\r\n\r\njwt的头部承载两部分信息：\r\n\r\n* 声明类型，这里是jwt\r\n* 声明加密的算法 通常直接使用 HMAC SHA256\r\n\r\n完整的头部就像下面这样的JSON：\r\n\r\n```json\r\n{\r\n  \'typ\': \'JWT\',\r\n  \'alg\': \'HS256\'\r\n}\r\n```\r\n\r\n然后将头部进行base64加密（该加密是可以对称解密的),构成了第一部分.\r\n\r\n```\r\neyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9\r\n```\r\n\r\n##### 8.3.1.2 **载荷**（payload）\r\n\r\n载荷就是存放有效信息的地方。这个名字像是特指飞机上承载的货品，这些有效信息包含三个部分：\r\n* 标准中注册的声明\r\n* 公共的声明\r\n* 私有的声明\r\n\r\n**标准中注册的声明**(建议但不强制使用) ：\r\n* **iss**：jwt签发者；\r\n* **sub**：jwt所面向的用户；\r\n* **aud**：接收jwt的一方；\r\n* **exp**：jwt的过期时间，这个过期时间必须要大于签发时间；\r\n* **nbf**：定义在什么时间之前，该jwt都是不可用的；\r\n* **iat**：jwt的签发时间；\r\n* **jti**：jwt的唯一身份标识，主要用来作为一次性token,从而回避时序攻击；\r\n\r\n**公共的声明**：公共的声明可以添加任何的信息，一般添加用户的相关信息或其他业务需要的必要信息.但不建议添加敏感信息，因为该部分在客户端可解密.\r\n\r\n**私有的声明**：私有声明是提供者和消费者所共同定义的声明，一般不建议存放敏感信息，因为base64是对称解密的，意味着该部分信息可以归类为明文信息。\r\n\r\n定义一个payload:\r\n```json\r\n{\r\n  \"sub\": \"1234567890\",\r\n  \"name\": \"John Doe\",\r\n  \"admin\": true\r\n}\r\n```\r\n然后将其进行base64加密，得到JWT的第二部分。\r\n```json\r\neyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9\r\n```\r\n\r\n##### 8.3.1.3 **签证**（signature）\r\n\r\nJWT的第三部分是一个签证信息，这个签证信息由三部分组成：\r\n* header (base64后的)\r\n* payload (base64后的)\r\n* secret\r\n\r\n这个部分需要base64加密后的header和base64加密后的payload使用 `.` 连接组成的字符串，然后通过`header`中声明的加密方式进行加盐`secret` 组合加密，然后就构成了jwt的第三部分。\r\n\r\n```python\r\n# python 使用base64模块的算法,对数据进行编码转换[可以理解是加密]\r\nimport base64\r\ndata_dict = {\r\n    \"name\":\"xiaoming\"\r\n}\r\ndata_str = str(data_dict)\r\ndata1 = base64.b64encode(data_str)\r\nprint(data1)   # \'eyduYW1lJzogJ3hpYW9taW5nJ30=\'\r\ndata2 = base64.b64decode(data1)\r\nprint(data2)   # \"{\'name\': \'xiaoming\'}\"\r\n```\r\n\r\n>**注意**：secret是保存在服务器端的，jwt的签发生成也是在服务器端的，secret就是用来进行jwt的签发和jwt的验证，所以，它就是你服务端的私钥，在任何场景都不应该流露出去。一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。\r\n\r\n>关于签发和核验JWT，我们可以使用Django REST framework JWT扩展来完成。\r\n>[文档网站](http://jpadilla.github.io/django-rest-framework-jwt/)', '2020-01-19', '2020-01-19', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (15, 'Jeremy', 'git的使用', '## 如何多人协同开发同一个项目？\r\n使用代码版本控制[version control]软件,\r\n目前市面上比较流行的代码版本控制器有: git,svn,csv\r\n\r\n### 1、使用git管理代码版本\r\n本项目使用git管理项目代码，代码库放在gitee码云平台。（注意，公司中通常放在gitlab私有服务器中）\r\n\r\n#### 1.1、Git 的诞生\r\n2005 年 4 月3 日，Git 是目前世界上最先进的分布式版本控制系统（没有之一）\r\n作用：源代码管理\r\n\r\n**为什么要进行源代码管理?**\r\n\r\n* 方便多人协同开发\r\n* 方便版本控制\r\n\r\n#### 1.2、git与svn区别\r\n\r\nSVN 都是集中控制管理的，也就是有一个中央服务器，大家都把代码提交到中央服务器，而 git 是分布式的版本控制工具，也就是说没有中央服务器，每个节点的地位平等。\r\n\r\n**SVN**\r\n![27bece63507237b62bbc1972c584669d.png](en-resource://database/787:1)\r\n\r\n**Git**\r\n![142c985f3b2ab1ac181034f6836c6f82.png](en-resource://database/786:1)\r\n\r\n\r\n>注意:\r\n>    git 的使用分两种不同模式:\r\n>        1. 本地开发管理\r\n>        2. 远程开发管理\r\n\r\nGit工作区、暂存区和版本库\r\n![e2f929ab5359621eecf415f0fdbca546.png](en-resource://database/788:1)\r\n\r\n### 2、工作区介绍\r\n就是在你本要电脑磁盘上能看到的目录。\r\n\r\n\r\n### 2、暂存区介绍\r\n一般存放在【.git】目录下的index文件(.git/index) 中，所以我们把暂存区有时也叫作索引。\r\n\r\n### 3、版本库介绍\r\n工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库。git中的head/master是分支，是版本库。\r\n\r\n**git项目仓库的本地搭建**\r\n```html\r\ncd进入到自己希望存储代码的目录路径，并创建本地仓库.git\r\n新创建的本地仓库.git是个空仓库\r\n\r\n  cd 目录路径\r\n  git init gitdemo  # 如果没有声明目录,则自动把当前目录作为git仓库\r\n```\r\n\r\n创建仓库\r\n![dd1fe21fd7c15e07b317c2815c4b3564.png](en-resource://database/790:1)\r\n\r\n* * *\r\n\r\n**仓库目录的结构**\r\n```bash\r\nbranches/   分支管理目录\r\nconfig      当前项目仓木的配置信息\r\ndescription 当前项目的描述\r\nHEAD        当前项目仓库的当前版本信息\r\nhooks       当前项目仓库的钩子目录[可以利用这个目录下面的文件实现自己拉去代码到服务器]\r\ninfo        仓库相关信息\r\nobjects     仓库版本信息\r\nrefs        引用信息\r\n```\r\n\r\n* * *\r\n\r\n**配置用户名和邮箱**\r\n```bash\r\ngit config --global user.name \'jeremy\'\r\ngit config --global user.email \'865889915@qq.com\'\r\n```\r\n![f72a05976e62de9760ff8884e34b46e0.png](en-resource://database/791:1)\r\n\r\n* * *\r\n\r\n**查看仓库状态**\r\n```bash\r\ngit status\r\n\r\ngit status –s 简约显示\r\n```\r\n\r\n* 红色表示新建文件或者新修改的文件,都在工作区.\r\n* 绿色表示文件在暂存区\r\n* 新建的`login.py`文件在工作区，需要添加到暂存区并提交到仓库区\r\n\r\n![ad28b346075e4738e79b474c4d5ef4bf.png](en-resource://database/789:1)\r\n\r\n上图表示： 暂时没有新文件需要提交到暂存区\r\n\r\n* * *\r\n\r\n**添加文件到暂存区**\r\n```bash\r\n  # 添加项目中所有文件\r\n  git add .\r\n  或者\r\n  # 添加指定文件\r\n  git add login.py\r\n```\r\n例如： 创建3个文件 ，并查看状态.\r\n\r\n* * *\r\n\r\n**提交到版本库**\r\n```bash\r\n git commit -am \"版本描述\"\r\n```\r\n\r\n* * *\r\n\r\n**手动删除文件**\r\n```bash\r\n手动操作删除 或者 在命令行下 使用 rm 文件名 删除 都是表示在工作区删除.\r\n对于这种删除,如果还原,则可以使用 git checkout 文件名\r\n```\r\n![b389bae423da525cfa708d04aa59fd7a.png](en-resource://database/794:1)\r\n\r\n* * *\r\n\r\n**版本删除**\r\n```bash\r\n如果使用 git rm 文件名, 这种操作属于暂存区删除,这种删除无法直接git checkout 文件名 来还原.\r\n如果直接执行git checkout 命令,则报错如下:\r\n```\r\n![5a38f5658fdfb97782184f8aeb3f0618.png](en-resource://database/793:1)\r\n\r\n```bash\r\n如果要还原在暂存区中删除的文件,必须先执行 git reset head\r\n```\r\n![14ea933479afc2006997a5e603dedc4a.png](en-resource://database/792:1)\r\n\r\n* * *\r\n\r\n**查看历史版本[查看日志]**\r\n```bash\r\ngit log   或者   git reflog\r\n \r\n过滤查看日志\r\n  git log –p \r\n  退出按【q】键\r\n  ctrl+f向下分页\r\n  ctrl+b 向上分页\r\n\r\n显示指定日期之后的日志   git log --after  \'2018-11-6\'\r\n显示指定日期之前的日志   git log --before \'2018-11-6\'\r\n\r\n指定显示指定开发者的日志  git log --author \'lisi\'\r\n```\r\n\r\n* * *\r\n\r\n**回退版本**\r\n* * *\r\n* **方案一：**\r\n    * `HEAD`表示当前最新版本\r\n    * `HEAD^`表示当前最新版本的前一个版本\r\n    * `HEAD^^`表示当前最新版本的前两个版本，以此类推...\r\n    * `HEAD~1`表示当前最新版本的前一个版本\r\n    * `HEAD~10`表示当前最新版本的前10个版本，以此类推...\r\n\r\n```bash\r\ngit reset --hard HEAD^\r\n```\r\n\r\n* * *\r\n\r\n* **方案二：当版本非常多时可选择的方案**\r\n    * 通过每个版本的版本号回退到指定版本\r\n    \r\n```bash\r\ngit reset --hard 版本号\r\n```\r\n***\r\n**取消暂存**\r\n***\r\n```bash\r\ngit reset head\r\ngit reset <file> ：从暂存区恢复到工作文件\r\ngit reset -- ：从暂存区恢复到工作文件\r\n```\r\n\r\n* * *\r\n\r\n### 查看文件状态\r\n\r\n**针对与文件所处的不同分区，文件所处的状态:**\r\n* (1)未追踪, 文件第一次出现在工作区, 版本库还没有存储该文件的状态\r\n* (2)已追踪, 只要第一次,git add了文件, 文件就是已追踪\r\n* (3)未修改, 文件在工作区未被编辑\r\n* (4)已修改, 文件在工作区被修改\r\n* (5)未暂存, 文件已修改, 但是没有add到暂存区\r\n* (6)已暂存, 已经将修改的文件add到暂存区\r\n* (7)未提交, 已暂存的文件, 没有commit提交. 处于暂存区\r\n* (8)已提交, 提交到版本库的文件修改,只有commit以后才会有仓库的版本号生成\r\n\r\n* * *\r\n\r\n**注意：**\r\n\r\n### 2、在gitee平台创建工程\r\n\r\n#### 1） 创建私有项目库 \r\n\r\n#### 2）克隆项目到本地\r\n```bash\r\ngit clone 仓库地址\r\n注意，如果当前目录下出现git仓库同名目录时，会克隆失败。\r\n```\r\n![0919c1f81ac3149e69ad8c483eef7d1f.png](en-resource://database/795:1)\r\n\r\n#### 3）创建并切换分支到dev\r\n```bash\r\n# git branch dev      # 创建本地分支dev,dev是自定义\r\n# git checkout dev    # 切换本地分支代码\r\ngit checkout -b dev   # 这里是上面两句代码的简写\r\n```\r\n\r\n**git提交**\r\n```bash\r\ngit add 代码目录\r\ngit status\r\ngit commit -m \'添加项目代码\'\r\n```\r\n\r\n**推送到远端**\r\n```bash\r\ngit push origin dev:dev\r\n```\r\n\r\n**如果推送代码,出现以下提示: git pull ....,则表示当前本地的代码和线上的代码版本不同.**\r\n```bash\r\n1. 把线上的代码执行以下命令,拉取到本地,进行同步\r\ngit pull\r\n\r\n2. 根据提示,移除多余的冲突的文件,也可以删除.\r\n完成这些步骤以后,再次add,commit,push即可.\r\n```', '2020-01-19', '2020-01-19', 'p', 0, 1, 1);

-- ----------------------------
-- Table structure for article_articlepost_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_articlepost_tags`;
CREATE TABLE `article_articlepost_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articlepost_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `article_articlepost_tags_articlepost_id_tags_id_9b9e31f0_uniq`(`articlepost_id`, `tags_id`) USING BTREE,
  INDEX `article_articlepost_tags_tags_id_98ce6882_fk_article_tags_id`(`tags_id`) USING BTREE,
  CONSTRAINT `article_articlepost__articlepost_id_ec19821a_fk_article_a` FOREIGN KEY (`articlepost_id`) REFERENCES `article_articlepost` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_articlepost_tags_tags_id_98ce6882_fk_article_tags_id` FOREIGN KEY (`tags_id`) REFERENCES `article_tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_articlepost_tags
-- ----------------------------
INSERT INTO `article_articlepost_tags` VALUES (1, 1, 1);
INSERT INTO `article_articlepost_tags` VALUES (2, 2, 1);
INSERT INTO `article_articlepost_tags` VALUES (3, 2, 2);
INSERT INTO `article_articlepost_tags` VALUES (4, 2, 3);
INSERT INTO `article_articlepost_tags` VALUES (5, 3, 1);
INSERT INTO `article_articlepost_tags` VALUES (6, 4, 1);
INSERT INTO `article_articlepost_tags` VALUES (7, 5, 1);
INSERT INTO `article_articlepost_tags` VALUES (8, 5, 3);
INSERT INTO `article_articlepost_tags` VALUES (9, 7, 3);
INSERT INTO `article_articlepost_tags` VALUES (10, 8, 2);
INSERT INTO `article_articlepost_tags` VALUES (11, 9, 2);
INSERT INTO `article_articlepost_tags` VALUES (13, 11, 1);
INSERT INTO `article_articlepost_tags` VALUES (12, 12, 1);
INSERT INTO `article_articlepost_tags` VALUES (14, 15, 1);

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_category
-- ----------------------------
INSERT INTO `article_category` VALUES (1, 'Python');

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tags
-- ----------------------------
INSERT INTO `article_tags` VALUES (1, 'tags1');
INSERT INTO `article_tags` VALUES (2, 'tags2');
INSERT INTO `article_tags` VALUES (3, 'tags3');

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 'add_logentry', 1);
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 'change_logentry', 1);
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 'delete_logentry', 1);
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 'view_logentry', 1);
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 'add_permission', 2);
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 'change_permission', 2);
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 'delete_permission', 2);
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 'view_permission', 2);
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 'add_group', 3);
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 'change_group', 3);
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 'delete_group', 3);
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 'view_group', 3);
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 'add_user', 4);
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 'change_user', 4);
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 'delete_user', 4);
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 'view_user', 4);
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 'add_contenttype', 5);
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 'change_contenttype', 5);
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 'delete_contenttype', 5);
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 'view_contenttype', 5);
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 'add_session', 6);
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 'change_session', 6);
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 'delete_session', 6);
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 'view_session', 6);
INSERT INTO `auth_permission` VALUES (25, 'Can add Bookmark', 'add_bookmark', 7);
INSERT INTO `auth_permission` VALUES (26, 'Can change Bookmark', 'change_bookmark', 7);
INSERT INTO `auth_permission` VALUES (27, 'Can delete Bookmark', 'delete_bookmark', 7);
INSERT INTO `auth_permission` VALUES (28, 'Can view Bookmark', 'view_bookmark', 7);
INSERT INTO `auth_permission` VALUES (29, 'Can add User Setting', 'add_usersettings', 8);
INSERT INTO `auth_permission` VALUES (30, 'Can change User Setting', 'change_usersettings', 8);
INSERT INTO `auth_permission` VALUES (31, 'Can delete User Setting', 'delete_usersettings', 8);
INSERT INTO `auth_permission` VALUES (32, 'Can view User Setting', 'view_usersettings', 8);
INSERT INTO `auth_permission` VALUES (33, 'Can add User Widget', 'add_userwidget', 9);
INSERT INTO `auth_permission` VALUES (34, 'Can change User Widget', 'change_userwidget', 9);
INSERT INTO `auth_permission` VALUES (35, 'Can delete User Widget', 'delete_userwidget', 9);
INSERT INTO `auth_permission` VALUES (36, 'Can view User Widget', 'view_userwidget', 9);
INSERT INTO `auth_permission` VALUES (37, 'Can add log entry', 'add_log', 10);
INSERT INTO `auth_permission` VALUES (38, 'Can change log entry', 'change_log', 10);
INSERT INTO `auth_permission` VALUES (39, 'Can delete log entry', 'delete_log', 10);
INSERT INTO `auth_permission` VALUES (40, 'Can view log entry', 'view_log', 10);
INSERT INTO `auth_permission` VALUES (41, 'Can add revision', 'add_revision', 11);
INSERT INTO `auth_permission` VALUES (42, 'Can change revision', 'change_revision', 11);
INSERT INTO `auth_permission` VALUES (43, 'Can delete revision', 'delete_revision', 11);
INSERT INTO `auth_permission` VALUES (44, 'Can view revision', 'view_revision', 11);
INSERT INTO `auth_permission` VALUES (45, 'Can add version', 'add_version', 12);
INSERT INTO `auth_permission` VALUES (46, 'Can change version', 'change_version', 12);
INSERT INTO `auth_permission` VALUES (47, 'Can delete version', 'delete_version', 12);
INSERT INTO `auth_permission` VALUES (48, 'Can view version', 'view_version', 12);
INSERT INTO `auth_permission` VALUES (49, 'Can add 分类信息', 'add_category', 13);
INSERT INTO `auth_permission` VALUES (50, 'Can change 分类信息', 'change_category', 13);
INSERT INTO `auth_permission` VALUES (51, 'Can delete 分类信息', 'delete_category', 13);
INSERT INTO `auth_permission` VALUES (52, 'Can view 分类信息', 'view_category', 13);
INSERT INTO `auth_permission` VALUES (53, 'Can add tags', 'add_tags', 14);
INSERT INTO `auth_permission` VALUES (54, 'Can change tags', 'change_tags', 14);
INSERT INTO `auth_permission` VALUES (55, 'Can delete tags', 'delete_tags', 14);
INSERT INTO `auth_permission` VALUES (56, 'Can view tags', 'view_tags', 14);
INSERT INTO `auth_permission` VALUES (57, 'Can add 文章列表', 'add_articlepost', 15);
INSERT INTO `auth_permission` VALUES (58, 'Can change 文章列表', 'change_articlepost', 15);
INSERT INTO `auth_permission` VALUES (59, 'Can delete 文章列表', 'delete_articlepost', 15);
INSERT INTO `auth_permission` VALUES (60, 'Can view 文章列表', 'view_articlepost', 15);

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$150000$JDgcvscW3u2w$C02C979k7Vkifj3EPkTMTfmECyNdkomk3HCoBN6PEPA=', '2020-01-17 07:58:00.000000', 1, 'jeremy', '', '', '865889915@qq.com', 1, 1, '2020-01-17 07:57:00.000000');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
INSERT INTO `auth_user_user_permissions` VALUES (1, 1, 1);
INSERT INTO `auth_user_user_permissions` VALUES (2, 1, 2);
INSERT INTO `auth_user_user_permissions` VALUES (3, 1, 3);
INSERT INTO `auth_user_user_permissions` VALUES (4, 1, 4);
INSERT INTO `auth_user_user_permissions` VALUES (5, 1, 5);
INSERT INTO `auth_user_user_permissions` VALUES (6, 1, 6);
INSERT INTO `auth_user_user_permissions` VALUES (7, 1, 7);
INSERT INTO `auth_user_user_permissions` VALUES (8, 1, 8);
INSERT INTO `auth_user_user_permissions` VALUES (9, 1, 9);
INSERT INTO `auth_user_user_permissions` VALUES (10, 1, 10);
INSERT INTO `auth_user_user_permissions` VALUES (11, 1, 11);
INSERT INTO `auth_user_user_permissions` VALUES (12, 1, 12);
INSERT INTO `auth_user_user_permissions` VALUES (13, 1, 13);
INSERT INTO `auth_user_user_permissions` VALUES (14, 1, 14);
INSERT INTO `auth_user_user_permissions` VALUES (15, 1, 15);
INSERT INTO `auth_user_user_permissions` VALUES (16, 1, 16);
INSERT INTO `auth_user_user_permissions` VALUES (17, 1, 17);
INSERT INTO `auth_user_user_permissions` VALUES (18, 1, 18);
INSERT INTO `auth_user_user_permissions` VALUES (19, 1, 19);
INSERT INTO `auth_user_user_permissions` VALUES (20, 1, 20);
INSERT INTO `auth_user_user_permissions` VALUES (21, 1, 21);
INSERT INTO `auth_user_user_permissions` VALUES (22, 1, 22);
INSERT INTO `auth_user_user_permissions` VALUES (23, 1, 23);
INSERT INTO `auth_user_user_permissions` VALUES (24, 1, 24);
INSERT INTO `auth_user_user_permissions` VALUES (25, 1, 25);
INSERT INTO `auth_user_user_permissions` VALUES (26, 1, 26);
INSERT INTO `auth_user_user_permissions` VALUES (27, 1, 27);
INSERT INTO `auth_user_user_permissions` VALUES (28, 1, 28);
INSERT INTO `auth_user_user_permissions` VALUES (29, 1, 29);
INSERT INTO `auth_user_user_permissions` VALUES (30, 1, 30);
INSERT INTO `auth_user_user_permissions` VALUES (31, 1, 31);
INSERT INTO `auth_user_user_permissions` VALUES (32, 1, 32);
INSERT INTO `auth_user_user_permissions` VALUES (33, 1, 33);
INSERT INTO `auth_user_user_permissions` VALUES (34, 1, 34);
INSERT INTO `auth_user_user_permissions` VALUES (35, 1, 35);
INSERT INTO `auth_user_user_permissions` VALUES (36, 1, 36);
INSERT INTO `auth_user_user_permissions` VALUES (37, 1, 37);
INSERT INTO `auth_user_user_permissions` VALUES (38, 1, 38);
INSERT INTO `auth_user_user_permissions` VALUES (39, 1, 39);
INSERT INTO `auth_user_user_permissions` VALUES (40, 1, 40);
INSERT INTO `auth_user_user_permissions` VALUES (41, 1, 41);
INSERT INTO `auth_user_user_permissions` VALUES (42, 1, 42);
INSERT INTO `auth_user_user_permissions` VALUES (43, 1, 43);
INSERT INTO `auth_user_user_permissions` VALUES (44, 1, 44);
INSERT INTO `auth_user_user_permissions` VALUES (45, 1, 45);
INSERT INTO `auth_user_user_permissions` VALUES (46, 1, 46);
INSERT INTO `auth_user_user_permissions` VALUES (47, 1, 47);
INSERT INTO `auth_user_user_permissions` VALUES (48, 1, 48);
INSERT INTO `auth_user_user_permissions` VALUES (49, 1, 49);
INSERT INTO `auth_user_user_permissions` VALUES (50, 1, 50);
INSERT INTO `auth_user_user_permissions` VALUES (51, 1, 51);
INSERT INTO `auth_user_user_permissions` VALUES (52, 1, 52);
INSERT INTO `auth_user_user_permissions` VALUES (53, 1, 53);
INSERT INTO `auth_user_user_permissions` VALUES (54, 1, 54);
INSERT INTO `auth_user_user_permissions` VALUES (55, 1, 55);
INSERT INTO `auth_user_user_permissions` VALUES (56, 1, 56);
INSERT INTO `auth_user_user_permissions` VALUES (57, 1, 57);
INSERT INTO `auth_user_user_permissions` VALUES (58, 1, 58);
INSERT INTO `auth_user_user_permissions` VALUES (59, 1, 59);
INSERT INTO `auth_user_user_permissions` VALUES (60, 1, 60);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (15, 'article', 'articlepost');
INSERT INTO `django_content_type` VALUES (13, 'article', 'category');
INSERT INTO `django_content_type` VALUES (14, 'article', 'tags');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (11, 'reversion', 'revision');
INSERT INTO `django_content_type` VALUES (12, 'reversion', 'version');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'xadmin', 'bookmark');
INSERT INTO `django_content_type` VALUES (10, 'xadmin', 'log');
INSERT INTO `django_content_type` VALUES (8, 'xadmin', 'usersettings');
INSERT INTO `django_content_type` VALUES (9, 'xadmin', 'userwidget');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-01-17 07:56:52.185781');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2020-01-17 07:56:52.551978');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2020-01-17 07:56:53.891898');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0001_initial', '2020-01-17 07:56:55.178856');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0002_logentry_user', '2020-01-17 07:56:55.493945');
INSERT INTO `django_migrations` VALUES (6, 'article', '0001_initial', '2020-01-17 07:56:56.561191');
INSERT INTO `django_migrations` VALUES (7, 'reversion', '0001_squashed_0004_auto_20160611_1202', '2020-01-17 07:56:57.608761');
INSERT INTO `django_migrations` VALUES (8, 'sessions', '0001_initial', '2020-01-17 07:56:58.279517');
INSERT INTO `django_migrations` VALUES (9, 'xadmin', '0001_initial', '2020-01-17 07:56:59.154178');
INSERT INTO `django_migrations` VALUES (10, 'xadmin', '0002_log', '2020-01-17 07:57:00.029490');
INSERT INTO `django_migrations` VALUES (11, 'xadmin', '0003_auto_20160715_0100', '2020-01-17 07:57:00.406911');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('kztmoegavvfu1awof6rexggm50l5smq1', 'MWFjNmYxYzcyMjEyMzVlMDY5M2EyNDM0YTE3NzUzOWQ1MThlYThmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==', '2020-02-02 13:26:05.138528');

-- ----------------------------
-- Table structure for reversion_revision
-- ----------------------------
DROP TABLE IF EXISTS `reversion_revision`;
CREATE TABLE `reversion_revision`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reversion_revision_user_id_17095f45_fk_auth_user_id`(`user_id`) USING BTREE,
  INDEX `reversion_revision_date_created_96f7c20c`(`date_created`) USING BTREE,
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reversion_version
-- ----------------------------
DROP TABLE IF EXISTS `reversion_version`;
CREATE TABLE `reversion_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `serialized_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `object_repr` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `reversion_version_db_content_type_id_objec_b2c54f65_uniq`(`db`, `content_type_id`, `object_id`, `revision_id`) USING BTREE,
  INDEX `reversion_version_content_type_id_7d0ff25c_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id`(`revision_id`) USING BTREE,
  CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xadmin_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_bookmark`;
CREATE TABLE `xadmin_bookmark`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `query` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `xadmin_bookmark_content_type_id_60941679_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xadmin_log
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_log`;
CREATE TABLE `xadmin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL,
  `ip_addr` char(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id`(`content_type_id`) USING BTREE,
  INDEX `xadmin_log_user_id_bb16a176_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xadmin_log
-- ----------------------------
INSERT INTO `xadmin_log` VALUES (1, '2020-01-17 07:58:44.756513', '192.168.5.44', '1', 'Python', 'create', '已添加。', 13, 1);
INSERT INTO `xadmin_log` VALUES (2, '2020-01-17 07:59:52.619128', '192.168.5.44', '1', '测试篇', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (3, '2020-01-17 08:00:35.982821', '192.168.5.44', '1', '测试篇', 'change', '没有字段被修改。', 15, 1);
INSERT INTO `xadmin_log` VALUES (4, '2020-01-17 08:03:24.589688', '192.168.5.44', '1', 'tags1', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (5, '2020-01-17 08:03:33.226048', '192.168.5.44', '2', 'tags2', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (6, '2020-01-17 08:03:42.866154', '192.168.5.44', '3', 'tags3', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (7, '2020-01-17 08:04:05.716918', '192.168.5.44', '1', '测试篇1', 'change', '修改 title 和 tags', 15, 1);
INSERT INTO `xadmin_log` VALUES (8, '2020-01-17 08:04:29.821339', '192.168.5.44', '2', '测试篇2', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (9, '2020-01-17 08:04:51.741819', '192.168.5.44', '1', '测试篇1', 'change', '修改 topped', 15, 1);
INSERT INTO `xadmin_log` VALUES (10, '2020-01-17 08:05:33.293865', '192.168.5.44', '1', 'jeremy', 'change', '修改 last_login 和 user_permissions', 4, 1);
INSERT INTO `xadmin_log` VALUES (11, '2020-01-17 08:05:47.107905', '192.168.5.44', '1', 'jeremy', 'change', '没有字段被修改。', 4, 1);
INSERT INTO `xadmin_log` VALUES (12, '2020-01-17 09:33:14.230037', '192.168.5.44', '3', '测试篇3', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (13, '2020-01-17 09:33:28.550317', '192.168.5.44', '4', '测试篇4', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (14, '2020-01-17 09:33:46.968656', '192.168.5.44', '5', '测试篇5', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (15, '2020-01-17 09:34:01.382785', '192.168.5.44', '6', '测试篇6', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (16, '2020-01-17 09:34:21.003006', '192.168.5.44', '7', '测试篇7', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (17, '2020-01-17 09:34:36.898515', '192.168.5.44', '8', '测试篇8', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (18, '2020-01-17 09:34:52.855171', '192.168.5.44', '9', '测试篇9', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (19, '2020-01-17 09:35:11.814729', '192.168.5.44', '10', '测试篇10', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (20, '2020-01-17 09:35:25.427807', '192.168.5.44', '11', '测试篇11', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (21, '2020-01-18 02:03:11.204033', '192.168.5.44', '10', '测试篇10', 'change', '修改 topped', 15, 1);
INSERT INTO `xadmin_log` VALUES (22, '2020-01-18 02:07:19.430692', '192.168.5.44', '12', '测试篇12', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (23, '2020-01-19 01:18:18.426842', '192.168.5.44', '11', '测试篇11', 'change', '修改 tags', 15, 1);
INSERT INTO `xadmin_log` VALUES (24, '2020-01-19 01:18:40.304039', '192.168.5.44', '13', '测试篇13', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (25, '2020-01-19 01:18:41.757602', '192.168.5.44', '14', '测试篇13', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (26, '2020-01-19 01:18:53.714002', '192.168.5.44', NULL, '', 'delete', '批量删除 1 个 文章列表', NULL, 1);
INSERT INTO `xadmin_log` VALUES (27, '2020-01-19 02:12:23.992097', '192.168.5.44', '13', '测试篇13', 'change', '修改 status', 15, 1);
INSERT INTO `xadmin_log` VALUES (28, '2020-01-19 02:16:56.876197', '192.168.5.44', '4', '测试篇4', 'change', '修改 topped', 15, 1);
INSERT INTO `xadmin_log` VALUES (29, '2020-01-19 03:44:02.057272', '192.168.5.44', '15', 'git的使用', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (30, '2020-01-19 06:44:45.794804', '192.168.5.44', '13', '测试篇13', 'change', '修改 body 和 status', 15, 1);
INSERT INTO `xadmin_log` VALUES (31, '2020-01-19 06:44:57.162109', '192.168.5.44', '15', 'git的使用', 'change', '修改 status', 15, 1);
INSERT INTO `xadmin_log` VALUES (32, '2020-01-19 06:46:15.331057', '192.168.5.44', '15', 'git的使用', 'change', '修改 status', 15, 1);
INSERT INTO `xadmin_log` VALUES (33, '2020-01-19 10:09:37.283921', '192.168.5.44', '12', '测试篇12', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (34, '2020-01-19 12:52:53.430838', '192.168.5.44', '12', '测试篇12', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (35, '2020-01-19 12:53:02.707476', '192.168.5.44', '13', '测试篇13', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (36, '2020-01-19 13:05:29.185300', '192.168.5.44', '15', 'git的使用', 'change', '修改 body', 15, 1);

-- ----------------------------
-- Table structure for xadmin_usersettings
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_usersettings`;
CREATE TABLE `xadmin_usersettings`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xadmin_usersettings
-- ----------------------------
INSERT INTO `xadmin_usersettings` VALUES (1, 'dashboard:home:pos', '', 1);

-- ----------------------------
-- Table structure for xadmin_userwidget
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_userwidget`;
CREATE TABLE `xadmin_userwidget`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `widget_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `xadmin_userwidget_user_id_c159233a_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
