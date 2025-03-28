# wyoming-satellite - Installation - Docker

## Features

- Pre-built Docker image for Wyoming Satellite
- Supports multiple architectures (linux/amd64 and linux/aarch64)
- Automated builds with artifact attestation for security
- Integrated wake word detection with OpenWakeWord
- LED control support for Seeed Studio 2-mic HAT

For Raspberry Pi users: Check out [PiCompose](https://github.com/florian-asche/PiCompose) for a Pi-Ready image with pipewire-server (audio-server).

## Installation

### Getting Started
You have two options to set up the Wyoming Satellite:

#### Option 1: Using the Ready-to-Use Image
You can use the ready-to-use image which comes with all necessary system configurations.

Check out [PiCompose](https://github.com/florian-asche/PiCompose)

#### Option 2: Manual Installation
Or you can install the Docker setup yourself by following the steps below:

##### 1. Update Package Database
```bash
sudo apt update
```

##### 2. Install Audio System Dependencies
Install PipeWire and related packages:
```bash
sudo apt install -y pipewire wireplumber pipewire-audio-client-libraries
```

##### 3. Install Bluetooth Support (Optional)
If you need Bluetooth audio functionality:
```bash
sudo apt install -y libspa-0.2-bluetooth pipewire-pulse
```

##### 4. Activate PipeWire-ALSA Bridge
Link the PipeWire configuration to enable ALSA applications to use PipeWire:
```bash
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
```

##### 5. Enable User Services Without Active Session
Allow services to run without an active user session:
```bash
sudo loginctl enable-linger pi
```

##### 6. Set Runtime Directory
```bash
export XDG_RUNTIME_DIR=/run/user/1000
```













## Usage

For a complete example configuration, check out the `docker-compose.yml` file in this repository. The setup includes three main services:

- `satellite`: Main service for voice command processing
- `openwakeword`: Wake word detection service
- `ledcontrol`: LED control for Seeed Studio 2-mic HAT (optional)

To run the satellite service manually:

```bash
docker run --rm -it \
  --network host \
  --device /dev/snd:/dev/snd \
  --device /dev/bus/usb \
  --group-add audio \
  -e PIPEWIRE_RUNTIME_DIR=/run \
  -e XDG_RUNTIME_DIR=/run \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume /etc/timezone:/etc/timezone:ro \
  --volume /run/user/1000/pipewire-0:/run/pipewire-0 \
  ghcr.io/florian-asche/wyoming-satellite:latest \
  --debug \
  --name "satellite-wohnzimmer" \
  --vad \
  --mic-auto-gain 5 \
  --mic-noise-suppression 2 \
  --mic-command "arecord -D pipewire -r 16000 -c 1 -f S16_LE -t raw" \
  --snd-command "aplay -D pipewire -r 22050 -c 1 -f S16_LE -t raw" \
  --wake-uri "tcp://127.0.0.1:10400" \
  --wake-word-name "hey_jarvis" \
  --event-uri "tcp://127.0.0.1:10500"
```

### Parameter Overview

**Note:** The most important parameters to configure are `--name` (unique identifier for your satellite instance) and `--wake-word-name` (name of the wake word to detect).

| Parameter                                            | Description                                          |
| ------------------------------------------------------ | ------------------------------------------------------ |
| `--network host`                                     | Uses the host's network stack for better performance |
| `--device /dev/snd:/dev/snd`                         | Gives access to the host's sound devices             |
| `--device /dev/bus/usb`                              | Enables access to USB audio devices                  |
| `--group-add audio`                                  | Adds the container to the host's audio group         |
| `-e PIPEWIRE_RUNTIME_DIR=/run`                       | Sets the Pipewire runtime directory                  |
| `-e XDG_RUNTIME_DIR=/run`                            | Sets the XDG runtime directory for Pipewire          |
| `--volume /run/user/1000/pipewire-0:/run/pipewire-0` | Mounts the Pipewire socket                           |
| **`--name`**                                         | Unique identifier for this satellite instance |
| `--vad`                                              | Enables Voice Activity Detection                     |
| `--mic-auto-gain`                                    | Sets microphone auto gain level (0-10)               |
| `--mic-noise-suppression`                            | Sets noise suppression level (0-3)                   |
| `--mic-command`                                      | Command to capture audio input                       |
| `--snd-command`                                      | Command to play audio output                         |
| `--wake-uri`                                         | URI for wake word detection service                  |
| **`--wake-word-name`**                               | Name of the wake word to detect |
| `--event-uri`                                        | URI for event handling                               |

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
