FROM ubuntu:18.04
LABEL maintainer="Jacco Veldscholten <info@twentsedrone.nl>"

ENV DEBIAN_FRONTEND noninteractive

# Install ARM GNU embedded toolchain
# For updates, see https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
ARG ARM_URLBASE=https://developer.arm.com/-/media/Files/downloads/gnu-rm
ARG ARM_URL=${ARM_URLBASE}/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
ARG ARM_MD5=fe0029de4f4ec43cf7008944e34ff8cc
ARG ARM_FOLDER=gcc-arm-none-eabi-9-2019-q4-major


RUN \
    dpkg --add-architecture i386 >&2 && \
    echo 'Update the package index files to latest available versions' >&2 && \
    apt-get update \
    && echo 'Installing native toolchain and build system functionality' >&2 && \
    apt-get -y --no-install-recommends install \
        afl++ \
        git \
        automake \
        bsdmainutils \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        curl \
        gcc-multilib \
        gdb \
        g++-multilib \
        libffi-dev \
        libpcre3 \
        libtool \
        m4 \
        ninja-build \
        parallel \
        protobuf-compiler \
        python \
        python3-setuptools \
        python3-wheel \
        p7zip \
        rsync \
        ssh-client \
        subversion \
        unzip \
        vim-common \
        xsltproc \
        nano \
    && echo 'Cleaning up installation files' >&2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'Installing arm-none-eabi toolchain from arm.com' >&2 && \
    mkdir -p /opt && \
    curl -L -o /opt/gcc-arm-none-eabi.tar.bz2 ${ARM_URL} && \
    echo "${ARM_MD5} /opt/gcc-arm-none-eabi.tar.bz2" | md5sum -c && \
    tar -C /opt -jxf /opt/gcc-arm-none-eabi.tar.bz2 && \
    rm -f /opt/gcc-arm-none-eabi.tar.bz2 && \
    echo 'Removing documentation' >&2 && \
    rm -rf /opt/gcc-arm-none-eabi-*/share/doc
    # No need to dedup, the ARM toolchain is already using hard links for the duplicated files

ENV PATH ${PATH}:/opt/${ARM_FOLDER}/bin
# Get New Repo
RUN git clone https://github.com/RIOT-OS/RIOT.git

# Prepare RIOT Project
RUN mkdir RIOT/projects
