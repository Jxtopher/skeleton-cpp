FROM gcc:12.1.0

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
    graphviz \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -ms /bin/bash user \
    && chmod 660 /etc/sudoers && echo "user ALL=NOPASSWD: ALL" >> /etc/sudoers && chmod 400 /etc/sudoers

WORKDIR /app

ENTRYPOINT ["su", "user"]
