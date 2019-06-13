FROM alpine:edge

RUN apk --update --no-cache add \
      xrdp \
      xvfb \
      alpine-desktop \
      xfce4 \
      thunar-volman \
      faenza-icon-theme \
      slim xf86-input-synaptics \
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
      firtefox
COPY root /

RUN xrdp-keygen xrdp auto \
    && sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
    && sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
    && addgroup alpine \
    && adduser  -G alpine -s /bin/sh -D alpine \
    && echo "alpine:alpine" | /usr/sbin/chpasswd \
    && echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers

EXPOSE 3389 22
#WORKDIR /home/alpine
#USER alpine xrdp
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
