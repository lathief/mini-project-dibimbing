CREATE DATABASE crm_service;

create table `role` (
     `id` bigint unsigned NOT NULL AUTO_INCREMENT,
     `rolename` varchar(50) DEFAULT '',
      PRIMARY KEY (`id`)
);

INSERT INTO `role` 
VALUES
(1,'role_super_admin'),
(2,'role_admin');

create table `actors` (
     `id` bigint unsigned NOT NULL AUTO_INCREMENT,
     `username` varchar(50) DEFAULT '',
     `password` varchar(50) DEFAULT '',
     `role_id` bigint unsigned NOT NULL,
     `isVerified` ENUM('True', 'False') DEFAULT 'False',
     `isActive` ENUM('True', 'False') DEFAULT 'False',
     `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
     `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`id`),
     KEY `fk_role_actors` (`role_id`),
     CONSTRAINT `fk_role_actors` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION
);

INSERT INTO `actors`(`id`, `username`, `password`, `role_id`, `isVerified`, `isActive`, `created_at`, `updated_at`)
VALUES
(1,'spadmin','spadmin', 1, 'True', 'True', '2023-05-30 10:00:00', '2023-05-30 10:00:00');

create table `approval` (
     `id` bigint unsigned NOT NULL AUTO_INCREMENT,
     `admin_id` bigint unsigned NOT NULL,
     `superadmin_id` bigint unsigned NOT NULL,
     `status` varchar(50) DEFAULT '',
     KEY `fk_admin_actors` (`admin_id`),
     KEY `fk_superadmin_actors` (`superadmin_id`),
     CONSTRAINT `fk_admin_actors` FOREIGN KEY (`admin_id`) REFERENCES `actors` (`id`) ON DELETE NO ACTION,
     CONSTRAINT `fk_superadmin_actors` FOREIGN KEY (`superadmin_id`) REFERENCES `actors` (`id`) ON DELETE NO ACTION,
     PRIMARY KEY (`id`)
);

create table `customer` (
     `id` bigint unsigned NOT NULL AUTO_INCREMENT,
     `firstname` varchar(50) DEFAULT '',
     `lastname` varchar(50) DEFAULT '',
     `email` varchar(50) DEFAULT '',
     `avatar` varchar(255) DEFAULT '',
     `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
     `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
);

CREATE USER 'spadmin'@'127.0.0.1' IDENTIFIED BY 'spadmin';
GRANT ALL PRIVILEGES ON crm_service.* TO 'spadmin'@'127.0.0.1';

-- login to database with new superadmin
-- mysql.exe -u spadmin -pspadmin -h 127.0.0.1 crm_service