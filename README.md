# build-archlinuxarm-iso

Creates an Arch Linux ARM ISO inside of a Docker containter using ````qemu````

*NOTE* this requires packages ````qemu-user-static-binfmt```` and ````qemu-user-static-binfmt```` to be installed on x86_64 host.

## Usage

To build ISO in Docker run the following command:
```
./scripts/run-docker-build.sh
```

Alternitavely, this can be run natively on ARM64 using the following command:

```
./scripts/build-iso.sh
```
