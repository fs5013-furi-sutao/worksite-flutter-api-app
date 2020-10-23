CREATE TABLE worksites ( 
  id bigint NOT NULL AUTO_INCREMENT
  , name varchar(255) DEFAULT NULL
  , sub_name varchar(255) DEFAULT NULL
  , type varchar(255) DEFAULT NULL
  , staff_name varchar(255) DEFAULT NULL
  , photo mediumblob DEFAULT NULL
  , address varchar(255) DEFAULT NULL
  , status varchar(255) DEFAULT NULL
  , start_at date DEFAULT NULL
  , end_at date DEFAULT NULL
  , created_at timestamp DEFAULT NULL
  , updated_at timestamp DEFAULT NULL
  , PRIMARY KEY (id)
) ENGINE = InnoDB AUTO_INCREMENT = 0 
DEFAULT CHARSET = utf8mb4 
COLLATE = utf8mb4_0900_ai_ci
;
