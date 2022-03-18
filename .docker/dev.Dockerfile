FROM gcc:11.2.0

ARG DEBIAN_FRONTEND=noninteractive

# Package installation 
RUN apt-get update -y && \ 
apt-get install -y --no-install-recommends build-essential \
cmake \
libcppunit-dev \
cppcheck \
clang-tidy \
libboost-program-options-dev \
ccache \
gcovr \
pkg-config \
doxygen \
python3 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
