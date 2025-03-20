# Wyoming Satellite Audio Setup Guide

## Getting Started
You have two options to set up the Wyoming Satellite:

### Option 1: Using the Ready-to-Use Image
You can use the ready-to-use image which comes with all necessary configurations.

### Option 2: Manual Installation
Or you can install the Docker setup yourself by following the steps below:

## Manual Installation Steps

### 1. Update Package Database
```bash
sudo apt update
```

### 2. Install Audio System Dependencies
Install PipeWire and related packages:
```bash
sudo apt install -y pipewire wireplumber pipewire-audio-client-libraries
```

### 3. Install Bluetooth Support (Optional)
If you need Bluetooth audio functionality:
```bash
sudo apt install -y libspa-0.2-bluetooth pipewire-pulse
```

### 4. Activate PipeWire-ALSA Bridge
Link the PipeWire configuration to enable ALSA applications to use PipeWire:
```bash
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
```

### 5. Enable User Services Without Active Session
Allow services to run without an active user session:
```bash
sudo loginctl enable-linger pi
```

### 6. Set Runtime Directory
```bash
export XDG_RUNTIME_DIR=/run/user/1000
```
















select soundcard and set volumes

sudo alsactl store

## Audio Testing and Troubleshooting

### Listing Available Audio Devices
To view all available audio devices:
```bash
aplay -L
```
























root@sattelite-wohnzimmer:~# aplay -L
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
root@sattelite-wohnzimmer:~# 



## Wenn kein Audio kommt dann im alsamixer den passenden Ausgang auf laut stellen, z.B. Headphone ganz vorne

## Direct hardware test
speaker-test -D plughw:CARD=seeed2micvoicec,DEV=0 -c2 -twav

## check ob alsa als pipewire backend läuft
aplay -L | grep pipewire

## test über pipewire (mit default)
speaker-test -D pipewire -c2 -twav

## test über pipewire, genaues gerät
speaker-test -c2 -twav -D hw:CARD=seeed2micvoicec











## test im container:
im container:
exit
root@sattelite-wohnzimmer:~# docker exec -it satellite /bin/bash
root@sattelite-wohnzimmer:/app# aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default
    Default Audio Device
sysdefault
    Default Audio Device
hw:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Direct hardware device without any conversions
plughw:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Hardware device with all software conversions
default:CARD=vc4hdmi
    vc4-hdmi, MAI PCM i2s-hifi-0
    Default Audio Device
sysdefault:CARD=vc4hdmi
    vc4-hdmi, MAI PCM i2s-hifi-0
    Default Audio Device
hdmi:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    HDMI Audio Output
dmix:CARD=vc4hdmi,DEV=0
    vc4-hdmi, MAI PCM i2s-hifi-0
    Direct sample mixing device
hw:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Direct hardware device without any conversions
plughw:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Hardware device with all software conversions
default:CARD=seeed2micvoicec
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Default Audio Device
sysdefault:CARD=seeed2micvoicec
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Default Audio Device
dmix:CARD=seeed2micvoicec,DEV=0
    seeed-2mic-voicecard, 3f203000.i2s-wm8960-hifi wm8960-hifi-0
    Direct sample mixing device
root@sattelite-wohnzimmer:/app# 





neuer test:






new:


root@sattelite-wohnzimmer:~# docker exec -it satellite /bin/bash
I have no name!@sattelite-wohnzimmer:/app$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
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
pulse
    PulseAudio Sound Server
speex
    Plugin using Speex DSP (resample, agc, denoise, echo, dereverb)
upmix
    Plugin for channel upmix (4,6,8)
vdownmix
    Plugin for channel downmix (stereo) with a simple spacialization
default
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







cat /proc/asound/cards


pw-cli info 0



wpctl status





## device setzen
export XDG_RUNTIME_DIR=/run/user/1000
pw-cli list-objects Node | less
pw-cli list-objects Node | grep -A10 "media.class = \"Audio/Source\"" # mics
pw-metadata -n settings 0 default.audio.sink "alsa_output.platform-soc_sound.stereo-fallback"
pw-metadata -n settings 0 default.audio.source "alsa_input.platform-soc_sound.mic"
pw-metadata


