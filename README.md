# Install



This guide has been tested on MacOS Ventura and Debian 11, most steps work out the same. 



Two folder are empty then you download the repository, this because both **etc** and **server** folders are monted into the containers. So if you need to change something you can do that from your host, and just restart the containers. Most containers got an env file. So you can make changes before starting the container. If you change something you need to rebuild the container.



## Quickie



Just a list of all commands belove, to get it up and running from zero.



```bash
git clone https://github.com/diff3/cMangos-tbc && cd cMangos-tbc
cd etc && git clone https://github.com/cmangos/mangos-tbc
git clone https://github.com/cmangos/tbc-db && cd ..

# check .env for correct ID and the client path
docker-compose up compile # 20+ min
docker-compose up extract # 20+ min
# Optional. Remove compile and extract containers.
docker-compose down

# Populate the database.
docker-compose up -d mariadb # 5+ min
# Check logs, Ctrl-c to stop checking
docker-compose logs -f

# Copy all conf.dist files to conf
for i in server/etc/*.dist; do cp -- "$i" "${i%.conf.dist}.conf"; done

# edit mangos.conf, otherwise mangos will shutdown after boot
# you can do 'remote admin' with 'telnet localhost 3443'
sed -i -e '/Console.Enable =/ s/=.*/= 0/' server/etc/mangosd.conf
sed -i -e '/Ra.Enable =/ s/=.*/= 1/' server/etc/mangosd.conf

# Start realmd, mangosd and mariadb (if needed)
docker-compose up -d
# First time is a bit slow. Next start will be ~10s
docker-compose stop # stops all containers. 
# To start the server again
docker-compose start
```



### Some references

```bash
docker-compose down -h # shut down and remove all containers, network, volumes and images created by up.
docker-compose rm # remove all created containers, images is untuched
docker stop <ip> # shut down <id> container
docker system prune -a # deletes EVERYTHING NOT running. Only use if nothing else works.

docker ps # show all running machines with ID
docker images # list all images created, both running and stoppped. 

docker-compose up -d <name> # start <name> from docker-compose.yml
# -d means in background

# Rebuild 
docker-compose build --no-cache # recompile images
docker-compose up -d --force-recreate # recreate and start containers
docker-compose logs -f # show's all logs for the started containers.

```



## Preparations



Start by downloadning the cMangos-tbc repository from github. The repository has a basic config so you with minimal effort can have a server up and running.



```bash
git clone https://github.com/diff3/cMangos-tbc
cd cMangos-tbc
```



Next step is to download the source code from git. So switch to the etc folder and download.



```bash
cd etc
git clone https://github.com/cmangos/mangos-tbc
git clone https://github.com/cmangos/tbc-db
```



Last step before we can start to compile is to open cMangos-tbc root folder and edit the **.env** file. It's only three variables. In a linux system you can usually use 1000, you also need to add the absolute path to your installed client. Id you need to change the ID, see next section.



```bash
USER_ID=1000
GROUP_ID=1000
WOW_PATH=''
```



In a linux system all user got an ID. First user after root usualy get's id 1000. You can easely check this by typing **id** in a terminal. We need to use the same id as the owner of cMangos-tbc folders. We are doing this to fix any permission error then we are mounting **etc** and **server** folders into the containers. if you a running as user(id 1000) docker will translate it to root(id 1000). Root usually got id 0. 



```bash
id
id=1000(user) gid=1000(user) groups=1000(user)[...]
```



cMangos-tbc directory and subdirectories need to be owned by the same user you intend to run the server with! With matching ID in the .env file.



## Compile



The compile container will build everything needed to run the server. You can make some configurations in the **compile/compile.env** file. As default it will compile mangosd, realmd with playerbot and ahbot. It will also build all tools to extract data from the client. 
    You can change how many cores your prosessor got on the env file. Default is 8. More cores means faster compile time. In linux you can use **cat /proc/cpuinfo | grep "processor"| wc -l** to check how many cores you got.



To start compiling just type in as belove in cMangos-tbc root directory. i will take while. Then the build is complete, the container will close down.



```bash
docker-compose up compile
```



## Database



First time you start mangosdb it will populate and update the whole database it will take a while. All configuration can be down in the **mariadb/mariadb.env** file.





```Bash
docker-compose up mariadb 
# or 
docker-compose up -d mariadb
docker ps # copy the container id
docker logs <id>
```



## Extract

next we need to extract all data needed by the server from the client. Change WoW path in **.env** file to the location of your installed client. 

```bash
docker-compose up extract 
```



The container will close down then it's done. You can make some config in **extract/extract.env** file, by default it will extract high res maps, and dbc, maps, vmaps mmaps and save it to the server/data folder.



To make the server run, you need add config files, for a basic sever just go to server/etc and copy the config files.



```bash
cp server/etc/realmd.conf.dist server/etc/realmd.conf
cp server/etc/mangosd.conf.dist server/etc/mangosd.conf
```



## 

## Start server

Finaly we can start the server with. If you did't populate the database, it will take a while before all servers are started. realmd, and mangosd will reboot until the database is up and running.

```bash
docker-compose up -d
```





## Backup and restore





```bash
# Backup Account, Characters and Realmlist
docker exec -it tbc-mariadb sh -c 'exec mysqldump -uroot -ppwd tbcrealmd realmlist account realmcharacters --single-transaction' > tbc_realmd_data.sql

# Backup info about characters, will not include AH
docker exec -it tbc-mariadb sh -c 'exec mysqldump -uroot -ppwd --ignore-table=tbccharacters.auction --ignore-table=tbccharacters.ahbot.items tbccharacters --single-transaction' > tbc_characters_data.sql

# restore
docker exec -i tbc-mariadb sh -c "mysql -uroot -ppwd tbcrealmd" < tbc_realmd_data.sql
docker exec -i tbc-mariadb sh -c "mysql -uroot -ppwd tbccharacters" < tbc_characters_data.sql
```