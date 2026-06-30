## To run this image using podman:
## 1. podman build --platform linux/x86-64 -t st-build -f st-build.dockerfile
## 2. podman run -it --platform linux/x86-64 --name st-build --device /dev/fuse --cap-add SYS_ADMIN --security-opt unmask=ALL st-build:latest

# Use the official Debian Bullseye (EOL:08/2026) for older GLIBC
FROM debian:bullseye

# Install dependencies
RUN apt update && apt full-upgrade -y && apt install -y zip git build-essential libxft-dev libimlib2-dev pkg-config curl wget file fuse appstream sudo man

# Copy st source code
RUN cd && git clone https://github.com/vishnu350/st && cd st && make patch
RUN echo "alias ll='ls -lrt' && bind '\"\e[A\": history-search-backward' && bind '\"\e[B\": history-search-forward'" >> ~/.bashrc
WORKDIR /root/st
CMD ["/bin/bash"]
