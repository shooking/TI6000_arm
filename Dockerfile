FROM alpine:3.14 AS os_base
RUN \
  apk add curl bash

WORKDIR /root
FROM os_base AS ti
RUN curl https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-vqU2jj6ibH/8.2.10/ti_cgt_c6000_8.2.10_armlinuxa8hf_busybox_installer.sh --output installer.sh && \
chmod +x installer.sh && \
./installer.sh

WORKDIR /
FROM ti AS entrypoint
COPY ./entrypoint.sh /

# Set environment variables.
ENV HOME=/root
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
