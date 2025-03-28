# wyoming-satellite - Installation - Docker

## Features
- Pre-built Docker image for Wyoming Satellite
- Supports multiple architectures (linux/amd64 and linux/aarch64)
- Automated builds with artifact attestation for security

For Raspberry Pi users: Check out [PiCompose](https://github.com/florian-asche/PiCompose) for a Pi-Ready image with pipewire-server (audio-server).

## Usage

For a complete example configuration, check out the `docker-compose.yml` file in this repository. If you dont use the seedstudio hat, you dont need the ledcontrol container.

To run the Snapcast client, specify the host ID and use the snapclient entrypoint:

```bash
docker run --rm -it \
  --network host \
  --device /dev/snd:/dev/snd \
  --device /dev/bus/usb \
  --group-add audio \
  -e START_SNAPCLIENT=true \
  -e PIPEWIRE_RUNTIME_DIR=/run \
  -e XDG_RUNTIME_DIR=/run \
  --volume /run/user/1000/pipewire-0:/run/pipewire-0 \
  --entrypoint=/usr/bin/snapclient \
  ghcr.io/florian-asche/docker-snapcast:latest \
  --host 192.168.33.5 \
  --hostID client1 \
  --soundcard pipewire
```

### Parameter Overview

| Parameter | Description |
|-----------|-------------|
| `--network host` | Uses the host's network stack for better audio streaming performance |
| `--device /dev/snd:/dev/snd` | Gives access to the host's sound devices |
| `--device /dev/bus/usb` | Enables access to USB audio devices |
| `--group-add audio` | Adds the container to the host's audio group for sound device access |
| `-e START_SNAPCLIENT=true` | Ensures the Snapcast client starts automatically |
| `-e PIPEWIRE_RUNTIME_DIR=/run` | Sets the Pipewire runtime directory |
| `-e XDG_RUNTIME_DIR=/run` | Sets the XDG runtime directory for Pipewire |
| `--volume /run/user/1000/pipewire-0:/run/pipewire-0` | Mounts the Pipewire socket for audio streaming |
| `--host <IP>` | IP address of the Snapcast server |
| `--hostID <name>` | Unique identifier for this client |
| `--soundcard pipewire` | Uses Pipewire as the audio backend |

## Build Information

Image builds can be tracked in this repository's `Actions` tab, and utilize [artifact attestation](https://docs.github.com/en/actions/security-guides/using-artifact-attestations-to-establish-provenance-for-builds) to certify provenance.

The Docker images are built using GitHub Actions, which provides:

- Automated builds for different architectures
- Artifact attestation for build provenance verification
- Regular updates and maintenance

### Available Tags

- `latest`: Latest stable release
- `nightly`: Builds from the main branch (may be unstable)
- Version-specific tags (e.g., `0.31.0-1__0.1`): Stable releases

### Build Process

The build process includes:

- Multi-architecture support (linux/amd64 and linux/aarch64)
- Security verification through artifact attestation
- Automated testing and validation
- Regular updates to maintain compatibility

For more information about the build process and available architectures, please refer to the Actions tab in this repository.
