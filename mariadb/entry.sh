#!/bin/sh

echo "Starting Initialization of CMaNGOS DB..."

echo "Creating databases"
mysql -u root -ppwd -e "create database tbccharacters;"
mysql -u root -ppwd -e "create database tbclogs;"
mysql -u root -ppwd -e "create database tbcmangos;"
mysql -u root -ppwd -e "create database tbcrealmd;"
mysql -u root -ppwd -e "create user 'mangos'@'%' identified by 'mangos';"

mysql -u root -ppwd -e "grant all privileges on tbccharacters.* to 'mangos'@'%';"
mysql -u root -ppwd -e "grant all privileges on tbclogs.* to 'mangos'@'%';"
mysql -u root -ppwd -e "grant all privileges on tbcmangos.* to 'mangos'@'%';"
mysql -u root -ppwd -e "grant all privileges on tbcrealmd.* to 'mangos'@'%';"

echo "Adding base data to databases"
mysql -u root -ppwd tbcrealmd < /opt/mangos-tbc/sql/base/realmd.sql
mysql -u root -ppwd tbcmangos < /opt/mangos-tbc/sql/base/mangos.sql
mysql -u root -ppwd tbccharacters < /opt/mangos-tbc/sql/base/characters.sql
mysql -u root -ppwd tbclogs < /opt/mangos-tbc/sql/base/logs.sql

echo "Configure users, and removal"
mysql -u root -ppwd tbcrealmd -e 'UPDATE `account` SET gmlevel = "4", locked = "1" WHERE id = "1" LIMIT 1;'
mysql -u root -ppwd tbcrealmd -e 'DELETE FROM `account` WHERE id = "2" LIMIT 1;'
mysql -u root -ppwd tbcrealmd -e 'DELETE FROM `account` WHERE id = "3" LIMIT 1;'
mysql -u root -ppwd tbcrealmd -e 'DELETE FROM `account` WHERE id = "4" LIMIT 1;'

echo "Add user"
mysql -u root -ppwd tbcrealmd -e 'INSERT INTO `account` (`username`, `gmlevel`, `v`, `s`, `expansion`, `locale`) VALUES ("MAPE", 3, "598439E55FF93613E12E89B23A1348D38BDCEA98C77347C2A84EE1CC210C3BDE", "B09701BDE2AAEF7E068438E831BAA8A2FF8301338C4F6420D26CCF4EA2683A47", 1, "enUS");'

echo "Changing realmd name"
mysql -u root -ppwd tbcrealmd -e 'UPDATE `realmlist` set name="Path of Glory", address="192.168.1.109", realmbuilds="8606" WHERE id = "1";'

echo "Importing world data"
# mysql -u root -ppwd tbcmangos < /opt/tbc-db/Full_DB/TBCDB_1.9.0_TheLastVengeance.sql

cp -v /docker-entrypoint-initdb.d/InstallFullDB.config /opt/tbc-db
cd /opt/tbc-db
./InstallFullDB.sh -World
