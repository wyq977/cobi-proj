FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# See https://gitlab.kitware.com/vtk/vtk/blob/master/Documentation/dev/build.md
# and https://github.com/wowa/vtk-docker/blob/master/Dockerfile
# and https://github.com/ataber/vtk_docker/blob/master/Dockerfile

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -qq -y \
    # packages needed
    # See https://gitlab.kitware.com/vtk/vtk/blob/master/Documentation/dev/build.md
    build-essential \
    cmake \
    mesa-common-dev \
    freeglut3-dev \
    ninja-build \
    git \
    # packages required as per https://git.bsse.ethz.ch/iber/Publications/stopka-notch/blob/master/README.txt
    libboost-dev \
    doxygen \
	&& rm -rf /var/lib/apt/lists/*

# release branch always raise error during cmake
WORKDIR /tmp
RUN git clone --single-branch --branch v8.2.0 https://gitlab.kitware.com/vtk/vtk.git && \
    mkdir /tmp/vtk-build

# No in-source build
WORKDIR /tmp/vtk-build
RUN cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX:STRING=/usr/lib/vtk \
    /tmp/vtk

# build
RUN make --silent -j $(cat /proc/cpuinfo | grep processor | wc -l) VERBOSE=1 && \
    make install --silent

# clean up
WORKDIR /tmp
RUN rm -rf vtk

ENV VTK_DIR /usr/lib/vtk
ENV DEBIAN_FRONTEND=dialog
