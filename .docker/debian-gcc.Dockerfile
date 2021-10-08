# Get the GCC preinstalled image from Docker Hub
FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Acquire::http::Proxy \"http://192.168.1.72:8000\";" > /etc/apt/apt.conf.d/00aptproxy
RUN apt-get update -y && \ 
apt-get install -y build-essential \
cmake \
libcppunit-dev \
cppcheck \
clang-tidy \
libboost-program-options-dev \
ccache \
gcovr \
pkg-config \
python3

COPY . /usr/src/app
WORKDIR /usr/src/app/

RUN rm -rf /usr/src/app/build/*
RUN cmake -B /usr/src/app/build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build /usr/src/app/build --config Release -j ${nproc}

WORKDIR /usr/src/app/build/
