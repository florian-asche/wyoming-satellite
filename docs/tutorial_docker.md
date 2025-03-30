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
You can download the ready-to-use image which comes with all necessary system configurations.

Check out [PiCompose](https://github.com/florian-asche/PiCompose)

You just have to copy the docker-compose from here. More information in the PiCompose project.

After the first boot the board will automatically reboot one more time. Then you can copy your compose files if you already havent. Then you need to reboot the board one more time in order to activate the 2MicHat drivers if you use that hardware.

#### Option 2: Manual Installation
Or you can install the Docker setup yourself by following the steps below:

##### 1. Manual Installation - Install Pipewire Audio System
Update Package Database:
```bash
sudo apt update
```

Install PipeWire and related packages:
```bash
sudo apt install -y pipewire wireplumber pipewire-audio-client-libraries
```

If you need Bluetooth audio functionality:
```bash
sudo apt install -y libspa-0.2-bluetooth pipewire-pulse
```

Link the PipeWire configuration to enable ALSA applications to use PipeWire:
```bash
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
```

Allow services to run without an active user session:
```bash
sudo loginctl enable-linger pi
```

##### 2. Manual Installation - Install 2mic_hat driver (Optional)

If you are using the Seeed Studio 2mic_hat, 4mic_hat, or 6mic_hat hardware, you need to install the corresponding drivers.

First, install the required system dependencies:

```bash
sudo apt-get update
sudo apt-get install -y git build-essential dkms curl raspberrypi-kernel-headers i2c-tools libasound2-plugins alsa-utils
```

Download and run the installation script:

```bash
curl -o install_driver.sh https://raw.githubusercontent.com/florian-asche/PiCompose/refs/heads/feature/initial-base/stage-picompose/02-seedstudio_2michat_driver/02-run-chroot.sh
chmod +x install_driver.sh
sudo ./install_driver.sh
```

Install the systemd service:
```bash
sudo curl -o /etc/systemd/system/seeed-voicecard.service https://raw.githubusercontent.com/florian-asche/PiCompose/feature/initial-base/stage-picompose/02-seedstudio_2michat_driver/files/seeed-voicecard.service
sudo curl -o /usr/bin/seeed-voicecard-v2 https://raw.githubusercontent.com/florian-asche/PiCompose/feature/initial-base/stage-picompose/02-seedstudio_2michat_driver/files/seeed-voicecard-v2
sudo chmod +x /usr/bin/seeed-voicecard-v2
```

Enable the service:
```bash
sudo systemctl daemon-reload
sudo systemctl enable seeed-voicecard.service
```

After installing the drivers, you need to reboot the satellite:
```bash
sudo reboot
```

##### 2. Manual Installation - Debugging Audio (Optional)

###### Set Runtime Directory (Mandatory)
If you work with the root user, you need to:
```bash
export XDG_RUNTIME_DIR=/run/user/1000
```

###### Audio Troubleshooting Tips
If no audio is playing:
1. Check the appropriate output in alsamixer (e.g., set Headphone output to maximum)
2. Verify the audio device is properly connected and recognized
3. Ensure the correct audio device is selected in your system settings

###### Hardware Testing Commands
Test the Seeed Studio 2-mic HAT directly:
```bash
speaker-test -D plughw:CARD=seeed2micvoicec,DEV=0 -c2 -twav
```

Test audio through PipeWire:
```bash
speaker-test -D pipewire -c2 -twav
```

###### Audio Mixer
If no audio is playing, adjust the output volume in alsamixer, for example, set the Headphone output to maximum.

Check and adjust volume levels for both standard and Seeed Studio sound cards:
- Switch between cards using F6
- Use alsamixer to adjust volume levels:
```bash
alsamixer
```

###### List Available Audio Devices
View all available audio devices and their configurations:
```bash
aplay -L
```

Example output:
```
null
    Discard all samples (playback) or generate zero samples (capture)
sysdefault
    Default Audio Device
lavrate
    Rate Converter Plugin Using Libav/FFmpeg Library
samplerate
    Rate Converter Plugin Using Samplerate Library
speexrate
    Rate Converter Plugin Using Speex Resampler
jack
    JACK Audio Connection Kit
oss
    Open Sound System
pipewire
    PipeWire Sound Server
pulse
    PulseAudio Sound Server
speex
    Plugin using Speex DSP (resample, agc, denoise, echo, dereverb)
upmix
    Plugin for channel upmix (4,6,8)
vdownmix
    Plugin for channel downmix (stereo) with a simple spacialization
default
playback
capture
dmixed
array
hw:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Direct hardware device without any conversions
plughw:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Hardware device with all software conversions
sysdefault:CARD=vc4hdmi
    vc4-hdmi, MAI PCM i2s-hifi-0
    Default Audio Device
hdmi:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    HDMI Audio Output
dmix:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Direct sample mixing device
usbstream:CARD=vc4hdmi
    vc4-hdmi
    USB Stream Output
hw:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Direct hardware device without any conversions
plughw:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Hardware device with all software conversions
sysdefault:CARD=seeed2micvoicec
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Default Audio Device
dmix:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Direct sample mixing device
usbstream:CARD=seeed2micvoicec
    seeed-2mic-voicecard
    USB Stream Output
```

###### List PipeWire Objects
List all PipeWire objects and nodes:
```bash
pw-cli list-objects Node
```

##### 3. Manual Installation - Install Docker

First, update the package database and install prerequisites:
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```

Add Docker's official GPG key:
```bash
# Create directory for Docker GPG key
mkdir -p /etc/apt/keyrings

# Download and add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set proper permissions for the GPG key
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

Set up the Docker repository:
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update package lists and install Docker:
```bash
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Install additional useful packages:
```bash
sudo apt-get install -y git jq curl wget vim htop python3 python3-pip
```

##### 4. Manual Installation - Use Docker

For a complete example configuration, check out the `docker-compose.yml` file in this repository. The setup includes three main services:

- `satellite`: Main service for voice command processing
- `openwakeword`: Wake word detection service
- `ledcontrol`: LED control for Seeed Studio 2-mic HAT (optional)

To get started with the docker-compose setup:

1. Clone the repository and navigate to the project directory:
```bash
git clone https://github.com/florian-asche/wyoming-satellite.git
cd wyoming-satellite
```

3. Edit the docker-compose.yml file to customize your settings:
```bash
vi docker-compose.yml
```

4. Start the services using docker-compose:
```bash
docker-compose up -d
```

5. Check the status of your services:
```bash
docker-compose ps
```

6. View the logs of all services:
```bash
docker-compose logs -f
```

To stop the services:
```bash
docker-compose down
```

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

## Parameter Overview

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
- Version-specific tags (e.g., `1.5.0`): Stable releases???????

### Build Process

The build process includes:

- Multi-architecture support (linux/amd64 and linux/aarch64)
- Security verification through artifact attestation
- Automated testing and validation
- Regular updates to maintain compatibility

For more information about the build process and available architectures, please refer to the Actions tab in this repository.
