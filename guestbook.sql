/*
 Navicat Premium Data Transfer

 Source Server         : AISServer
 Source Server Type    : MySQL
 Source Server Version : 100240
 Source Host           : localhost:3306
 Source Schema         : guestbook

 Target Server Type    : MySQL
 Target Server Version : 100240
 File Encoding         : 65001

 Date: 07/03/2023 21:01:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bukutamu
-- ----------------------------
DROP TABLE IF EXISTS `bukutamu`;
CREATE TABLE `bukutamu`  (
  `RowID` int(11) NOT NULL AUTO_INCREMENT,
  `KodeTamu` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JumlahUndangan` int(6) NOT NULL,
  `AlamatTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bukutamu
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp(0) NULL DEFAULT NULL,
  `expires_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for tcompany
-- ----------------------------
DROP TABLE IF EXISTS `tcompany`;
CREATE TABLE `tcompany`  (
  `id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CompanyName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Coordinat` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PICName` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Email` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PhoneNumber` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PartnerCode` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `IddentityID` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tcompany
-- ----------------------------
INSERT INTO `tcompany` VALUES ('CL0001', 'AIS System', 'SOLO', '123:123', 'Prasetyo Aji Wibowo', 'prasetyoajiw@gmail.com', '081325058258', 'CL0001', '-', '2023-03-02 04:07:35', NULL);

-- ----------------------------
-- Table structure for tevent
-- ----------------------------
DROP TABLE IF EXISTS `tevent`;
CREATE TABLE `tevent`  (
  `KodeEvent` int(6) NOT NULL AUTO_INCREMENT,
  `NamaEvent` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `DeskripsiEvent` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EstimasiUndangan` int(6) NOT NULL,
  `TglEvent` date NOT NULL,
  `JamEvent` time(6) NOT NULL,
  `LokasiEvent` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`KodeEvent`) USING BTREE,
  INDEX `idEvent`(`KodeEvent`, `RecordOwnerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tevent
-- ----------------------------
INSERT INTO `tevent` VALUES (1, 'holly crab', 'berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama.berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama.berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama.berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama. berjalan berzama sama dan selalu bersama.', 650, '2023-03-08', '20:18:00.000000', 'solo', 'CL0001', '2023-03-07 13:18:54.000000', NULL);
INSERT INTO `tevent` VALUES (2, 'holly crab 2', 'TEST', 650, '2023-03-07', '20:18:00.000000', 'solo', 'CL0001', '2023-03-07 13:18:54.000000', NULL);

-- ----------------------------
-- Table structure for tkelompoktamu
-- ----------------------------
DROP TABLE IF EXISTS `tkelompoktamu`;
CREATE TABLE `tkelompoktamu`  (
  `KodeKelompok` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaKelompok` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodeSeat` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`KodeKelompok`) USING BTREE,
  INDEX `idKelompokTamu`(`KodeKelompok`, `KodeSeat`, `RecordOwnerID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelompoktamu
-- ----------------------------
INSERT INTO `tkelompoktamu` VALUES ('KLP1', 'Besan', 'ST0002', 'CL0001', '2023-03-02 04:45:32', '2023-03-02 04:45:47');

-- ----------------------------
-- Table structure for tseat
-- ----------------------------
DROP TABLE IF EXISTS `tseat`;
CREATE TABLE `tseat`  (
  `KodeSeat` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSeat` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Area` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`KodeSeat`, `RecordOwnerID`) USING BTREE,
  INDEX `idxSeat`(`KodeSeat`, `RecordOwnerID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tseat
-- ----------------------------
INSERT INTO `tseat` VALUES ('ST0002', 'Besan', 'A2', 'CL0001', '2023-03-02 04:45:00', NULL);

-- ----------------------------
-- Table structure for ttamu
-- ----------------------------
DROP TABLE IF EXISTS `ttamu`;
CREATE TABLE `ttamu`  (
  `KodeTamu` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KelompokTamu` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JumlahUndangan` int(6) NOT NULL,
  `AlamatTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`KodeTamu`) USING BTREE,
  INDEX `idxTamu`(`KodeTamu`, `KelompokTamu`, `RecordOwnerID`, `EventID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ttamu
-- ----------------------------
INSERT INTO `ttamu` VALUES ('TM001', 'test', 'KLP1', 2, 'twat', 'CL0001', 2, '2023-03-07 13:19:30', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `remember_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `RecordOwnerID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, 'Prasetyo Aji Wibowo', 'prasetyoajiw@gmail.com', NULL, '$2y$10$na2UJdoDP/RaLzp/ADLDVeCkxxzJEc4ZSk51xTZIsBvc6YX73g1Ky', '2023-03-02 04:07:35', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjY2OjgwMDAvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE2Nzc3MzAwNTUsImV4cCI6MTY3NzczMzY1NSwibmJmIjoxNjc3NzMwMDU1LCJqdGkiOiJQQ04xV0J1bWVKNWVwZ3FzIiwic3ViIjoiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.44uqsl6yxSHpbRYgzjrZEfIStgisLNFP0M2NmAEOAKM', '2023-03-02 04:07:35', 'CL0001');

SET FOREIGN_KEY_CHECKS = 1;
