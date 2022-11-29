FROM agners/archlinuxarm-arm64v8

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syyu --noconfirm base-devel git archlinux-keyring curl tar \
    dosfstools mtools erofs-utils arch-install-scripts rsync squashfs-tools xorriso

