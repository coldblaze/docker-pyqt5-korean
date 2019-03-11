FROM ubuntu:18.04

LABEL maintainer="https://github.com/coldblaze"

# Install sshd, Python3, PyQt5 and packages for Korean
RUN apt-get update -qq -y \
  && apt-get install -qq -y \
     locales \
     language-pack-ko \
  && locale-gen ko_KR.UTF-8 \
  && update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX \
  && echo "export XMODIFIERS=@im=nabi" >> /root/.bashrc \
  && apt-get install -qq -y openssh-server \
  && echo 'root:root'|chpasswd \
  && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
  && sed -ri 's/^#?X11Forwarding\s+.*/X11Forwarding yes/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?X11DisplayOffset\s+.*/X11DisplayOffset 10/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?X11UseLocalhost\s+.*/X11UseLocalhost no/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?PrintMotd\s+.*/PrintMotd no/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?PrintLastLog\s+.*/PrintLastLog yes/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config \
  && apt-get install -qq -y \
     net-tools \
     iputils-ping \
     fonts-nanum fonts-nanum-extra nabi \
     python3 \
     python3-pyqt5 python3-pyqt5.qtwebengine \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=ko_KR.UTF-8
ENTRYPOINT service ssh restart && bash
WORKDIR /root
