-- -----------------------------------------------------
-- Table suixingpay_config.global_config
-- -----------------------------------------------------
DROP TABLE IF EXISTS global_config;
CREATE TABLE global_config (
  profile VARCHAR(10) NOT NULL,
  source_type VARCHAR(10) NOT NULL,
  property_source TEXT NOT NULL,
  version INT NOT NULL DEFAULT 0,
  memo VARCHAR(450) NULL,
  modify_time TIMESTAMP NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (profile)
);


-- -----------------------------------------------------
-- Table suixingpay_config.profile
-- -----------------------------------------------------
DROP TABLE IF EXISTS profile;
CREATE TABLE profile (
  profile VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (profile)
);


-- -----------------------------------------------------
-- Table suixingpay_config.application
-- -----------------------------------------------------
DROP TABLE IF EXISTS application;
CREATE TABLE application (
  name VARCHAR(45) NOT NULL,
  description VARCHAR(45) NOT NULL,
  --UNIQUE INDEX application_name_UNIQUE (name ASC),
  PRIMARY KEY (name)
);
CREATE UNIQUE INDEX application_name_UNIQUE ON application (name);


-- -----------------------------------------------------
-- Table suixingpay_config.application_config
-- -----------------------------------------------------
DROP TABLE IF EXISTS application_config;
CREATE TABLE application_config (
  profile VARCHAR(10) NOT NULL,
  application_name VARCHAR(45) NOT NULL,
  property_source TEXT NOT NULL,
  source_type VARCHAR(10) NOT NULL,
  version INT NOT NULL DEFAULT 0,
  memo VARCHAR(500) NULL,
  modify_time TIMESTAMP NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (profile, application_name)
);


-- -----------------------------------------------------
-- Table suixingpay_config.global_config_log
-- -----------------------------------------------------
DROP TABLE IF EXISTS global_config_log;
CREATE TABLE global_config_log (
  id SERIAL primary key,
  profile VARCHAR(10) NOT NULL,
  property_source TEXT NOT NULL,
  source_type VARCHAR(10) NOT NULL,
  version INT NOT NULL DEFAULT 0,
  memo VARCHAR(450) NULL,
  modify_time TIMESTAMP NOT NULL,
  created_date TIMESTAMP NOT NULL,
  user_id INT NOT NULL
);
CREATE INDEX global_config_log_profile_index ON global_config_log (profile);


-- -----------------------------------------------------
-- Table suixingpay_config.application_config_log
-- -----------------------------------------------------
DROP TABLE IF EXISTS application_config_log;
CREATE TABLE application_config_log (
  id SERIAL primary key,
  profile VARCHAR(10) NOT NULL,
  application_name VARCHAR(45) NOT NULL,
  property_source TEXT NOT NULL,
  source_type VARCHAR(10) NOT NULL,
  version INT NOT NULL DEFAULT 0,
  memo VARCHAR(500) NULL,
  modify_time TIMESTAMP NOT NULL,
  created_date TIMESTAMP NOT NULL,
  user_id INT NOT NULL
);
CREATE INDEX application_config_log_name_profile_index ON application_config_log (application_name, profile);


-- -----------------------------------------------------
-- Table suixingpay_config.user
-- -----------------------------------------------------
DROP TABLE IF EXISTS tuser;
CREATE TABLE tuser (
  id SERIAL primary key,
  name VARCHAR(45) NOT NULL,
  password VARCHAR(32) NOT NULL,
  email VARCHAR(45) NULL,
  administrator VARCHAR(3) NOT NULL DEFAULT 0,
  status VARCHAR(10) NOT NULL DEFAULT 1,
  created_date TIMESTAMP NOT NULL
);
CREATE UNIQUE INDEX suixingpay_config_name_index ON tuser (name);


-- -----------------------------------------------------
-- Table suixingpay_config.user_application_config_role
-- -----------------------------------------------------
DROP TABLE IF EXISTS user_application_config_role;
CREATE TABLE user_application_config_role (
  user_id INT NOT NULL,
  application_name VARCHAR(45) NOT NULL,
  profile VARCHAR(10) NOT NULL,
  PRIMARY KEY (user_id, application_name, profile)
);


-- -----------------------------------------------------
-- Table suixingpay_config.user_global_config_role
-- -----------------------------------------------------
DROP TABLE IF EXISTS user_global_config_role;
CREATE TABLE user_global_config_role (
  user_id INT NOT NULL,
  profile VARCHAR(10) NOT NULL,
  PRIMARY KEY (user_id, profile)
);

-- -----------------------------------------------------
-- Table suixingpay_config.application_instance
-- -----------------------------------------------------
DROP TABLE IF EXISTS application_instance;
CREATE TABLE application_instance (
  id SERIAL primary key,
  application_name VARCHAR(45) NOT NULL,
  profile VARCHAR(10) NOT NULL,
  ip VARCHAR(15) NOT NULL,
  port INT4 NOT NULL,
  manager_path VARCHAR(200) NOT NULL,
  username VARCHAR(45) NULL,
  password VARCHAR(32) NULL,
  created_date TIMESTAMP NULL,
  modify_time TIMESTAMP NULL
);
CREATE UNIQUE INDEX application_instance_name_index ON application_instance (application_name, profile, ip, port);