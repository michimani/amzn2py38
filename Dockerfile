FROM amazonlinux:2.0.20200406.0

RUN yum -y install \
    gcc \
    openssl-devel \
    bzip2-devel \
    libffi-devel \
    wget \
    tar \
    gzip \
    make && \
    wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz && \
    tar xzf Python-3.8.3.tgz && \
    cd Python-3.8.3 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd ~ && \
    rm -rf /var/cache/yum/* && \
    rm -rf /Python-3.8.3
RUN python3.8 -V
RUN pip3.8 -V