FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y libmysql++3v5 libssl1.1 tzdata
WORKDIR /opt/server/bin
CMD ./mangosd