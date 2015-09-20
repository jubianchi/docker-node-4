FROM progrium/busybox

MAINTAINER Julien Bianchi <contact@jubianchi.fr>

RUN sed -i 's?x86_64/packages/?x86_64/generic/packages/?' /etc/opkg.conf && \
    opkg-cl update && \
    opkg-cl upgrade && \
    opkg-install curl bash libstdcpp && \
    rm -f /lib/libpthread.so.0 && \
    ln -s /lib/libpthread-2.18.so /lib/libpthread.so.0

RUN curl -s http://nodejs.org/dist/v4.1.0/node-v4.1.0-linux-x64.tar.gz | gunzip | tar -xf - -C /

RUN rm -rf /tmp/* /var/tmp/*

ENV PATH /node-v4.1.0-linux-x64/bin:$PATH

ENTRYPOINT ["/node-v4.1.0-linux-x64/bin/node"]
