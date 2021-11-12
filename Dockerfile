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

WORKDIR /root/hpl-2.3/setup
RUN bash make_generic \
  && mv Make.UNKNOWN Make.linux \
  && sed -i 's/\/hpl/\/hpl-2.3/g' Make.linux \
  && sed -i 's/UNKNOWN/linux/g' Make.linux 
  
WORKDIR /root/hpl-2.3
RUN ln -s setup/Make.linux Make.linux \
  && make arch=linux
  
WORKDIR /root/hpl-2.3/bin/linux