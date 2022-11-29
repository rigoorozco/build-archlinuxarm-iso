FROM agners/archlinuxarm-arm64v8

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syyu --noconfirm base-devel git archlinux-keyring curl tar \
    dosfstools mtools erofs-utils arch-install-scripts rsync squashfs-tools xorriso

RUN git clone https://github.com/ironrobin/archiso-x13s.git && \
    cd archiso-x13s && \
    make install