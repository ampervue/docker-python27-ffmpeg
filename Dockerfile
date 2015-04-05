FROM ubuntu:trusty

MAINTAINER David Karchmer <dkarchmer@ampervue.com>

# Set Locale

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV YASM_VERSION    1.3.0

# =============================================================
# This is an image based on Ubuntu (trusty)
#      with Python 2.7
#      and  FFMPEG (latest from source)
#
# Basic libraries needed for Python 2.7 and for FFMPEG
# FFMPEG image is based on:
#      https://github.com/cellofellow/ffmpeg
#      https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
# =============================================================

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list; \
    apt-get update -qq && apt-get install -y --force-yes \
    autoconf \
    automake \
    build-essential \
    cmake \
    curl \
    git \
    libass-dev \
    libgpac-dev \
    libmp3lame-dev \
    libfontconfig-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libjpeg8-dev \
    libpng-dev \
    libtheora-dev \
    libtiff5-dev \
    libtool \
    libvdpau-dev \
    libvorbis-dev \
    mercurial \
    pkg-config \
    python2.7 \
    python2.7-dev \
    python-setuptools \
    python-numpy \
    texi2html \
    unzip \
    wget \
    zlib1g-dev; \
    apt-get clean




# Step 1: Build FFMPEG and related plugins
# ----------------------------------------

COPY          build.sh /tmp/build.sh
RUN           bash /tmp/build.sh

# Let's make sure the app built correctly
RUN           ffmpeg -buildconf


# Install pip
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python

