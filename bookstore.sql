-- ============================================================
-- 图书商城 (JavaBookStore) 数据库初始化脚本
-- 数据库名称: java_bookstore
-- 字符编码: UTF-8
-- ============================================================

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `java_bookstore` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `java_bookstore`;

-- ============================================================
-- 1. 用户表 (user)
--    存储前台注册用户信息
-- ============================================================
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username`    VARCHAR(32)  NOT NULL COMMENT '用户名',
  `password`    VARCHAR(64)  NOT NULL COMMENT '密码',
  `phone`       VARCHAR(11)  DEFAULT NULL COMMENT '手机号',
  `email`       VARCHAR(64)  DEFAULT NULL COMMENT '邮箱',
  `sex`         VARCHAR(2)   DEFAULT NULL COMMENT '性别: M-男, F-女',
  `avatar`      VARCHAR(500) DEFAULT NULL COMMENT '头像URL',
  `create_time` DATETIME     DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='前台用户信息';

-- ============================================================
-- 2. 员工表 (employee)
--    存储后台管理员信息
-- ============================================================
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id`          BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username`    VARCHAR(32) NOT NULL COMMENT '用户名',
  `name`        VARCHAR(32) NOT NULL COMMENT '姓名',
  `password`    VARCHAR(64) NOT NULL COMMENT '密码',
  `phone`       VARCHAR(11) NOT NULL COMMENT '手机号',
  `sex`         VARCHAR(2)  NOT NULL COMMENT '性别',
  `id_number`   VARCHAR(18) NOT NULL COMMENT '身份证号',
  `status`      INT         NOT NULL DEFAULT '1' COMMENT '状态: 0-禁用, 1-启用',
  `create_time` DATETIME    DEFAULT NULL COMMENT '创建时间',
  `update_time` DATETIME    DEFAULT NULL COMMENT '更新时间',
  `create_user` BIGINT      DEFAULT NULL COMMENT '创建人ID',
  `update_user` BIGINT      DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工(管理员)信息';

-- ============================================================
-- 3. 图书分类表 (category)
--    存储图书分类信息
-- ============================================================
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id`          BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type`        INT         DEFAULT NULL COMMENT '分类类型',
  `name`        VARCHAR(32) NOT NULL COMMENT '分类名称',
  `sort`        INT         DEFAULT NULL COMMENT '排序',
  `status`      INT         DEFAULT NULL COMMENT '状态: 0-禁用, 1-启用',
  `create_time` DATETIME    DEFAULT NULL COMMENT '创建时间',
  `update_time` DATETIME    DEFAULT NULL COMMENT '更新时间',
  `create_user` BIGINT      DEFAULT NULL COMMENT '创建人ID',
  `update_user` BIGINT      DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图书分类';

-- ============================================================
-- 4. 图书表 (book)
--    存储所有图书商品信息
-- ============================================================
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id`          BIGINT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name`        VARCHAR(128)    NOT NULL COMMENT '书名',
  `author`      VARCHAR(64)     DEFAULT NULL COMMENT '作者',
  `description` TEXT            DEFAULT NULL COMMENT '图书简介',
  `category`    VARCHAR(32)     DEFAULT NULL COMMENT '图书类别(文学小说/科技科普/历史传记/经济管理/儿童读物)',
  `image`       VARCHAR(500)    DEFAULT NULL COMMENT '封面图片URL',
  `price`       DECIMAL(10,2)   NOT NULL COMMENT '价格',
  `stock`       INT             NOT NULL DEFAULT '0' COMMENT '库存数量',
  `create_time` DATETIME        DEFAULT NULL COMMENT '创建时间',
  `update_time` DATETIME        DEFAULT NULL COMMENT '更新时间',
  `create_user` BIGINT          DEFAULT NULL COMMENT '创建人ID',
  `update_user` BIGINT          DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图书信息';

-- ============================================================
-- 5. 订单表 (orders)
--    存储订单主表信息
-- ============================================================
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id`            BIGINT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `total_amount`  DECIMAL(10,2)   NOT NULL COMMENT '订单总金额',
  `address`       VARCHAR(255)    NOT NULL COMMENT '收货地址',
  `receiver_name` VARCHAR(32)     NOT NULL COMMENT '收货人姓名',
  `receiver_phone` VARCHAR(11)   NOT NULL COMMENT '收货人电话',
  `user_id`       BIGINT          NOT NULL COMMENT '用户ID',
  `status`        INT             NOT NULL DEFAULT '1' COMMENT '订单状态: 0-已取消, 1-待支付, 2-已支付, 3-已发货, 4-已完成',
  `create_time`   DATETIME        DEFAULT NULL COMMENT '创建时间',
  `update_time`   DATETIME        DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单主表';

-- ============================================================
-- 6. 订单明细表 (order_detail)
--    存储每个订单包含的具体商品信息
-- ============================================================
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id`       BIGINT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` BIGINT          NOT NULL COMMENT '订单ID',
  `book_id`  BIGINT          NOT NULL COMMENT '图书ID',
  `number`    INT             NOT NULL DEFAULT '1' COMMENT '数量',
  `amount`    DECIMAL(10,2)   NOT NULL COMMENT '小计金额',
  `image`     VARCHAR(500)    DEFAULT NULL COMMENT '商品图片',
  `book_name` VARCHAR(128)    DEFAULT NULL COMMENT '图书名称',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_book_id` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单明细表';

-- ============================================================
-- 7. 购物车表 (shopping_cart)
--    存储用户购物车数据（当前项目购物车存储在Session中，
--    该表预留用于未来实现持久化购物车）
-- ============================================================
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id`          BIGINT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name`        VARCHAR(32)     DEFAULT NULL COMMENT '商品名称',
  `image`       VARCHAR(255)    DEFAULT NULL COMMENT '图片URL',
  `user_id`     BIGINT          NOT NULL COMMENT '用户ID',
  `book_id`     BIGINT          DEFAULT NULL COMMENT '图书ID',
  `number`      INT             NOT NULL DEFAULT '1' COMMENT '数量',
  `amount`      DECIMAL(10,2)   NOT NULL COMMENT '金额',
  `create_time` DATETIME        DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';

-- ============================================================
-- 8. 地址簿表 (address_book)
--    存储用户的收货地址信息
-- ============================================================
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id`            BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id`       BIGINT       NOT NULL COMMENT '用户ID',
  `consignee`     VARCHAR(50)  DEFAULT NULL COMMENT '收货人',
  `sex`           VARCHAR(2)   DEFAULT NULL COMMENT '性别',
  `phone`         VARCHAR(11)  NOT NULL COMMENT '手机号',
  `province_code` VARCHAR(12)  DEFAULT NULL COMMENT '省级区划编号',
  `province_name` VARCHAR(32)  DEFAULT NULL COMMENT '省级名称',
  `city_code`     VARCHAR(12)  DEFAULT NULL COMMENT '市级区划编号',
  `city_name`     VARCHAR(32)  DEFAULT NULL COMMENT '市级名称',
  `district_code` VARCHAR(12)  DEFAULT NULL COMMENT '区级区划编号',
  `district_name` VARCHAR(32)  DEFAULT NULL COMMENT '区级名称',
  `detail`        VARCHAR(200) DEFAULT NULL COMMENT '详细地址',
  `label`         VARCHAR(100) DEFAULT NULL COMMENT '标签(如:家/公司)',
  `is_default`    TINYINT(1)   NOT NULL DEFAULT '0' COMMENT '是否默认: 0-否, 1-是',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址簿';


-- ============================================================
-- 初始数据插入
-- ============================================================

-- ---------------------------------------------------------
-- 插入管理员账号 (密码: 123456)
-- ---------------------------------------------------------
INSERT INTO `employee` (`id`, `username`, `name`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(1, 'admin', '管理员', '123456', '13812312312', '1', '110101199001010047', 1, NOW(), NOW(), 1, 1);

-- ---------------------------------------------------------
-- 插入图书分类
-- ---------------------------------------------------------
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(1, 1, '文学小说', 1, 1, NOW(), NOW(), 1, 1),
(2, 1, '科技科普', 2, 1, NOW(), NOW(), 1, 1),
(3, 1, '历史传记', 3, 1, NOW(), NOW(), 1, 1),
(4, 1, '经济管理', 4, 1, NOW(), NOW(), 1, 1),
(5, 1, '儿童读物', 5, 1, NOW(), NOW(), 1, 1);

-- ---------------------------------------------------------
-- 插入图书数据（12本示例图书）
-- ---------------------------------------------------------
INSERT INTO `book` (`id`, `name`, `author`, `description`, `category`, `image`, `price`, `stock`, `create_time`, `update_time`) VALUES
(1, '活着', '余华',
 '《活着》是余华的代表作之一，讲述了在大时代背景下，随着内战、三反五反、大跃进、文化大革命等社会变革，主人公徐福贵的人生和家庭不断经受着苦难，到了最后所有亲人都先后离他而去，仅剩下年老的他和一头老牛相依为命。',
 '文学小说', 'https://picsum.photos/seed/book001/300/400', 39.00, 100, NOW(), NOW()),
(2, '三体', '刘慈欣',
 '《三体》是刘慈欣创作的系列长篇科幻小说，讲述了地球人类文明和三体文明的信息交流、生死搏杀及两个文明在宇宙中的兴衰历程。其第一部经过刘宇昆翻译后获得了第73届雨果奖最佳长篇小说奖。',
 '科技科普', 'https://picsum.photos/seed/book002/300/400', 68.00, 80, NOW(), NOW()),
(3, '明朝那些事儿', '当年明月',
 '《明朝那些事儿》主要讲述的是从1344年到1644年这三百年间关于明朝的一些故事。以史料为基础，以年代和具体人物为主线，并加入了小说的笔法，语言幽默风趣。',
 '历史传记', 'https://picsum.photos/seed/book003/300/400', 128.00, 60, NOW(), NOW()),
(4, '原则', '瑞·达利欧',
 '《原则》一书是桥水基金创始人瑞·达利欧的人生经验之作，多角度、立体地阐述了生活、工作、管理原则。包含21条高原则、139条中原则和365条分原则，涵盖为人处事、公司管理两大方面。',
 '经济管理', 'https://picsum.photos/seed/book004/300/400', 98.00, 50, NOW(), NOW()),
(5, '百年孤独', '加西亚·马尔克斯',
 '《百年孤独》是魔幻现实主义文学的代表作，描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。',
 '文学小说', 'https://picsum.photos/seed/book005/300/400', 55.00, 70, NOW(), NOW()),
(6, '时间简史', '斯蒂芬·霍金',
 '《时间简史》是英国物理学家斯蒂芬·霍金创作的科普著作，讲述了关于宇宙本性的最前沿知识，包括宇宙图像、空间和时间、膨胀的宇宙、不确定性原理、黑洞、宇宙的起源和命运等内容。',
 '科技科普', 'https://picsum.photos/seed/book006/300/400', 45.00, 90, NOW(), NOW()),
(7, '人类简史', '尤瓦尔·赫拉利',
 '《人类简史》以大历史的视角回顾了智人的发展历程，从认知革命、农业革命到科学革命，探讨了历史与当代社会的核心问题，理清了影响人类发展的重大脉络。',
 '历史传记', 'https://picsum.photos/seed/book007/300/400', 68.00, 75, NOW(), NOW()),
(8, '国富论', '亚当·斯密',
 '《国富论》是现代经济学之父亚当·斯密的代表作品，全面系统地阐述了古典政治经济学的基本理论，提出了劳动分工、货币起源、价值理论等重要的经济学概念。',
 '经济管理', 'https://picsum.photos/seed/book008/300/400', 86.00, 40, NOW(), NOW()),
(9, '小王子', '圣埃克苏佩里',
 '《小王子》以一位飞行员作为故事叙述者，讲述了小王子从自己星球出发前往地球的过程中，所经历的各种历险。作者以小王子的孩子式的眼光，透视出成人的空虚、盲目。',
 '儿童读物', 'https://picsum.photos/seed/book009/300/400', 29.00, 120, NOW(), NOW()),
(10, '围城', '钱钟书',
 '《围城》是钱钟书所著的长篇小说，是中国现代文学史上一部风格独特的讽刺小说。被誉为"新儒林外史"。故事主要写抗战初期知识分子的群相。',
 '文学小说', 'https://picsum.photos/seed/book010/300/400', 36.00, 85, NOW(), NOW()),
(11, '未来简史', '尤瓦尔·赫拉利',
 '《未来简史》以宏大视角审视人类未来的终极命运，预测了人工智能、生物技术等前沿科技将如何重塑人类社会，探讨了数据主义、自由意志等深刻议题。',
 '科技科普', 'https://picsum.photos/seed/book011/300/400', 72.00, 55, NOW(), NOW()),
(12, '小王子立体书', '圣埃克苏佩里',
 '《小王子》立体书版，通过精美的立体纸艺设计，将经典故事以更生动的方式呈现给小朋友，培养阅读兴趣和想象力。',
 '儿童读物', 'https://picsum.photos/seed/book012/300/400', 89.00, 45, NOW(), NOW());

-- ---------------------------------------------------------
-- 插入测试用户 (密码: 123456)
-- ---------------------------------------------------------
INSERT INTO `user` (`id`, `username`, `password`, `phone`, `email`, `sex`, `avatar`, `create_time`) VALUES
(1, 'testuser', '123456', '13800138000', 'test@example.com', 'M', NULL, NOW()),
(2, 'zhangsan', '123456', '13912345678', 'zhangsan@example.com', 'M', NULL, NOW()),
(3, 'lisi', '123456', '13612345678', 'lisi@example.com', 'F', NULL, NOW());

-- ---------------------------------------------------------
-- 插入示例订单数据（用于演示报表功能）
-- ---------------------------------------------------------
INSERT INTO `orders` (`id`, `total_amount`, `address`, `receiver_name`, `receiver_phone`, `user_id`, `status`, `create_time`) VALUES
(1, 107.00, '北京市朝阳区某某路100号', '张三', '13800138000', 1, 4, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 196.00, '上海市浦东新区某某路200号', '李四', '13912345678', 2, 3, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 128.00, '广州市天河区某某路300号', '王五', '13612345678', 3, 2, DATE_SUB(NOW(), INTERVAL 1 DAY));

INSERT INTO `order_detail` (`id`, `order_id`, `book_id`, `number`, `amount`, `image`) VALUES
(1, 1, 1, 1, 39.00, 'https://picsum.photos/seed/book001/300/400'),
(2, 1, 2, 1, 68.00, 'https://picsum.photos/seed/book002/300/400'),
(3, 2, 3, 1, 128.00, 'https://picsum.photos/seed/book003/300/400'),
(4, 2, 6, 1, 68.00, 'https://picsum.photos/seed/book006/300/400'),
(5, 3, 4, 1, 98.00, 'https://picsum.photos/seed/book004/300/400'),
(6, 3, 9, 1, 29.00, 'https://picsum.photos/seed/book009/300/400');

-- ---------------------------------------------------------
-- 插入示例地址簿
-- ---------------------------------------------------------
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `sex`, `phone`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `detail`, `label`, `is_default`) VALUES
(1, 1, '张三', '1', '13800138000', '110000', '北京市', '110100', '北京市', '110101', '东城区', '某某小区1号楼101室', '家', 1),
(2, 1, '张三', '1', '13800138000', '110000', '北京市', '110100', '北京市', '110102', '西城区', '某某写字楼5层', '公司', 0);