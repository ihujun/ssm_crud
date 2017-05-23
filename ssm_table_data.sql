/*
SQLyog Ultimate v11.24 (64 bit)
MySQL - 5.7.17-log : Database - ssm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm`;

/*Table structure for table `department` */

CREATE TABLE `department` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`dep_id`,`dep_name`) values (2,'开发部'),(3,'人事部');

/*Table structure for table `employee` */

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dep_id` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_dep_id` (`dep_id`),
  CONSTRAINT `fk_dep_id` FOREIGN KEY (`dep_id`) REFERENCES `department` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

/*Data for the table `employee` */

insert  into `employee`(`emp_id`,`emp_name`,`gender`,`email`,`dep_id`) values (8,'开发6号','n','6@hj.com',2),(9,'开发7号','n','7@hj.com',2),(10,'开发8号','n','8@hj.com',2),(11,'开发9号','n','9@hj.com',2),(12,'开发10号','n','10@hj.com',2),(13,'开发11号','n','11@hj.com',2),(14,'开发12号','n','12@hj.com',2),(15,'开发13号','n','13@hj.com',2),(16,'开发14号','n','14@hj.com',2),(17,'开发15号','n','15@hj.com',2),(18,'开发16号','n','16@hj.com',2),(19,'开发17号','n','17@hj.com',2),(20,'开发18号','n','18@hj.com',2),(21,'开发19号','n','19@hj.com',2),(22,'开发20号','m','22@hj.com',2),(23,'开发21号','n','21@hj.com',2),(24,'开发22号','n','22@hj.com',2),(25,'开发23号','n','23@hj.com',2),(26,'开发24号','n','24@hj.com',2),(27,'开发25号','n','25@hj.com',2),(28,'开发26号','n','26@hj.com',2),(29,'开发27号','n','27@hj.com',2),(30,'开发28号','n','28@hj.com',2),(31,'开发29号','n','29@hj.com',2),(32,'开发30号','n','30@hj.com',2),(33,'开发31号','n','31@hj.com',2),(34,'开发32号','n','32@hj.com',2),(35,'开发33号','n','33@hj.com',2),(36,'开发34号','n','34@hj.com',2),(37,'开发35号','n','35@hj.com',2),(38,'开发36号','n','36@hj.com',2),(39,'开发37号','n','37@hj.com',2),(40,'开发38号','n','38@hj.com',2),(41,'开发39号','n','39@hj.com',2),(42,'开发40号','n','40@hj.com',2),(43,'开发41号','n','41@hj.com',2),(44,'开发42号','n','42@hj.com',2),(45,'开发43号','n','43@hj.com',2),(46,'开发44号','n','44@hj.com',2),(47,'开发45号','n','45@hj.com',2),(48,'开发46号','n','46@hj.com',2),(49,'开发47号','n','47@hj.com',2),(50,'开发48号','n','48@hj.com',2),(51,'开发49号','n','49@hj.com',2),(52,'开发50号','n','50@hj.com',2),(53,'开发51号','n','51@hj.com',2),(54,'开发52号','n','52@hj.com',2),(55,'开发53号','n','53@hj.com',2),(56,'开发54号','n','54@hj.com',2),(57,'开发55号','n','55@hj.com',2),(58,'开发56号','n','56@hj.com',2),(59,'开发57号','n','57@hj.com',2),(60,'开发58号','n','58@hj.com',2),(61,'开发59号','n','59@hj.com',2),(62,'开发60号','n','60@hj.com',2),(63,'开发61号','n','61@hj.com',2),(64,'开发62号','n','62@hj.com',2),(65,'开发63号','n','63@hj.com',2),(66,'开发64号','n','64@hj.com',2),(67,'开发65号','n','65@hj.com',2),(68,'开发66号','n','66@hj.com',2),(69,'开发67号','n','67@hj.com',2),(70,'开发68号','n','68@hj.com',2),(71,'开发69号','n','69@hj.com',2),(72,'开发70号','n','70@hj.com',2),(73,'开发71号','n','71@hj.com',2),(74,'开发72号','n','72@hj.com',2),(75,'开发73号','n','73@hj.com',2),(76,'开发74号','n','74@hj.com',2),(77,'开发75号','n','75@hj.com',2),(78,'开发76号','n','76@hj.com',2),(79,'开发77号','n','77@hj.com',2),(80,'开发78号','n','78@hj.com',2),(81,'开发79号','n','79@hj.com',2),(82,'开发80号','n','80@hj.com',2),(83,'开发81号','n','81@hj.com',2),(84,'开发82号','n','82@hj.com',2),(85,'开发83号','n','83@hj.com',2),(86,'开发84号','n','84@hj.com',2),(87,'开发85号','n','85@hj.com',2),(88,'开发86号','n','86@hj.com',2),(89,'开发87号','n','87@hj.com',2),(90,'开发88号','n','88@hj.com',2),(91,'开发89号','n','89@hj.com',2),(92,'开发90号','n','90@hj.com',2),(93,'开发91号','n','91@hj.com',2),(94,'开发92号','n','92@hj.com',2),(95,'开发93号','n','93@hj.com',2),(96,'开发94号','n','94@hj.com',2),(97,'开发95号','n','95@hj.com',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
