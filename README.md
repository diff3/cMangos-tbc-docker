# Install



Clone source code for TBC and the database in the etc folder. 



```bash
cd etc
git clone https://github.com/cmangos/mangos-tbc
git clone https://github.com/cmangos/tbc-db
```



Start by compiling, it will take a while but then it done, compile will close down. You will find all needed files in server folder. 

```bash
docker-compose up compile
```



To make the server run, you need add config files, for a basic sever just go to server/etc and copy the config files.

```bash
cd server/etc
cp realmd.conf.dist realmd.conf
cp mangosd.conf.dist mangosd.conf
```



You need to add folders to the bin foler . Program for exctracting the data can be found in server/bin/tools folder. At the moment where is no docker container for automatecly extract the data. Se tutorial on [cmangos page](https://github.com/cmangos/issues/wiki/Installation-Instructions#extract-files-from-the-client) 



Start the server, it will take a while, first time staring database container it will import and update all databases. 

```bash
docker-compose up mariadb
ctrl-c
docker-compose up -d
```