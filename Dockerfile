FROM lsiobase/alpine:3.9

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \ 
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
    && apk --update --no-cache add \
         xrdp \
         xvfb \
         alpine-desktop \
         xfce4 \
         thunar-volman \
         faenza-icon-theme \
         slim \
         xf86-input-synaptics \
         xf86-input-mouse \
         xf86-input-keyboard \
         setxkbmap \
         sudo \
         util-linux \
         dbus \
         ttf-freefont \
         xauth \
         supervisor \
         busybox-suid \
         openssl \
         nano \
         ossp-uuid \
         x11vnc \
         openssh \
         firefox \
    && xrdp-keygen xrdp auto \
    && sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
    && sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

COPY root /

EXPOSE 3389 22
#WORKDIR /home/alpine
#USER alpine xrdp
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
