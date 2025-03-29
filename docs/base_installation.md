# Funktionalität

Die Hardware kann direkt oder über einen Dienst dazwischen angesprochen werden. Das ist bis Ubuntu ... noch PulseAudio. Ab Version ... ist das Pipwire. Dabei stellt ein Service einen Socket oder einen TCP Dienst zur Verfügung, der es ermöglicht, dass mehrere Anwendungen gleichzeitig auf die Soundkarte also das Mikrofon oder den Landsprecher zugreifen können.

# Vorwort
Es gibt ja mehrere Wege der Installation. Die Basis dafür ist Pipwire oder Pulseaudio, dafür stellen wir die jeweiligen Docker-Compose Files sowohl für den Pi-Voice-Assistant als auch für Snapcast zur Verfügung. 

Es gibt jedoch unterschiedliche Host Systeme, also die Basis auf die dies aufgebaut wird. Und damit auch die passt hier den dafür notwendigen Teil der Installation.

# Installation auf einem Raspberry Pi z.B. Zero 2W ohne UI







pactl load-module module-null-sink sink_name=Dummy
## maybe

sudo modprobe snd-bcm2835

## Bluetooth 

systemctl --user enable --now pipewire-pulse

## Testen

### All Devices, inkl. Virtual Devices
aplay -L

### Physische Geräte:

pactl list sinks
pactl list sources



# Installation auf xUbuntu







#########################################################################################

# TODO:
- Statt dem pi user einen eigenen user anlegen, der nicht einloggen kann.
- eine custom id vergeben


# NEU

# Debian

#  update package db
sudo apt update

# install base packages
sudo apt install -y pipewire wireplumber pipewire-audio-client-libraries

# For bluetooth
sudo apt install -y libspa-0.2-bluetooth pipewire-pulse

# PipeWire-ALSA-Brücke aktivieren
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/



# Ermögliche User-Dienste ohne aktive Session
sudo loginctl enable-linger pi



# 

export XDG_RUNTIME_DIR=/run/user/1000

select soundcard and set volumes

sudo alsactl store










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



# Wenn kein Audio kommt dann im alsamixer den passenden Ausgang auf laut stellen, z.B. Headphone ganz vorne

# Direct hardware test
speaker-test -D plughw:CARD=seeed2micvoicec,DEV=0 -c2 -twav

# check ob alsa als pipewire backend läuft
aplay -L | grep pipewire

# test über pipewire (mit default)
speaker-test -D pipewire -c2 -twav

# test über pipewire, genaues gerät
speaker-test -c2 -twav -D hw:CARD=seeed2micvoicec












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





# device setzen
export XDG_RUNTIME_DIR=/run/user/1000
pw-cli list-objects Node | less
pw-cli list-objects Node | grep -A10 "media.class = \"Audio/Source\"" # mics
pw-metadata -n settings 0 default.audio.sink "alsa_output.platform-soc_sound.stereo-fallback"
pw-metadata -n settings 0 default.audio.source "alsa_input.platform-soc_sound.mic"
pw-metadata


