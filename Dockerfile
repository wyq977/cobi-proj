FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# See https://gitlab.kitware.com/vtk/vtk/blob/master/Documentation/dev/build.md
# and https://github.com/wowa/vtk-docker/blob/master/Dockerfile
# and https://github.com/ataber/vtk_docker/blob/master/Dockerfile

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -qq -y \
    build-essential \
    cmake \
    mesa-common-dev \
    freeglut3-dev \
    ninja-build \
    git \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone --single-branch --branch release https://gitlab.kitware.com/vtk/vtk.git

# cmake
WORKDIR /tmp/vtk
RUN cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX:STRING=/usr/lib/vtk \
    .

# build
RUN make --silent -j $(cat /proc/cpuinfo | grep processor | wc -l) VERBOSE=1 && \
    make install --silent

WORKDIR /tmp
RUN rm -rf vtk

ENV VTK_DIR /usr/lib/vtk
ENV DEBIAN_FRONTEND=dialog
