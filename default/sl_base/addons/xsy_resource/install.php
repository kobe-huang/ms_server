<?php

if(!pdo_tableexists('xsy_resource_file')){
      $sql ="CREATE TABLE ".tablename('xsy_resource_file')." (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(255) DEFAULT NULL,
        `origin_name` varchar(255) DEFAULT NULL,
        `path` varchar(255) DEFAULT NULL,
        `owner_id` int(11) DEFAULT NULL,
        `time` int(11) DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=myisam  DEFAULT CHARSET=utf8;";
      pdo_query($sql);
}




