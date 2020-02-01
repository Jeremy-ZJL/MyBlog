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

 Date: 01/02/2020 13:24:05
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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_articlepost
-- ----------------------------
INSERT INTO `article_articlepost` VALUES (17, 'Jeremy', 'Anaconda和Miniconda的使用', '# Anaconda和Miniconda的使用\r\n\r\n## 1. 简介\r\n\r\n在学习Python的时候，必然需要安装各种相关的库，这个时候强烈推荐使用Anaconda来管理虚拟环境和安装相关的库。\r\n\r\n> 当初学习Python的时候，使用虚拟环境是挺麻烦的，后来了解到Anaconda，就试着使用它；\r\n> 想当初我学Anaconda真的是懵，一个工具咋那么大，装上我还不会使用，那时候还不是特别懂Python的虚拟环境，使用Anaconda是一脸懵。。。\r\n\r\n- conda是一个开源包管理系统和环境管理系统，用于安装多个版本的软件包及其依赖关系，并在它们之间轻松切换。 它适用于Linux，OS X和Windows，是为Python程序创建的，但可以打包和分发任何软件；\r\n\r\n- Anaconda：是一个开源的Python发行版本，包含了conda、python等180多个科学包及其依赖项。因为包含了大量的科学包，所以Anaconda的安装包比较大；\r\n\r\n- Miniconda：顾名思义，它只包含最基本的内容————python&conda，以及相关的必须依赖项，对于空间要求严格的用户，Miniconda是一种选择。\r\n\r\n\r\n## 2. Anaconda\r\n\r\n官网：https://www.anaconda.com/\r\n\r\n![](/media/editor/anaconda_20200130222231914753.png)\r\n\r\nAnaconda的英文解释是产于南美洲的水蟒，这个Python的大蟒蛇是一个物种不同品种。\r\n\r\nAnaconda是一个开源的Python发行版本，支持 Linux, Mac, Windows，包含了Python核心、`conda`、`Numpy`、`Pandas`、`matplotlib`等180多个科学包及其依赖项，这让你不再为了各种依赖关系的缺失，头疼无法成功安装某个库。因为包含了大量的科学包，Anaconda的下载文件也比较大（几百MB），如果只需要其中的某些包，或者需要节省带宽或存储空间，也可以使用`Miniconda`这个较小的发行版（仅包含conda和Python）。\r\n\r\n### 2.1 安装\r\n\r\n#### 2.1.1 下载安装包\r\n\r\n由于Anaconda是跨平台的，并且支持Python2.7和Python3.x，所以在官网的下载页面，有如下可选安装包：\r\n\r\n下载链接：https://www.anaconda.com/distribution/\r\n\r\n![](/media/editor/anaconda-下载地址_20200130225632584649.png)\r\n\r\n除了官网可以下载外，还可以在清华的镜像站点下载：\r\nhttps://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/\r\n\r\n清华站点还提供了conda安装包的镜像地址，只需要如下设置：\r\n```bash\r\nconda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/\r\nconda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/\r\nconda config --set show_channel_urls yes  # 显示添加的源\r\n```\r\n\r\n#### 2.1.2 Windows安装\r\n\r\n- 第一个选项决定是否将Anaconda加入系统路径环境变量里，这涉及到能否直接在cmd中使用conda、jupyter、ipython等命令，建议选上。\r\n\r\n- 第二个选项决定是否将Anaconda版本的解释器作为系统的Python解释器。如果你在机器中还安装了别的比如官方版本的Python解释器，建议不要选择这项，否则容易冲突。\r\n\r\n整个安装过程很简洁明了，没什么太多需要解释的\r\n\r\n#### 2.1.2 Linux安装\r\n\r\n```bash\r\nbash Anaconda3-4.3.1-Linux-x86.sh\r\n```\r\n\r\n## 3. 使用\r\n\r\n### 3.1 添加源\r\n```bash\r\nconda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/\r\nconda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/\r\n（想要删除清华源把add改成remove就行。）\r\n\r\n# 显示添加的源\r\nconda config --set show_channel_urls yes\r\n```\r\n\r\n### 3.2 常用命令\r\n```bash\r\n# 查看当前环境下已安装的包\r\nconda list\r\n\r\n# 列出所有环境\r\nconda env list\r\n\r\n# 查看某个指定环境的已安装包\r\nconda list -n python34\r\n\r\n# 查看所有安装的python环境\r\nconda info -e\r\n\r\n# 删除该环境\r\nconda env remove  -n test\r\n\r\n# 查找package信息\r\nconda search numpy\r\n\r\n# 安装package\r\nconda install -n python34 numpy\r\n# 如果不用-n指定环境名称，则被安装在当前活跃环境\r\n# 也可以通过-c指定通过某个channel安装\r\n\r\n# 更新package\r\nconda update -n python34 numpy\r\n\r\n# 删除package\r\nconda remove -n python34 numpy\r\n\r\n# 直接将现有的anaconda中python更改为3.6.5\r\nconda install python=3.6.5\r\n```\r\n\r\n### 3.3 更新\r\n```bash\r\n# 更新conda，保持conda最新\r\nconda update conda\r\n\r\n# 更新anaconda\r\nconda update anaconda\r\n\r\n# 更新所有软件包\r\nconda upgrade --all\r\n\r\n# 更新python\r\n# 假设当前环境是python 3.4, conda会将python升级为3.4.x系列的当前最新版本\r\nconda update python\r\n```\r\n\r\n### 3.4 管理虚拟环境\r\n```bash\r\n# 创建虚拟环境\r\nconda create -n python36 python=3.6.5\r\n\r\n# 激活虚拟环境\r\nLinux:  conda activate your_env_name(虚拟环境名称)\r\nWindows: activate your_env_name(虚拟环境名称)\r\n\r\n# 退出虚拟环境\r\nLinux:  source deactivate\r\nWindows: deactivate\r\n```\r\n\r\n### 3.5 导出导入环境\r\n```bash\r\n# 导出\r\n> 当分享代码给别人的时候，同时也需要将运行环境分享，执行如下命令可以将当前环境下的package信息存入名为environment的YAML文件中。\r\nconda env export --name env_name > environment.yaml\r\nconda env export > env.yaml\r\nconda-env export > env.yaml\r\n\r\n# 导入\r\n> 同样，当执行他人的代码时，也需要配置相应的环境。这时你可以用对方分享的YAML文件来创建一摸一样的运行环境。\r\nconda env create -f env.yaml\r\nconda-env create -f env.yaml\r\n```\r\n\r\n### 3.6 克隆/删除环境\r\n```bash\r\n# 克隆环境：\r\nconda create --name $new_env_name --clone $old_env_name\r\n\r\n# 删除环境：\r\nconda remove --name $env_name --all\r\n```', '2020-01-30', '2020-01-30', 'p', 0, 0, 1);
INSERT INTO `article_articlepost` VALUES (18, 'Jeremy', 'LVS 原理介绍', '# LVS原理介绍\r\n\r\n> LVS是什么?我们先来了解一下LVS是个什么东西:trollface:\r\n\r\n**LVS**，全称`Linux Virtual Server`，是国人章文嵩发起的一个开源项目。在社区具有很大的热度，是一个基于四层、具有强大性能的反向代理服务器。`早期使用lvs需要修改内核才能使用，但是由于性能优异，现在已经被收入内核`。\r\n\r\n**LVS**通过工作于内核的ipvs模块来实现功能，其主要工作于`netfilter`的`INPUT链`上。而用户需要对`ipvs`进行操作配置则需要使用`ipvsadm`这个工具。`ipvsadm`主要用于设置lvs模型、调度方式以及指定后端主机。', '2020-02-01', '2020-02-01', 'd', 0, 0, 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_articlepost_tags
-- ----------------------------
INSERT INTO `article_articlepost_tags` VALUES (16, 17, 6);
INSERT INTO `article_articlepost_tags` VALUES (17, 18, 7);

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_category
-- ----------------------------
INSERT INTO `article_category` VALUES (1, 'Python');
INSERT INTO `article_category` VALUES (2, 'Linux');
INSERT INTO `article_category` VALUES (3, 'Django');

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tags
-- ----------------------------
INSERT INTO `article_tags` VALUES (4, 'python基础');
INSERT INTO `article_tags` VALUES (6, 'Python开发工具');
INSERT INTO `article_tags` VALUES (7, 'Linux运维');

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
  `date_joined` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$150000$JDgcvscW3u2w$C02C979k7Vkifj3EPkTMTfmECyNdkomk3HCoBN6PEPA=', '2020-01-30 13:54:48.943161', 1, 'jeremy', '', '', '865889915@qq.com', 1, 1, '2020-01-17 07:57:00.000000');

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
  `action_time` datetime(6) NULL DEFAULT NULL,
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
  `applied` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `django_migrations` VALUES (12, 'article', '0002_auto_20200123_1135', '2020-01-23 03:36:06.233304');
INSERT INTO `django_migrations` VALUES (13, 'article', '0002_auto_20200130_2055', '2020-01-30 12:55:41.269344');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('8jnzwjh42ttv77csdrckrhnxcgqtf2gg', 'MWFjNmYxYzcyMjEyMzVlMDY5M2EyNDM0YTE3NzUzOWQ1MThlYThmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==', '2020-02-15 03:46:18.407637');
INSERT INTO `django_session` VALUES ('kztmoegavvfu1awof6rexggm50l5smq1', 'MWFjNmYxYzcyMjEyMzVlMDY5M2EyNDM0YTE3NzUzOWQ1MThlYThmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==', '2020-02-02 13:26:05.138528');
INSERT INTO `django_session` VALUES ('xtrmfnhtcyxe7tloqcm7une5ot0lbxmp', 'YmM1MzNmNzE5YTI0YjEwM2Y2YzU3YTlmODEwZDM0N2FmOWNmYjg1MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhM2U5MTM5MGE1ZTNlNzZhNjZlMDU4MGYwMGQzMjU2OWI0ZTg4ZDFjIiwibmF2X21lbnUiOiJbe1widGl0bGVcIjogXCJSZXZlcnNpb25cIiwgXCJtZW51c1wiOiBbe1widGl0bGVcIjogXCJSZXZpc2lvbnNcIiwgXCJ1cmxcIjogXCIveGFkbWluL3JldmVyc2lvbi9yZXZpc2lvbi9cIiwgXCJpY29uXCI6IFwiZmEgZmEtZXhjaGFuZ2VcIiwgXCJvcmRlclwiOiAxMH1dLCBcImZpcnN0X2ljb25cIjogXCJmYSBmYS1leGNoYW5nZVwiLCBcImZpcnN0X3VybFwiOiBcIi94YWRtaW4vcmV2ZXJzaW9uL3JldmlzaW9uL1wifSwge1widGl0bGVcIjogXCJcdTY1ODdcdTdhZTBcdTdiYTFcdTc0MDZcIiwgXCJtZW51c1wiOiBbe1widGl0bGVcIjogXCJcdTY1ODdcdTdhZTBcdTUyMTdcdTg4NjhcIiwgXCJ1cmxcIjogXCIveGFkbWluL2FydGljbGUvYXJ0aWNsZXBvc3QvXCIsIFwiaWNvblwiOiBudWxsLCBcIm9yZGVyXCI6IDd9LCB7XCJ0aXRsZVwiOiBcIlx1NTIwNlx1N2M3YlwiLCBcInVybFwiOiBcIi94YWRtaW4vYXJ0aWNsZS9jYXRlZ29yeS9cIiwgXCJpY29uXCI6IG51bGwsIFwib3JkZXJcIjogOH0sIHtcInRpdGxlXCI6IFwiXHU2ODA3XHU3YjdlXCIsIFwidXJsXCI6IFwiL3hhZG1pbi9hcnRpY2xlL3RhZ3MvXCIsIFwiaWNvblwiOiBudWxsLCBcIm9yZGVyXCI6IDl9XSwgXCJmaXJzdF91cmxcIjogXCIveGFkbWluL2FydGljbGUvYXJ0aWNsZXBvc3QvXCJ9LCB7XCJ0aXRsZVwiOiBcIlx1N2JhMVx1NzQwNlwiLCBcIm1lbnVzXCI6IFt7XCJ0aXRsZVwiOiBcIlx1NjVlNVx1NWZkN1x1OGJiMFx1NWY1NVwiLCBcInVybFwiOiBcIi94YWRtaW4veGFkbWluL2xvZy9cIiwgXCJpY29uXCI6IFwiZmEgZmEtY29nXCIsIFwib3JkZXJcIjogNn1dLCBcImZpcnN0X2ljb25cIjogXCJmYSBmYS1jb2dcIiwgXCJmaXJzdF91cmxcIjogXCIveGFkbWluL3hhZG1pbi9sb2cvXCJ9LCB7XCJ0aXRsZVwiOiBcIlx1OGJhNFx1OGJjMVx1NTQ4Y1x1NjM4OFx1Njc0M1wiLCBcIm1lbnVzXCI6IFt7XCJ0aXRsZVwiOiBcIlx1N2VjNFwiLCBcInVybFwiOiBcIi94YWRtaW4vYXV0aC9ncm91cC9cIiwgXCJpY29uXCI6IFwiZmEgZmEtZ3JvdXBcIiwgXCJvcmRlclwiOiAyfSwge1widGl0bGVcIjogXCJcdTc1MjhcdTYyMzdcIiwgXCJ1cmxcIjogXCIveGFkbWluL2F1dGgvdXNlci9cIiwgXCJpY29uXCI6IFwiZmEgZmEtdXNlclwiLCBcIm9yZGVyXCI6IDN9LCB7XCJ0aXRsZVwiOiBcIlx1Njc0M1x1OTY1MFwiLCBcInVybFwiOiBcIi94YWRtaW4vYXV0aC9wZXJtaXNzaW9uL1wiLCBcImljb25cIjogXCJmYSBmYS1sb2NrXCIsIFwib3JkZXJcIjogNH1dLCBcImZpcnN0X2ljb25cIjogXCJmYSBmYS1ncm91cFwiLCBcImZpcnN0X3VybFwiOiBcIi94YWRtaW4vYXV0aC9ncm91cC9cIn1dIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGVwb3N0Il0sIiJdfQ==', '2020-02-15 03:43:50.859077');

-- ----------------------------
-- Table structure for reversion_revision
-- ----------------------------
DROP TABLE IF EXISTS `reversion_revision`;
CREATE TABLE `reversion_revision`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NULL DEFAULT NULL,
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
  `action_time` datetime(6) NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `xadmin_log` VALUES (37, '2020-01-21 08:44:59.429512', '219.132.138.58', '4', 'python基础', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (38, '2020-01-23 06:54:42.750238', '127.0.0.1', '7', '测试篇7', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (39, '2020-01-23 07:02:08.800862', '127.0.0.1', '15', 'git的使用', 'change', '没有字段被修改。', 15, 1);
INSERT INTO `xadmin_log` VALUES (40, '2020-01-23 07:41:43.125088', '127.0.0.1', '12', '测试篇12', 'change', '没有字段被修改。', 15, 1);
INSERT INTO `xadmin_log` VALUES (41, '2020-01-23 08:27:06.875343', '127.0.0.1', '15', 'git的使用', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (42, '2020-01-23 08:29:16.986168', '127.0.0.1', '13', '测试篇13', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (43, '2020-01-23 08:29:25.644046', '127.0.0.1', '12', '测试篇12', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (44, '2020-01-23 08:30:36.592843', '127.0.0.1', '11', '测试篇11', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (45, '2020-01-30 03:37:06.023339', '127.0.0.1', '15', 'git的使用', 'change', '没有字段被修改。', 15, 1);
INSERT INTO `xadmin_log` VALUES (46, '2020-01-30 03:51:47.429386', '127.0.0.1', '16', '测试篇15', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (47, '2020-01-30 05:48:49.687903', '127.0.0.1', '15', 'git的使用', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (48, '2020-01-30 07:28:21.753124', '127.0.0.1', '16', '测试篇15', 'change', '没有字段被修改。', 15, 1);
INSERT INTO `xadmin_log` VALUES (49, '2020-01-30 07:29:18.043889', '127.0.0.1', '13', '测试篇13', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (50, '2020-01-30 13:06:50.305828', '127.0.0.1', '16', '测试篇15', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (51, '2020-01-30 13:56:02.552657', '120.239.225.37', '16', '测试篇15', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (52, '2020-01-30 14:11:43.089716', '120.239.225.37', '2', 'Linux', 'create', '已添加。', 13, 1);
INSERT INTO `xadmin_log` VALUES (53, '2020-01-30 14:12:11.436556', '120.239.225.37', NULL, '', 'delete', '批量删除 15 个 文章列表', NULL, 1);
INSERT INTO `xadmin_log` VALUES (54, '2020-01-30 14:46:13.303575', '120.239.225.37', '17', 'Python-开发-Anconda和miniconda的选择和使用', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (55, '2020-01-30 15:10:33.705761', '120.239.225.37', '17', 'Python-开发-Anaconda和Miniconda的使用', 'change', '修改 title 和 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (56, '2020-01-30 15:10:56.292059', '120.239.225.37', '5', 'Python开发', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (57, '2020-01-30 15:11:16.770697', '120.239.225.37', '6', 'Python开发工具', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (58, '2020-01-30 15:12:00.852081', '120.239.225.228', '17', 'Python-开发-Anaconda和Miniconda的使用', 'change', '修改 tags', 15, 1);
INSERT INTO `xadmin_log` VALUES (59, '2020-01-30 15:14:30.450065', '120.239.225.37', '17', 'Anaconda和Miniconda的使用', 'change', '修改 title 和 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (60, '2020-02-01 03:27:59.787793', '223.74.246.64', '3', 'Django', 'create', '已添加。', 13, 1);
INSERT INTO `xadmin_log` VALUES (61, '2020-02-01 03:33:58.629704', '223.74.246.64', '18', 'LVS 原理介绍', 'create', '已添加。', 15, 1);
INSERT INTO `xadmin_log` VALUES (62, '2020-02-01 03:34:19.554664', '223.74.246.64', NULL, '', 'delete', '批量删除 4 个 标签', NULL, 1);
INSERT INTO `xadmin_log` VALUES (63, '2020-02-01 03:34:30.834030', '223.74.246.64', '7', 'Linux运维', 'create', '已添加。', 14, 1);
INSERT INTO `xadmin_log` VALUES (64, '2020-02-01 03:34:43.273964', '223.74.246.64', '18', 'LVS 原理介绍', 'change', '修改 tags', 15, 1);
INSERT INTO `xadmin_log` VALUES (65, '2020-02-01 03:40:08.917614', '223.74.246.64', '18', 'LVS 原理介绍', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (66, '2020-02-01 03:43:50.604497', '223.74.246.64', '18', 'LVS 原理介绍', 'change', '修改 body', 15, 1);
INSERT INTO `xadmin_log` VALUES (67, '2020-02-01 03:46:17.104842', '127.0.0.1', '18', 'LVS 原理介绍', 'change', '没有字段被修改。', 15, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xadmin_usersettings
-- ----------------------------
INSERT INTO `xadmin_usersettings` VALUES (1, 'dashboard:home:pos', '', 1);
INSERT INTO `xadmin_usersettings` VALUES (2, 'site-theme', '/static/xadmin/css/themes/bootstrap-xadmin.css', 1);

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
