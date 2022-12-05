FROM mariadb:latest
COPY --chmod=755 InstallFullDB.sh InstallFullDB.config /etc
COPY --chmod=755 entry.sh /docker-entrypoint-initdb.d
