# Install



Download cMangos-tbc docker. 

```bash
https://github.com/diff3/cMangos-tbc/
cd cMangos-tbc
```



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
cp server/etc/realmd.conf.dist server/etc/realmd.conf
cp server/etc/mangosd.conf.dist server/etc/mangosd.conf
```



next we need to extract all data needed by the server from the client. Change WoW path in **.env** file to the location of your installed client. 

```bash
docker-compose up extract 
```



The container will close down then it's done. You can make some config in **extract/extract.env** file, by default it will extract high res maps, and dbc, maps, vmaps mmaps and save it to the server/data folder.



Start the server, it will take a while, first time staring database container it will import and update all databases. If you want to see what mariadb is doing. 

```Bash
docker-compose up mariadb 
# or 
docker-compose up -d mariadb
docker ps # copy the container id
docker logs <id>
```



Finaly we can start the server with. If you did't populate the database, it will take a while before all servers are started. realmd, and mangosd will reboot until the database is up and running.

```bash
docker-compose up -d
```