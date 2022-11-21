FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y tzdata build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev libtool libssl-dev grep binutils zlibc libbz2-dev cmake libboost-all-dev
RUN mkdir -p /opt/mangos-tbc/build
WORKDIR /opt/mangos-tbc/build

COPY entry.sh / 
RUN chmod +x /entry.sh
CMD /entry.sh