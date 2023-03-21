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

 Date: 21/03/2023 16:30:24
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
  `NamaTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
-- Table structure for pencatatankeuangan
-- ----------------------------
DROP TABLE IF EXISTS `pencatatankeuangan`;
CREATE TABLE `pencatatankeuangan`  (
  `RowID` int(11) NOT NULL AUTO_INCREMENT,
  `TglTransaksi` date NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JenisPencatatan` int(255) NOT NULL COMMENT '0: Pengeluaran, 1: Pemasukan',
  `TotalPengeluaran` double(16, 2) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pencatatankeuangan
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
  PRIMARY KEY (`KodeEvent`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tevent
-- ----------------------------
INSERT INTO `tevent` VALUES (1, 'Test Event', 'Hanya Test event', 250, '2023-05-06', '19:00:00.000000', 'Solo', 'CL0001', '2023-03-13 13:32:21.000000', NULL);
INSERT INTO `tevent` VALUES (2, 'Konser', 'Test', 25, '2023-03-20', '16:18:00.000000', 'Solo', 'CL0001', '2023-03-21 09:19:02.000000', NULL);

-- ----------------------------
-- Table structure for tkelompokkeuangan
-- ----------------------------
DROP TABLE IF EXISTS `tkelompokkeuangan`;
CREATE TABLE `tkelompokkeuangan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaKelompok` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Posisi` int(6) NOT NULL COMMENT '1: Pemasukan, 0 : Pengeluaran',
  `Icon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelompokkeuangan
-- ----------------------------

-- ----------------------------
-- Table structure for tkelompoktamu
-- ----------------------------
DROP TABLE IF EXISTS `tkelompoktamu`;
CREATE TABLE `tkelompoktamu`  (
  `RowID` int(11) NOT NULL AUTO_INCREMENT,
  `KodeKelompok` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaKelompok` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodeSeat` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`RowID`) USING BTREE,
  INDEX `idKelompokTamu`(`KodeKelompok`, `KodeSeat`, `RecordOwnerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelompoktamu
-- ----------------------------
INSERT INTO `tkelompoktamu` VALUES (1, 'X1', 'Keluarga Pajang', 'A2', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (2, 'X2', 'Keluarga Joyontakan', 'A2', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (3, 'X3', 'Keluarga Bibis', 'A2', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (4, 'X4', 'Keluarga Karangpandan', 'A2', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (5, 'X5', 'Komsel Komsel', 'A3', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (6, 'X6', 'PPA', 'A3', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (7, 'X7', 'SMK Teknosa', 'A6', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (8, 'X8', 'SMP 5 SKA', 'A6', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (9, 'X9', 'EXTERNAL', 'A6', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (10, 'X10', 'CENTRO Solo Paragon', 'A5', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (11, 'X11', 'PT HARDO Solo Plast', 'A5', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (12, 'X12', 'PT Indo Cali Plast', 'A5', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (13, 'X13', 'CUCMEY', 'A8', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (14, 'X14', 'OMG', 'A3', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (15, 'X15', 'Keluarga Inti Djoko Partomo', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (16, 'X16', 'Keluarga Partodinomo', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (17, 'X17', 'Keluarga Balong', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (18, 'X18', 'Keluarga Pucangsawit', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (19, 'X19', 'Keluarga Mangkubumen', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (20, 'X20', 'Sakiyem group ', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (21, 'X21', 'Warso group', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (22, 'X22', 'Otorent', 'A8', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (23, 'X23', 'Tetangga RT 04', 'A8', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (24, 'X24', 'GPIBI', 'A7', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (25, 'X25', 'HOLLIT BYL', 'A9', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (26, 'X26', 'AMEYA', 'A9', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (27, 'X27', 'IGTC', 'A10', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (28, 'X28', 'PT. Pan Rama Vista', 'A9', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (29, 'X29', 'SMK ANALIS', 'A10', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (30, 'X30', 'NGADISONO', 'A10', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (31, 'X31', 'Gereja Gideon', 'A7', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (32, 'X32', 'Kampung', 'A1', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tkelompoktamu` VALUES (33, '112', 'ndndn', 'A1', 2, 'CL0001', '2023-03-21 09:19:35', NULL);

-- ----------------------------
-- Table structure for tseat
-- ----------------------------
DROP TABLE IF EXISTS `tseat`;
CREATE TABLE `tseat`  (
  `RowID` int(11) NOT NULL AUTO_INCREMENT,
  `KodeSeat` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSeat` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Area` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`RowID`, `RecordOwnerID`) USING BTREE,
  INDEX `idxSeat`(`KodeSeat`, `RecordOwnerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tseat
-- ----------------------------
INSERT INTO `tseat` VALUES (1, 'A1', 'Keluarga elsa', 'Saft 1 Depan kanan', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (2, 'A2', 'Besan aji', 'Saft 1 Depan Kiri', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (3, 'A3', 'Gereja aji', 'Saft 2 Kiri', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (4, 'A4', 'Friend aji', 'Saft 2 Kiri', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (5, 'A5', 'Work aji', 'Saft 3 Kiri', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (6, 'A6', 'Alumni aji', 'Saft 3 Kiri', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (7, 'A7', 'Gereja elsa', 'Saft 2 Kanan', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (8, 'A8', 'Friend elsa', 'Saft 2 Kanan', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (9, 'A9', 'Work elsa', 'Saft 3 Kanan', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (10, 'A10', 'Alumni elsa', 'Saft 3 Kanan', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (11, 'A11', 'Unknown', 'Sisa tempat bebas', 1, 'CL0001', '2023-03-20 22:12:16', NULL);
INSERT INTO `tseat` VALUES (12, 'A1', 'sklo', 'nnj', 2, 'CL0001', '2023-03-21 09:19:19', NULL);

-- ----------------------------
-- Table structure for ttamu
-- ----------------------------
DROP TABLE IF EXISTS `ttamu`;
CREATE TABLE `ttamu`  (
  `RowID` int(11) NOT NULL AUTO_INCREMENT,
  `KodeTamu` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KelompokTamu` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JumlahUndangan` int(6) NOT NULL,
  `AlamatTamu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EventID` int(11) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 278 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ttamu
-- ----------------------------
INSERT INTO `ttamu` VALUES (1, '1001', 'Heru Mulyono', 'X1', 4, 'Pajang', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (2, '1002', 'Ida', 'X1', 2, 'solo timur', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (3, '1003', 'Cahyo', 'X1', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (4, '1004', 'Om Agus', 'X1', 5, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (5, '1005', 'Pakde Bambang', 'X1', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (6, '1006', 'Agus B (Anak Pakde bambang)', 'X1', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (7, '1007', 'Joko', 'X1', 5, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (8, '1008', 'Ana', 'X2', 5, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (9, '1009', 'Susilo', 'X2', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (10, '1010', 'Dewi', 'X2', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (11, '1011', 'Ning sih', 'X2', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (12, '1012', 'Beti', 'X2', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (13, '1013', 'Mbak Yuli', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (14, '1014', 'mbak Cempluk', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (15, '1015', 'bulik Larsi', 'X3', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (16, '1016', 'mbak Wanti', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (17, '1017', 'Mbak Lisa', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (18, '1018', 'mas Kentut', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (19, '1019', 'mas Pipi', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (20, '1020', 'Pakde Cakil', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (21, '1021', 'Dewi', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (22, '1022', 'Krirs pakde cakil', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (23, '1023', 'Uut pakde cakil', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (24, '1024', 'Nunik', 'X3', 5, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (25, '1025', 'Upik', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (26, '1026', 'Mbak iyan', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (27, '1027', 'mas telo', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (28, '1028', 'Bulik kris', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (29, '1029', 'Dwi', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (30, '1030', 'Mbak Catur', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (31, '1031', 'Mbak eni', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (32, '1032', 'Samsiah', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (33, '1033', 'debegan', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (34, '1034', 'pakde cakol', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (35, '1035', 'mbak siska', 'X3', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (36, '1036', 'pak uztad', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (37, '1037', 'pakde slamet', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (38, '1038', 'pak RT', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (39, '1039', 'Mas Kelik', 'X3', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (40, '1040', 'Bintar', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (41, '1041', 'Mbah Sumiem Karangpandan', 'X4', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (42, '1042', 'Mas sadono', 'X4', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (43, '1043', 'om wahyudi', 'X4', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (44, '1044', 'mas cahyono', 'X4', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (45, '1045', 'Pak saidi', 'X5', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (46, '1046', 'Mbak Yanti', 'X5', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (47, '1047', 'Pak Agus', 'X6', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (48, '1048', 'Mbak Menik', 'X6', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (49, '1049', 'Mbak Dwi', 'X6', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (50, '1050', 'Bu Parsih', 'X6', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (51, '1051', 'Rayn', 'X6', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (52, '1052', 'Yessi', 'X6', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (53, '1053', 'Bu Warsiati', 'X6', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (54, '1054', 'Bu Pur', 'X6', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (55, '1055', 'Mas His', 'X6', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (56, '1056', 'Budi', 'X7', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (57, '1057', 'Yustin', 'X7', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (58, '1058', 'Koyor', 'X7', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (59, '1059', 'Nuzul', 'X7', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (60, '1060', 'Pepi', 'X8', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (61, '1061', 'Pak Deki', 'X9', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (62, '1062', 'mbak silvi', 'X10', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (63, '1063', 'Mas Lutfi', 'X11', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (64, '1064', 'Mas Agus', 'X12', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (65, '1065', 'Pascal', 'X12', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (66, '1066', 'Pak Yudi', 'X11', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (67, '1067', 'Mas Andika', 'X11', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (68, '1068', 'Pak Candra', 'X11', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (69, '1069', 'Mbak Yeti', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (70, '1070', 'Veronica lidya', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (71, '1071', 'Linda Sari', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (72, '1072', 'Agnes K', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (73, '1073', 'Amy', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (74, '1074', 'Rama', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (75, '1075', 'Prima', 'X13', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (76, '1076', 'Mami Elly Marwati', 'X31', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (77, '1077', 'Tius', 'X14', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (78, '1078', 'Yoga', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (79, '1079', 'Mas Tri', 'X14', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (80, '1080', 'Bima', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (81, '1081', 'Kevin', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (82, '1082', 'Dimas', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (83, '1083', 'Iwan', 'X14', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (84, '1084', 'Bunga', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (85, '1085', 'Lingga', 'X14', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (86, '1086', 'mas Bambang', 'X14', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (87, '1087', 'Om Tono', 'X15', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (88, '1088', 'Om Gandi', 'X15', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (89, '1089', 'Om Uud', 'X15', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (90, '1090', 'Tante Titin', 'X15', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (91, '1091', 'Om Iim', 'X15', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (92, '1092', 'Wangon', 'X15', 30, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (93, '1093', 'Bambang', 'X16', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (94, '1094', 'Mbah Sartini', 'X16', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (95, '1095', 'Om Agus', 'X16', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (96, '1096', 'Om Hari', 'X16', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (97, '1097', 'Om Eli + Tante Rina', 'X16', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (98, '1098', 'Om Dodik', 'X16', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (99, '1099', 'Murtini', 'X16', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (100, '1100', 'Mbah Marno', 'X16', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (101, '1101', 'Rumanti', 'X16', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (102, '1102', 'Om Joko', 'X16', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (103, '1103', 'Bu Yuli', 'X16', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (104, '1104', 'Pakde Parji', 'X16', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (105, '1105', 'Mbah San', 'X17', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (106, '1106', 'Mbah Diro', 'X17', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (107, '1107', 'Kristoyo', 'X17', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (108, '1108', 'Krinanto', 'X17', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (109, '1109', 'Kareni', 'X17', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (110, '1110', 'Andi', 'X17', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (111, '1111', 'Anang', 'X17', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (112, '1112', 'Mbah Dar', 'X18', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (113, '1113', 'Pamrih', 'X18', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (114, '1114', 'Joko Purwodadi', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (115, '1115', 'Mas Puji', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (116, '1116', 'Mas Sur', 'X18', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (117, '1117', 'Mas Budi', 'X18', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (118, '1118', 'Puri ', 'X18', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (119, '1119', 'Puri 2 ', 'X18', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (120, '1120', 'Tutuk', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (121, '1121', 'Amin', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (122, '1122', 'Suyitno', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (123, '1123', 'Jatmiko', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (124, '1124', 'Rosi', 'X18', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (125, '1125', 'Tanti', 'X19', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (126, '1126', 'Muljiyah', 'X19', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (127, '1127', 'Murni', 'X19', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (128, '1128', 'Wiro Kante', 'X19', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (129, '1129', 'Sakiyem', 'X20', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (130, '1130', 'Marli', 'X20', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (131, '1131', 'Wage', 'X20', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (132, '1132', 'Parjo', 'X20', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (133, '1133', 'Satini', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (134, '1134', 'Prapti', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (135, '1135', 'Setyadi', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (136, '1136', 'raji', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (137, '1137', 'Wandi', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (138, '1138', 'Paimin', 'X21', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (139, '1139', 'Widhi (Ria)', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (140, '1140', 'Wanto', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (141, '1141', 'Santoso', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (142, '1142', 'Danang', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (143, '1143', 'Senni', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (144, '1144', 'Agus', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (145, '1145', 'Joko ', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (146, '1146', 'Vico', 'X22', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (147, '1147', 'Alip', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (148, '1148', 'Soni', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (149, '1149', 'Didik', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (150, '1150', 'Gunawan', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (151, '1151', 'Wahyu A', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (152, '1152', 'Widodo', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (153, '1153', 'Wahyu B', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (154, '1154', 'Jhono', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (155, '1155', 'Tri', 'X22', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (156, '1156', 'Widodo RT', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (157, '1157', 'Budi', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (158, '1158', 'Agung', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (159, '1159', 'Dwi Sasmito', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (160, '1160', 'Watini', 'X23', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (161, '1161', 'Eko', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (162, '1162', 'Rita', 'X23', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (163, '1163', 'Inung', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (164, '1164', 'Widhi ', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (165, '1165', 'Tutik', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (166, '1166', 'Ageng', 'X23', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (167, '1167', 'Ratiyem', 'X23', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (168, '1168', 'Tutut', 'X23', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (169, '1169', 'Indri', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (170, '1170', 'Mardi', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (171, '1171', 'Aji', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (172, '1172', 'Indi (Ina)', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (173, '1173', 'Bambang', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (174, '1174', 'Sarso', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (175, '1175', 'JokoWidodo', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (176, '1176', 'Gesang', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (177, '1177', 'Wanto', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (178, '1178', 'Mujiyanto', 'X23', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (179, '1179', 'Prapti Jamu', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (180, '1180', 'Wondo', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (181, '1181', 'Sarkini', 'X23', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (182, '1182', 'Pdt Supadi', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (183, '1183', 'Heri', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (184, '1184', 'Hari', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (185, '1185', 'Joko Susilo', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (186, '1186', 'Murdianto', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (187, '1187', 'Sriyanto', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (188, '1188', 'Gondlop', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (189, '1189', 'Budi', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (190, '1190', 'Ria', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (191, '1191', 'Tinus', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (192, '1192', 'Candra', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (193, '1193', 'Rahayu', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (194, '1194', 'Om Totok', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (195, '1195', 'Pak Kardi', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (196, '1196', 'Joko Etik', 'X24', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (197, '1197', 'Nadila', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (198, '1198', 'Mas edi', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (199, '1199', 'Fina', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (200, '1200', 'Riyanti', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (201, '1201', 'Mb Henny', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (202, '1202', 'Mb azizah', 'X25', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (203, '1203', 'Bu Susi ', 'X25', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (204, '1204', 'Mb Yohana', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (205, '1205', 'Sudhir', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (206, '1206', 'Pak Murry', 'X25', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (207, '1207', 'Mas Aziz', 'X26', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (208, '1208', 'Arimbi', 'X26', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (209, '1209', 'Agustini', 'X27', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (210, '1210', 'Monita', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (211, '1211', 'Winda', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (212, '1212', 'Dinda', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (213, '1213', 'Mas Yoshua', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (214, '1214', 'Mb Puji', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (215, '1215', 'Tidar', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (216, '1216', 'Arya', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (217, '1217', 'Tommy', 'X27', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (218, '1218', 'Ana ', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (219, '1219', 'Ani', 'X27', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (220, '1220', 'Ester', 'X27', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (221, '1221', 'Lina', 'X27', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (222, '1222', 'Alex', 'X27', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (223, '1223', 'Devi', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (224, '1224', 'Bu Puji', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (225, '1225', 'Latifah', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (226, '1226', 'Tia', 'X28', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (227, '1227', 'Dinar', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (228, '1228', 'mb Rini', 'X28', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (229, '1229', 'Endah', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (230, '1230', 'Halimah', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (231, '1231', 'Pak Senthil', 'X28', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (232, '1232', 'Mb Sekar', 'X28', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (233, '1233', 'Naru', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (234, '1234', 'Mb Kristin', 'X28', 3, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (235, '1235', 'Mb Devita', 'X28', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (236, '1236', 'Christine Natalia', 'X29', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (237, '1237', 'Novetra Yola', 'X29', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (238, '1238', 'British', 'X29', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (239, '1239', 'Melisa fransisca', 'X29', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (240, '1240', 'Nur aini', 'X29', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (241, '1241', 'Sofie', 'X29', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (242, '1242', 'Sophia', 'X30', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (243, '1243', 'Mbak Sri Plastik', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (244, '1244', 'Ibuk e Bagas', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (245, '1245', 'Mbak Nyemrit', 'X3', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (246, '1246', 'Bu dila', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (247, '1247', 'Mbak Ria', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (248, '1248', 'Mbak Yuniar', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (249, '1249', 'Mas Bayu', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (250, '1250', 'Mas Adita', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (251, '1251', 'Pak Rizal', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (252, '1252', 'Pak Kunto', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (253, '1253', 'Fendi', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (254, '1254', 'Tio', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (255, '1255', 'Mbak Aning', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (256, '1256', 'Mbak Devi', 'X11', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (257, '1257', 'Mbak Maya', 'X11', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (258, '1258', 'Mbak Intan', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (259, '1259', 'Pak Farhan', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (260, '1260', 'Pak Tio', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (261, '1261', 'Pak Ardian', 'X11', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (262, '1262', 'Mbak Fitri', 'X11', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (263, '1263', 'Bu Merica', 'X11', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (264, '1264', 'Hippo', 'X9', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (265, '1265', 'Kak Teddy', 'X31', 4, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (266, '1266', 'Mbak Dewi', 'X31', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (267, '1267', 'Mas hari wahyudi', 'X31', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (268, '1268', 'Pak Darjo', 'X23', 0, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (269, '1269', 'mamah suhanda', 'X31', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (270, '1270', 'Pak Tri', 'X11', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (271, '1271', 'Pak Istiyanto RW', 'X32', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (272, '1272', 'Bude Tari', 'X23', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (273, '1273', 'bude indri', 'X23', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (274, '1274', 'Bude Nanik', 'X23', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (275, '1275', 'Bude Sri Gentong', 'X23', 1, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (276, '1276', 'Titik', 'X23', 2, '', 'CL0001', 1, '2023-03-20 22:25:43', NULL);
INSERT INTO `ttamu` VALUES (277, '1001', 'slolo', '112', 2, 'solo', 'CL0001', 2, '2023-03-21 09:24:32', NULL);

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

-- ----------------------------
-- Triggers structure for table bukutamu
-- ----------------------------
DROP TRIGGER IF EXISTS `trgUnknownGuest`;
delimiter ;;
CREATE TRIGGER `trgUnknownGuest` AFTER INSERT ON `bukutamu` FOR EACH ROW BEGIN

IF LEFT(NEW.KodeTamu,3) = 'UNK' THEN
INSERT INTO ttamu
(KodeTamu,NamaTamu,KelompokTamu,JumlahUndangan,AlamatTamu,RecordOwnerID,EventID,created_at,updated_at)
VALUES
(NEW.KodeTamu,NEW.NamaTamu,'',NEW.JumlahUndangan,NEW.AlamatTamu,NEW.RecordOwnerID,NEW.EventID,NOW(),NULL);
END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
