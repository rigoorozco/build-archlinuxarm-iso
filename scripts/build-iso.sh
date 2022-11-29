#!/bin/bash

# This script is meant to be run inside Docker

WORK_DIR=/work
OUTPUT_DIR=/output
PROJECT_DIR=/archiso
GPG_KEY=4C3CE98F9579981C21CA1EC3465022E743D71E39

echo "Running Docker build script.."

# echo "Pointing Docker alarm and aur repos to aarch64-mirrorlist"
# cp ${PROJECT_DIR}/configs/x13s/airootfs/etc/pacman.d/mirrorlist /etc/pacman.d/aarch64-mirrorlist 
# && \
# sed -zi 's/\n\[alarm\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[alarm\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' /etc/pacman.conf && \
# sed -zi 's/\n\[aur\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[aur\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' /etc/pacman.conf

# echo -e "\n[x13]\nServer = https://lecs.dev/repo" >> /etc/pacman.conf

echo "Point install repos to aarch64-mirrorlist"
sed -i 's/auto/aarch64/' ${PROJECT_DIR}/configs/x13s/pacman.conf && \
sed -zi 's/\n\[core\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[core\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' ${PROJECT_DIR}/configs/x13s/pacman.conf && \
sed -zi 's/\n\[extra\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[extra\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' ${PROJECT_DIR}/configs/x13s/pacman.conf && \
sed -zi 's/\n\[community\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[community\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' ${PROJECT_DIR}/configs/x13s/pacman.conf && \
sed -zi 's/\n\[alarm\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[alarm\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' ${PROJECT_DIR}/configs/x13s/pacman.conf && \
sed -zi 's/\n\[aur\]\nInclude = \/etc\/pacman.d\/mirrorlist/\n\[aur\]\nInclude = \/etc\/pacman.d\/aarch64-mirrorlist/' ${PROJECT_DIR}/configs/x13s/pacman.conf

curl -O https://lecs.dev/repo/public.asc && \
pacman-key --add public.asc && \
pacman-key --lsign 9FD0B48BBBD974B80A3310AB6462EE0B8E382F3F

cd ${PROJECT_DIR}

sudo mkarchiso -v          \
	-w ${WORK_DIR}    \
	-o ${OUTPUT_DIR}  \
	-g ${GPG_KEY}     \
	configs/x13s/

