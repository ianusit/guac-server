FROM debian:jessie
MAINTAINER Ianus IT GmbH <info@ianus-it.de>

RUN apt-get update &&\
    apt-get install -y make gcc tzdata ca-certificates libcairo2 libcairo2-dev libjpeg62-turbo libjpeg62-turbo-dev libpng12-0 libpng12-dev libfreerdp-client1.1 libfreerdp-dev libpango1.0 libpango1.0-dev libssh2-1 libssh2-1-dev libossp-uuid16 libossp-uuid-dev libssl1.0.0 libssl-dev libvncserver0 libvncserver-dev libpulse0 libpulse-dev  libvorbis0a libvorbisenc2 libvorbis-dev wget &&\
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime &&\
    echo "Europe/Berlin" > /etc/timezone &&\
    wget --content-disposition -O -  http://sourceforge.net/projects/guacamole/files/current/source/guacamole-server-0.9.8.tar.gz/download | tar xfvz - &&\
    cd guacamole-server-0.9.8 &&\
    ./configure --with-init-dir=/etc/init.d &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -rf guacamole-server-0.9.8 &&\
    apt-get remove -y make gcc libcairo2-dev libjpeg62-turbo-dev libpng12-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libossp-uuid-dev libssl-dev libvncserver-dev libpulse-dev libvorbis-dev wget && \
    apt-get autoremove -y

CMD [ "/usr/local/sbin/guacd", "-b", "0.0.0.0", "-f" ]
