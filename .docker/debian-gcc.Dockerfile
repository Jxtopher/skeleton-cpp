# Get the GCC preinstalled image from Docker Hub
FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Acquire::http::Proxy \"http://192.168.42.154:8000\";" > /etc/apt/apt.conf.d/00aptproxy
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
WORKDIR /usr/src/app/build

RUN rm -rf /usr/src/app/build/*
RUN cmake ..
RUN make -j $(nproc)

# Run the program output from the previous step
CMD ["./skeleton"]
