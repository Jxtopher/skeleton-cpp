FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Acquire::http::Proxy \"http://192.168.42.27:8000\";" > /etc/apt/apt.conf.d/00aptproxy

# Package installation 
RUN apt-get update -y && \ 
apt-get install -y --no-install-recommends build-essential \
clang \
libomp-dev \
cmake \
libcppunit-dev \
cppcheck \
clang-tidy \
libboost-program-options-dev \
ccache \
gcovr \
pkg-config \
python3 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++

COPY . /usr/src/app
WORKDIR /usr/src/app/

RUN rm -rf /usr/src/app/build/*                                    \
&& cmake -B /usr/src/app/build -DCMAKE_BUILD_TYPE=Release          \
&& cmake --build /usr/src/app/build --config Release -j "$(nproc)"

WORKDIR /usr/src/app/build/
