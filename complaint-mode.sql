-- -------------------------------------------------------------
-- TablePlus 6.1.8(574)
--
-- https://tableplus.com/
--
-- Database: file-complaint
-- Generation Time: 2024-10-15 02:46:33.0860
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint unsigned NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attachments_complaint_id_foreign` (`complaint_id`),
  CONSTRAINT `attachments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `complaints`;
CREATE TABLE `complaints` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `complaint_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `incident_date` datetime NOT NULL,
  `complaint_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','in_progress','under_review','completed','submitted') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `outcome` enum('founded','unfounded','exonerated','not sustained','sustained','other sustained misconduct') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_taken` text COLLATE utf8mb4_unicode_ci,
  `assigned_to` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `complaints_complaint_number_unique` (`complaint_number`),
  KEY `complaints_user_id_foreign` (`user_id`),
  KEY `complaints_assigned_to_foreign` (`assigned_to`),
  CONSTRAINT `complaints_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `complaints_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint unsigned NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_complaint_id_foreign` (`complaint_id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  CONSTRAINT `messages_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `note_attachments`;
CREATE TABLE `note_attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `note_attachments_note_id_foreign` (`note_id`),
  CONSTRAINT `note_attachments_note_id_foreign` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notes_complaint_id_foreign` (`complaint_id`),
  KEY `notes_user_id_foreign` (`user_id`),
  CONSTRAINT `notes_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `officers`;
CREATE TABLE `officers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badge_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `officers_complaint_id_foreign` (`complaint_id`),
  CONSTRAINT `officers_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('user','admin','subadmin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `witnesses`;
CREATE TABLE `witnesses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `witnesses_complaint_id_foreign` (`complaint_id`),
  CONSTRAINT `witnesses_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `attachments` (`id`, `complaint_id`, `file_path`, `file_name`, `created_at`, `updated_at`) VALUES
(1, 1, 'complaint_attachments/1/b0O8du4VXcg3Qu21HC0MihMa45QKfrJB0bGkx4R7.png', 'Jan.png', '2024-10-10 21:30:34', '2024-10-10 21:30:34'),
(2, 2, 'complaint_attachments/2/Jo1G5mgK2rZoCJ0xZ9HI97Klss9liXTBldRmtRuw.png', 'Jan.png', '2024-10-10 21:57:20', '2024-10-10 21:57:20'),
(3, 3, 'complaint_attachments/3/mEsOXK9JBwSERiRcnpAARGxCR198eUqURZrZ1BMF.png', 'Jan.png', '2024-10-11 11:05:05', '2024-10-11 11:05:05'),
(4, 4, 'complaint_attachments/4/AfYdnMHJLv1GqcGuS7kkwkQTfHbnNcMliYbyqmJc.png', 'Jan.png', '2024-10-11 11:05:58', '2024-10-11 11:05:58'),
(5, 5, 'complaint_attachments/5/ucTH7wd82z1kIKKzlis8ylEPEtZveiU6lOWgERoQ.png', 'Jan.png', '2024-10-11 11:07:22', '2024-10-11 11:07:22'),
(6, 6, 'complaint_attachments/6/rIYhlBAnH61YbN7tCNik6GWT6U0102zbTtzHCdO4.png', 'Jan.png', '2024-10-11 11:07:27', '2024-10-11 11:07:27'),
(7, 7, 'complaint_attachments/7/i4tjIcTtXaRcom67YgIfH8lLA8Fxgw5T4YPJGiMv.png', 'Jan.png', '2024-10-11 11:07:28', '2024-10-11 11:07:28'),
(8, 8, 'complaint_attachments/8/nTLEmy08vIVhlVR8HOl2kRIN128aJZKhIWE8d5bi.png', 'Jan.png', '2024-10-11 11:07:48', '2024-10-11 11:07:48'),
(9, 9, 'complaint_attachments/9/3UIIn5o3M4AnpcPpakh68BteCg9s2qFrzr7gKYmB.png', 'Jan.png', '2024-10-11 11:11:44', '2024-10-11 11:11:44'),
(10, 10, 'complaint_attachments/10/sSfAiojSA3Hi1QGOXxcyuSl4IIGwN4zvymvsAjv2.png', 'Jan.png', '2024-10-11 20:14:41', '2024-10-11 20:14:41'),
(11, 11, 'complaint_attachments/11/5GVLw75sppNPBKrWQ4q6TRQoe7UjC9bnMbFyhbsZ.png', 'Jan.png', '2024-10-11 23:38:43', '2024-10-11 23:38:43'),
(12, 12, 'public//3kbRXFJRpoG512PtBS9gxVALIMEIXq6bNgB0oL6p.png', '12-Jan.png', '2024-10-11 23:52:04', '2024-10-11 23:52:04'),
(13, 13, 'public//0o0XiqXOSUh3oj3sU3HRAOyVTHcvdQEn2fPDqH79.png', '13-Jan.png', '2024-10-11 23:55:25', '2024-10-11 23:55:25'),
(14, 13, 'public//JgpwGg5zHQbvye0udNU7miesKz54aq0U0XdjCDnr.png', '13-Untitled design (7).png', '2024-10-11 23:55:25', '2024-10-11 23:55:25'),
(15, 13, 'public//LmbVh3uaW9R8hjrcPRd2QcwiTmsz5hEmeV6atFdb.png', '13-logo (1).png', '2024-10-11 23:55:25', '2024-10-11 23:55:25'),
(16, 14, 'public/AEmaVDEy9BXcYDX5r2Mn8Vc8wgqt8lMqiUnPHENI.png', '14-Jan.png', '2024-10-11 23:56:37', '2024-10-11 23:56:37'),
(17, 14, 'public/o1nWXziOw5qUwnnZBgcpJ2KKEBR6FmIC4L7pqUKg.png', '14-Untitled design (7).png', '2024-10-11 23:56:37', '2024-10-11 23:56:37'),
(18, 16, 'public/ZPxcH8F1jjDOzA9mSNNSRE2N06TmWtJRuWm92NgD.png', '16-Jan.png', '2024-10-12 00:13:03', '2024-10-12 00:13:03'),
(19, 17, 'public/ShYNUcy3OWqwPVT6PxYEkRdkpIfosARZTcdaCLgr.png', '17-Jan.png', '2024-10-12 04:49:57', '2024-10-12 04:49:57'),
(20, 19, 'public/T5cmAOdHJfsKfa7uD01mMKi7mkLeynZ0hhaXqR7d.png', '19-Jan.png', '2024-10-12 04:51:24', '2024-10-12 04:51:24'),
(21, 20, 'public/9mPLaQZPiGywT8gM6JSBh3pwlwoaToWxGkJ79zb0.png', '20-Screenshot 2024-10-12 111701.png', '2024-10-13 07:36:26', '2024-10-13 07:36:26'),
(22, 21, 'public/PHrnRBN61nCPPUf38UOCTer6JsDy4BTJS0EmznEj.jpg', '21-download.jpg', '2024-10-13 18:11:56', '2024-10-13 18:11:56'),
(23, 22, 'public/5gGKuwRsDjTxwmWIIdkQMPTh1w1jqjJ5k2XZ86mt.jpg', '22-download.jpg', '2024-10-13 18:44:35', '2024-10-13 18:44:35'),
(24, 23, 'public/KkaaEfbbfZsivNnVmyZn9Kxb1EsQ71tenHNW62qS.jpg', '23-download.jpg', '2024-10-13 18:45:36', '2024-10-13 18:45:36'),
(25, 24, 'public/F8WvSLg8zRDr2LRQSGXGJfNUh2gAvA8xeDtoopjQ.pdf', '24-H-28p.pdf', '2024-10-13 19:37:25', '2024-10-13 19:37:25'),
(26, 25, 'public/sQsFlSo8xiCPoY4eQqXDvBc8kLO01PnxnttdhfI1.pdf', '25-H-28p.pdf', '2024-10-13 19:37:35', '2024-10-13 19:37:35'),
(27, 26, 'public/1XuwellBnbmmK1PqblVukOpw2oKhu01iQNQdO1Y8.png', '26-Screenshot 2024-10-14 093923.png', '2024-10-14 07:14:09', '2024-10-14 07:14:09');

INSERT INTO `complaints` (`id`, `user_id`, `complaint_number`, `description`, `incident_date`, `complaint_type`, `signature`, `status`, `outcome`, `action_taken`, `assigned_to`, `created_at`, `updated_at`) VALUES
(1, NULL, 'C-yd91vm6Q', 'complaint 123', '2024-10-10 11:30:00', NULL, NULL, 'completed', 'other sustained misconduct', 'Two week unpaid leave 9999', 3, '2024-10-10 21:30:34', '2024-10-14 06:45:01'),
(2, 8, 'C-0O2sDGPM', 'This is my complaint', '2024-10-10 11:47:00', NULL, NULL, 'completed', 'founded', 'none', 3, '2024-10-10 21:57:20', '2024-10-13 17:56:02'),
(3, NULL, 'C-Ysser8Jc', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'in_progress', NULL, NULL, NULL, '2024-10-11 11:05:04', '2024-10-13 23:19:02'),
(4, NULL, 'C-WQmHPojF', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 11:05:58', '2024-10-11 11:05:58'),
(5, NULL, 'C-dcKFs2wf', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'completed', 'founded', NULL, NULL, '2024-10-11 11:07:22', '2024-10-13 06:03:40'),
(6, NULL, 'C-H99LDGIQ', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 11:07:26', '2024-10-11 11:07:26'),
(7, NULL, 'C-WEcYTjLH', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 11:07:28', '2024-10-11 11:07:28'),
(8, NULL, 'C-WvORtxwU', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 11:07:48', '2024-10-11 11:07:48'),
(9, NULL, 'C-vV47ugnD', 'qqq', '2024-10-11 01:03:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 11:11:44', '2024-10-11 11:11:44'),
(10, NULL, 'C-pSdVdIR3', 'I have some kind of complaint', '2024-10-11 10:13:00', NULL, NULL, 'in_progress', NULL, NULL, NULL, '2024-10-11 20:14:40', '2024-10-11 20:16:18'),
(11, 1, 'C-ReKJW2mp', 'asdfasf', '2024-10-11 13:35:00', NULL, NULL, 'completed', 'founded', 'none', NULL, '2024-10-11 23:38:43', '2024-10-13 23:52:22'),
(12, 1, 'C-I54fLOCz', '333', '2024-10-11 13:51:00', NULL, NULL, 'completed', 'founded', 'test', NULL, '2024-10-11 23:52:04', '2024-10-13 23:57:19'),
(13, 1, 'C-JA935icf', 'dsdds', '2024-10-11 13:54:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 23:55:25', '2024-10-11 23:55:25'),
(14, 1, 'C-vRZc8ptM', 'aasdfasdasdf asdfa asf d', '2024-10-11 13:56:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-11 23:56:37', '2024-10-11 23:56:37'),
(15, NULL, 'C-mPRap0KY', 'WWWQQWWQQ', '2024-10-08 14:09:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-12 00:09:36', '2024-10-12 00:09:36'),
(16, NULL, 'C-rgVtaISl', 'WWWQQWWQQ', '2024-10-08 14:09:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-12 00:13:03', '2024-10-12 00:13:03'),
(17, 2, 'C-IDzRO2Vb', 'some form of a complaint', '2024-10-11 18:49:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-12 04:49:57', '2024-10-12 04:49:57'),
(18, NULL, 'C-28AaMHJr', 'wwwww', '2024-10-11 18:50:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-12 04:50:59', '2024-10-12 04:50:59'),
(19, NULL, 'C-UTXHCmIG', 'dddddd', '2024-10-11 18:51:00', NULL, NULL, 'in_progress', NULL, NULL, 3, '2024-10-12 04:51:24', '2024-10-12 04:58:24'),
(20, 4, 'C-jLuCx2Hb', 'Test', '2024-10-12 21:35:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-13 07:36:26', '2024-10-13 07:36:26'),
(21, 1, 'C-lt8OS4hR', 'test', '2024-10-15 10:11:00', NULL, NULL, 'completed', 'founded', 'test', NULL, '2024-10-13 18:11:56', '2024-10-14 10:04:11'),
(22, 7, 'C-gdx7Mazn', 'test2', '2024-10-14 10:44:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-13 18:44:35', '2024-10-13 18:44:35'),
(23, NULL, 'C-gAW0eKtp', 'test2', '2024-10-14 10:45:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-13 18:45:36', '2024-10-13 18:45:36'),
(24, 1, 'C-hQvlwfo1', 'test', '2024-10-14 11:36:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-13 19:37:25', '2024-10-13 19:37:25'),
(25, 1, 'C-ZMvpAGw5', 'test', '2024-10-14 11:36:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-13 19:37:35', '2024-10-13 19:37:35'),
(26, 2, 'C-FemjLk9U', 'test', '1988-07-18 15:15:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-14 07:14:09', '2024-10-14 07:14:09'),
(27, 8, 'C-Ahzqafip', 'test', '2024-10-08 23:19:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-14 07:18:01', '2024-10-14 07:18:01'),
(28, 2, 'C-1Rzof2DI', 'test', '2024-10-15 00:46:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-14 08:46:56', '2024-10-14 08:46:56'),
(29, 2, 'C-5bucsoJ9', 'test', '2024-10-15 00:59:00', NULL, NULL, 'pending', NULL, NULL, NULL, '2024-10-14 09:00:13', '2024-10-14 09:00:13'),
(30, 2, 'C-tzFaGxqj', 'new', '2024-10-15 01:05:00', 'new', NULL, 'pending', NULL, NULL, NULL, '2024-10-14 09:06:45', '2024-10-14 09:06:45'),
(31, 2, 'C-764yZkIz', 'test', '2024-10-15 01:15:00', 'Racial Profiling', NULL, 'pending', NULL, NULL, NULL, '2024-10-14 09:15:42', '2024-10-14 09:15:42'),
(32, 2, 'C-zZH6FB3I', 'testtesttest', '2024-10-15 01:16:00', 'Racial Profiling', 'signature testtesttesttest', 'pending', NULL, NULL, NULL, '2024-10-14 09:16:38', '2024-10-14 09:16:38');

INSERT INTO `messages` (`id`, `complaint_id`, `sender_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'test', '2024-10-11 11:42:16', '2024-10-11 11:42:16'),
(2, 2, 2, 'Hi Joe,\r\n\r\nWe are investigating the issue and will be back in touch with you.\r\n\r\nThanks,\r\nLt. Dan', '2024-10-11 11:44:18', '2024-10-11 11:44:18'),
(3, 2, 2, 'Here is another update', '2024-10-11 20:17:14', '2024-10-11 20:17:14'),
(4, 2, 1, 'post another reply', '2024-10-11 20:18:04', '2024-10-11 20:18:04'),
(5, 2, 2, 'Heya message again thanks', '2024-10-13 07:51:47', '2024-10-13 07:51:47'),
(6, 12, 2, 'test', '2024-10-14 00:00:38', '2024-10-14 00:00:38'),
(7, 12, 2, 'test', '2024-10-14 00:04:49', '2024-10-14 00:04:49'),
(8, 12, 2, '1', '2024-10-14 00:05:08', '2024-10-14 00:05:08'),
(9, 25, 1, 'test', '2024-10-14 00:08:33', '2024-10-14 00:08:33'),
(10, 12, 2, 'test1', '2024-10-14 00:08:37', '2024-10-14 00:08:37'),
(11, 27, 8, 'hello', '2024-10-14 07:18:24', '2024-10-14 07:18:24');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(8, '2024_10_10_151613_create_attachments_table', 3),
(9, '2014_10_12_000000_create_users_table', 4),
(10, '2024_10_09_230929_create_complaints_table', 5),
(11, '2024_10_09_230942_create_officers_table', 5),
(12, '2024_10_09_230952_create_messages_table', 5),
(13, '2024_10_11_191140_make_officer_fields_nullable', 6),
(14, '2024_10_13_001320_add_outcome_to_complaints', 7),
(15, '2024_10_13_001448_create_notes_table', 7),
(16, '2024_10_13_135231_add_action_taken_to_complaints_table', 8),
(19, '2024_10_14_023404_add_additional_address_fields_to_users_table', 9),
(20, '2024_10_14_030403_create_note_attachments_table', 10),
(21, '2024_10_14_033423_create_witnesses_table', 11),
(23, '2024_10_14_150601_add_additional_options_for_status_and_outcome_in_complaints_table', 12),
(26, '2024_10_14_164419_add_complaint_type_and_signature_to_the_complaints_table', 13);

INSERT INTO `note_attachments` (`id`, `file_path`, `file_name`, `note_id`, `created_at`, `updated_at`) VALUES
(1, 'public/aScTwTfgDtZWQCz2EI0DkowT0dchY8NOOOGnhDho.pdf', '6-H-28p.pdf', 6, '2024-10-13 19:07:25', '2024-10-13 19:07:25'),
(2, 'public/fPjqZCxApbpmczAmT3DBYVYPslHVqYGWLcDavQ2z.jpg', '6-download.jpg', 6, '2024-10-13 19:07:25', '2024-10-13 19:07:25'),
(3, 'public/pgcdouL9zFxkc8LvMyk9eFi7oS7xr3eQ6vyyvq2h.pdf', '7-H-28p.pdf', 7, '2024-10-13 22:19:14', '2024-10-13 22:19:14');

INSERT INTO `notes` (`id`, `complaint_id`, `user_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 5, 2, 'Note', '2024-10-13 07:29:51', '2024-10-13 07:29:51'),
(2, 5, 2, 'Another note again', '2024-10-13 07:30:03', '2024-10-13 07:30:03'),
(3, 2, 2, 'I\'m not sure I like this case, it\'s not good.', '2024-10-13 07:49:37', '2024-10-13 07:49:37'),
(4, 2, 2, 'New note here', '2024-10-13 07:51:33', '2024-10-13 07:51:33'),
(5, 1, 2, 'test', '2024-10-13 18:57:55', '2024-10-13 18:57:55'),
(6, 1, 2, 'test', '2024-10-13 19:07:25', '2024-10-13 19:07:25'),
(7, 2, 2, 'wtf', '2024-10-13 22:19:14', '2024-10-13 22:19:14'),
(8, 12, 2, '123', '2024-10-14 00:12:16', '2024-10-14 00:12:16'),
(9, 11, 2, '123', '2024-10-14 00:13:05', '2024-10-14 00:13:05'),
(10, 2, 2, 'test', '2024-10-14 07:07:30', '2024-10-14 07:07:30'),
(11, 2, 2, 'test', '2024-10-14 07:07:45', '2024-10-14 07:07:45');

INSERT INTO `officers` (`id`, `complaint_id`, `name`, `rank`, `division`, `badge_number`, `created_at`, `updated_at`) VALUES
(1, 1, 'Joe Officer', 'Patrolman', 'One', '100', '2024-10-10 21:30:34', '2024-10-10 21:30:34'),
(2, 2, 'Officer Joe', 'Sergant', 'One', '123', '2024-10-10 21:57:20', '2024-10-10 21:57:20'),
(3, 3, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:05:04', '2024-10-11 11:05:04'),
(4, 4, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:05:58', '2024-10-11 11:05:58'),
(5, 5, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:07:22', '2024-10-11 11:07:22'),
(6, 6, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:07:26', '2024-10-11 11:07:26'),
(7, 7, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:07:28', '2024-10-11 11:07:28'),
(8, 8, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:07:48', '2024-10-11 11:07:48'),
(9, 9, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 11:11:44', '2024-10-11 11:11:44'),
(10, 10, 'Joe Test', 'Sergant', 'One', '123', '2024-10-11 20:14:40', '2024-10-11 20:14:40'),
(11, 11, 'Officer Joe', 'Sergant', 'One', '123', '2024-10-11 23:38:43', '2024-10-11 23:38:43'),
(12, 12, 'Joe Test', 'Sergant', 'rrr', '123', '2024-10-11 23:52:04', '2024-10-11 23:52:04'),
(13, 13, 'Joe Test', 'Sergant', 'sss', '123', '2024-10-11 23:55:25', '2024-10-11 23:55:25'),
(14, 14, 'Officer Joe', 'Sergant', 'One', '123', '2024-10-11 23:56:37', '2024-10-11 23:56:37'),
(15, 16, NULL, NULL, NULL, NULL, '2024-10-12 00:13:03', '2024-10-12 00:13:03'),
(16, 17, NULL, NULL, NULL, NULL, '2024-10-12 04:49:57', '2024-10-12 04:49:57'),
(17, 18, 'Joe Test', 'Sergant', NULL, NULL, '2024-10-12 04:50:59', '2024-10-12 04:50:59'),
(18, 19, 'Officer Joe', 'Sergant', 'One', '123', '2024-10-12 04:51:24', '2024-10-12 04:51:24'),
(19, 20, 'dan dan', 'LT', 'IA', '1001', '2024-10-13 07:36:26', '2024-10-13 07:36:26'),
(20, 21, 'test', 'test', 'test', '123', '2024-10-13 18:11:56', '2024-10-13 18:11:56'),
(21, 22, 'test2', 'test2', 'test2', '123', '2024-10-13 18:44:35', '2024-10-13 18:44:35'),
(22, 23, 'test2', 'test2', 'test2', '123', '2024-10-13 18:45:36', '2024-10-13 18:45:36'),
(23, 24, 'test', 'test', 'test', '123', '2024-10-13 19:37:25', '2024-10-13 19:37:25'),
(24, 25, 'test', 'test', 'test', '123', '2024-10-13 19:37:35', '2024-10-13 19:37:35'),
(25, 26, 'test', 'test', 'test', 'test', '2024-10-14 07:14:09', '2024-10-14 07:14:09'),
(26, 27, 'test', 'Deputy', 'Traffic', '11544', '2024-10-14 07:18:01', '2024-10-14 07:18:01'),
(27, 28, 'test', 'test', 'test', '1', '2024-10-14 08:46:56', '2024-10-14 08:46:56'),
(28, 29, 'test', 'test', 'test', '1', '2024-10-14 09:00:13', '2024-10-14 09:00:13'),
(29, 30, 'new', 'new', 'new', '1', '2024-10-14 09:06:45', '2024-10-14 09:06:45'),
(30, 31, 'test', 'test', 'test', '123', '2024-10-14 09:15:42', '2024-10-14 09:15:42'),
(31, 32, 'testtest', 'testtest', 'testtest', 'testtest', '2024-10-14 09:16:38', '2024-10-14 09:16:38');

INSERT INTO `users` (`id`, `name`, `email`, `password`, `address`, `city`, `state`, `zip`, `phone`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Joe Reporter', 'jschmoe@test.com', '$2y$12$cpEW4MDUTnUr4DtVfisJwu4VqKAs5JEjrDfEmezHPFRr76X9FCISa', NULL, NULL, NULL, NULL, '5555551212', 'user', NULL, '2024-10-10 21:57:20', '2024-10-13 22:13:02'),
(2, 'Matthew', 'openwestlabs@gmail.com', '$2y$12$eZNbOz880ui3FOf3XElOt./gS9XBNw5BdADFJfFuIHQO2mfUKgXsK', NULL, NULL, NULL, NULL, NULL, 'admin', NULL, '2024-10-10 22:01:26', '2024-10-13 20:42:17'),
(3, 'Sub Admin', 'subadmin@test.com', '$2y$12$IiNKWsuKNxdns.PNHq5/8Ox2p3rM9cVGBz1yqmTYqWzFdxbVM0Gbi', NULL, NULL, NULL, NULL, NULL, 'subadmin', NULL, '2024-10-12 04:05:16', '2024-10-12 04:05:16'),
(4, 'Matthew Summers', 'openwestlabs+test1@gmail.com', '$2y$12$yFM/DNl15cEIQfw52n3kqujvDuHkaM9EHvLwrE9Pcdjc6qhPh8uqK', NULL, NULL, NULL, NULL, NULL, 'user', NULL, '2024-10-13 07:34:44', '2024-10-13 07:34:44'),
(6, 'test1', 'test1@test1.com', '$2y$12$WXzdMbJY4pPilhl7i1ZRYOYkrdHadgoBKi2xfRCgXfO1KgMfyuPK6', 'test1', 'test1', 'test1', '2200', NULL, 'user', NULL, '2024-10-13 18:37:48', '2024-10-13 18:37:48'),
(7, 'test2 test2', 'test2@test2.com', '$2y$12$NR/vWMHObo/cr00XpROxbOHrlMz0FUFA8RDIcfVBs9WtNB49E42xy', 'test2', 'test2', 'test2', '1111', '123', 'user', NULL, '2024-10-13 18:44:35', '2024-10-13 18:44:35'),
(8, 'Andrew Wetzel', 'adwetzel1988@gmail.com', '$2y$12$snDn5aFjgZ3LjQtzW83qcuSmI4wsDQ8U5yISQSG8y2/OGL89zgxQS', '70366 Petit Road', 'mandeville', 'LA', '70424', '9856418978', 'user', NULL, '2024-10-14 07:18:01', '2024-10-14 07:18:01');

INSERT INTO `witnesses` (`id`, `complaint_id`, `name`, `contact`, `email`, `created_at`, `updated_at`) VALUES
(1, 25, 'witness 1', '1', '1@1.com', '2024-10-13 19:37:35', '2024-10-13 19:37:35'),
(2, 25, 'witness 2', '2', '2@2.com', '2024-10-13 19:37:35', '2024-10-13 19:37:35'),
(3, 26, 'test', 'tes', 'test@gmail.com', '2024-10-14 07:14:09', '2024-10-14 07:14:09'),
(4, 27, 'Sarah', '9856418978', 'a@gmail.com', '2024-10-14 07:18:01', '2024-10-14 07:18:01'),
(5, 28, 'test', 'test', 'test@test.com', '2024-10-14 08:46:56', '2024-10-14 08:46:56'),
(6, 28, 'test1', 'test1', 'test1@test.com', '2024-10-14 08:46:56', '2024-10-14 08:46:56'),
(7, 29, 'test', '1', 'test@test.com', '2024-10-14 09:00:13', '2024-10-14 09:00:13'),
(8, 29, 'test', '2', 'test2@test.com', '2024-10-14 09:00:13', '2024-10-14 09:00:13'),
(9, 30, 'new', 'new', 'new@new.com', '2024-10-14 09:06:45', '2024-10-14 09:06:45'),
(10, 31, 'test', '123', 'test@test.com', '2024-10-14 09:15:42', '2024-10-14 09:15:42'),
(11, 32, 'testtesttest', 'testtesttest', 'testtest@testtesttest.com', '2024-10-14 09:16:38', '2024-10-14 09:16:38');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;