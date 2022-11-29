FROM archlinux:base-devel as builder

COPY sudoers.d/build /etc/sudoers.d/

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syyu --noconfirm base-devel git archlinux-keyring curl tar reflector \
    dosfstools mtools erofs-utils arch-install-scripts rsync squashfs-tools xorriso && \
    # we do this mostly just because a lot of mirrors are unreliable
    reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

RUN git clone https://github.com/ironrobin/archiso-x13s.git && \
    cd archiso-x13s && \
    make install && cd - 

RUN git clone https://github.com/archlinuxarm/archlinuxarm-keyring.git && \
    cd archlinuxarm-keyring && \
    make install PREFIX=/usr && cd - && \
    pacman-key --populate archlinuxarm