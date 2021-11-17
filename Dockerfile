FROM debian:stretch-backports
ARG ARCH=porthos
ARG HPL_VERSION=2.3
ARG HPL_TAR_GZ=https://www.netlib.org/benchmark/hpl/hpl-${HPL_VERSION}.tar.gz

RUN apt-get update -y
RUN apt-get install -y \
    libibverbs1=16.0-1~bpo9+1 \
    libibverbs-dev=16.0-1~bpo9+1 \
    build-essential \
    libopenblas-dev \
    libopenmpi2 \
    libopenmpi-dev \
    ibverbs-utils \
    openmpi-bin \
    gfortran \
    openssh-client

ADD ${HPL_TAR_GZ} hpl.tar.gz
RUN tar -xzf hpl.tar.gz && \
    mv hpl-${HPL_VERSION} /root/hpl && \
    rm hpl.tar.gz
COPY Make.${ARCH} /root/hpl

RUN cd /root/hpl && make arch=${ARCH}

WORKDIR /root/hpl/bin/${ARCH}