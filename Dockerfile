FROM ubuntu:18.04

WORKDIR /root
RUN apt-get update -y
RUN apt-get install -y \
  build-essential \
  libbz2-dev \
  python3 \
  python3-dev \
  python3-pip \
  libblas-dev \
  mpich \
  libmpich-dev \
  gawk \ 
  vim \
  && pip3 install --upgrade pip

ADD hpl-2.3.tar.gz .

WORKDIR /root/hpl-2.3
RUN ./configure && make