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






funktioniert:
wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 0.5

wpctl status

wpctl set-default ID

default.route.alsa_card.platform-soc_sound = {
   sink = "headphone"
}




amixer -c seeed2micvoicec set Headphone 100%
alsactl store


root@sattelite-wohnzimmer:~# alsactl info seeed2micvoicec
#
# Sound card
#
- card: 1
  id: seeed2micvoicec
  name: seeed-2mic-voicecard
  longname: seeed-2mic-voicecard
  driver_name: simple-card
  mixer_name: 
  components: 
  controls_count: 58
  pcm:
    - stream: PLAYBACK
      devices:
        - device: 0
          id: 3f203000.i2s-wm8960-hifi wm8960-hifi-0
          name: 3f203000.i2s-wm8960-hifi wm8960-hifi-0
          subdevices:
            - subdevice: 0
              name: subdevice #0
    - stream: CAPTURE
      devices:
        - device: 0
          id: 3f203000.i2s-wm8960-hifi wm8960-hifi-0
          name: 3f203000.i2s-wm8960-hifi wm8960-hifi-0
          subdevices:
            - subdevice: 0
              name: subdevice #0
alsactl: rawmidi_device_list:105: snd_ctl_rawmidi_next_device




alsactl store seeed2micvoicec





pi@sattelite-wohnzimmer:~ $ export XDG_RUNTIME_DIR=/run/user/1000
pi@sattelite-wohnzimmer:~ $ wpctl status
PipeWire 'pipewire-0' [1.2.7, pi@sattelite-wohnzimmer, cookie:193584953]
 └─ Clients:
        33. WirePlumber                         [1.2.7, pi@sattelite-wohnzimmer, pid:698]
        34. WirePlumber [export]                [1.2.7, pi@sattelite-wohnzimmer, pid:698]
        71. wpctl                               [1.2.7, pi@sattelite-wohnzimmer, pid:1380]

Audio
 ├─ Devices:
 │      53. Internes Audio                      [alsa]
 │      54. Internes Audio                      [alsa]
 │  
 ├─ Sinks:
 │  *   63. Internes Audio Stereo               [vol: 1.00]
 │  
 ├─ Sink endpoints:
 │  
 ├─ Sources:
 │  *   64. Internes Audio Stereo               [vol: 1.00]
 │  
 ├─ Source endpoints:
 │  
 └─ Streams:

Video
 ├─ Devices:
 │      40. bcm2835-codec-decode                [v4l2]
 │      41. bcm2835-codec-encode                [v4l2]
 │      42. bcm2835-codec-isp                   [v4l2]
 │      43. bcm2835-codec-image_fx              [v4l2]
 │      44. bcm2835-codec-encode_image          [v4l2]
 │      45. bcm2835-isp                         [v4l2]
 │      46. bcm2835-isp                         [v4l2]
 │      47. bcm2835-isp                         [v4l2]
 │      48. bcm2835-isp                         [v4l2]
 │      49. bcm2835-isp                         [v4l2]
 │      50. bcm2835-isp                         [v4l2]
 │      51. bcm2835-isp                         [v4l2]
 │      52. bcm2835-isp                         [v4l2]
 │  
 ├─ Sinks:
 │  
 ├─ Sink endpoints:
 │  
 ├─ Sources:
 │  *   55. bcm2835-isp (V4L2)                 
 │      57. bcm2835-isp (V4L2)                 
 │      59. bcm2835-isp (V4L2)                 
 │      61. bcm2835-isp (V4L2)                 
 │  
 ├─ Source endpoints:
 │  
 └─ Streams:

Settings
 └─ Default Configured Node Names:
pi@sattelite-wohnzimmer:~ $ wpctl inspect 53
id 53, type PipeWire:Interface:Device
    alsa.card = "0"
    alsa.card_name = "vc4-hdmi"
    alsa.driver_name = "vc4"
    alsa.id = "vc4hdmi"
    alsa.long_card_name = "vc4-hdmi"
    api.acp.auto-port = "false"
    api.acp.auto-profile = "false"
    api.alsa.card = "0"
    api.alsa.card.longname = "vc4-hdmi"
    api.alsa.card.name = "vc4-hdmi"
    api.alsa.path = "hw:0"
    api.alsa.use-acp = "true"
    api.dbus.ReserveDevice1 = "Audio0"
  * client.id = "34"
  * device.api = "alsa"
    device.bus-path = "platform-3f902000.hdmi"
  * device.description = "Internes Audio"
    device.enum.api = "udev"
    device.form-factor = "internal"
    device.icon-name = "audio-card-analog"
  * device.name = "alsa_card.platform-3f902000.hdmi"
  * device.nick = "vc4-hdmi"
    device.plugged.usec = "13646579"
    device.string = "0"
    device.subsystem = "sound"
    device.sysfs.path = "/devices/platform/soc/3f902000.hdmi/sound/card0"
  * factory.id = "15"
  * media.class = "Audio/Device"
    object.path = "alsa:acp:vc4hdmi"
  * object.serial = "53"
pi@sattelite-wohnzimmer:~ $ wpctl inspect 54
id 54, type PipeWire:Interface:Device
    alsa.card = "1"
    alsa.card_name = "seeed-2mic-voicecard"
    alsa.driver_name = "snd_soc_simple_card"
    alsa.id = "seeed2micvoicec"
    alsa.long_card_name = "seeed-2mic-voicecard"
    api.acp.auto-port = "false"
    api.acp.auto-profile = "false"
    api.alsa.card = "1"
    api.alsa.card.longname = "seeed-2mic-voicecard"
    api.alsa.card.name = "seeed-2mic-voicecard"
    api.alsa.path = "hw:1"
    api.alsa.use-acp = "true"
    api.dbus.ReserveDevice1 = "Audio1"
  * client.id = "34"
  * device.api = "alsa"
    device.bus-path = "platform-soc:sound"
  * device.description = "Internes Audio"
    device.enum.api = "udev"
    device.form-factor = "internal"
    device.icon-name = "audio-card-analog"
  * device.name = "alsa_card.platform-soc_sound"
  * device.nick = "seeed-2mic-voicecard"
    device.plugged.usec = "14096934"
    device.string = "1"
    device.subsystem = "sound"
    device.sysfs.path = "/devices/platform/soc/soc:sound/sound/card1"
  * factory.id = "15"
  * media.class = "Audio/Device"
    object.path = "alsa:acp:seeed2micvoicec"
  * object.serial = "54"
pi@sattelite-wohnzimmer:~ $ 


pi@sattelite-wohnzimmer:~ $ wpctl inspect 63
id 63, type PipeWire:Interface:Node
    alsa.card = "1"
    alsa.card_name = "seeed-2mic-voicecard"
    alsa.class = "generic"
    alsa.device = "0"
    alsa.driver_name = "snd_soc_simple_card"
    alsa.id = "3f203000.i2s-wm8960-hifi wm8960-hifi-0"
    alsa.long_card_name = "seeed-2mic-voicecard"
    alsa.name = "3f203000.i2s-wm8960-hifi wm8960-hifi-0"
    alsa.resolution_bits = "16"
    alsa.subclass = "generic-mix"
    alsa.subdevice = "0"
    alsa.subdevice_name = "subdevice #0"
    alsa.sync.id = "00000000:00000000:00000000:00000000"
    api.alsa.card.longname = "seeed-2mic-voicecard"
    api.alsa.card.name = "seeed-2mic-voicecard"
    api.alsa.path = "hw:1"
    api.alsa.pcm.card = "1"
    api.alsa.pcm.stream = "playback"
    audio.channels = "2"
    audio.position = "FL,FR"
    card.profile.device = "3"
  * client.id = "34"
    clock.quantum-limit = "8192"
    device.api = "alsa"
    device.class = "sound"
  * device.id = "54"
    device.profile.description = "Stereo"
    device.profile.name = "stereo-fallback"
    device.routes = "2"
  * factory.id = "19"
    factory.name = "api.alsa.pcm.sink"
    library.name = "audioconvert/libspa-audioconvert"
  * media.class = "Audio/Sink"
  * node.description = "Internes Audio Stereo"
    node.driver = "true"
    node.loop.name = "data-loop.0"
  * node.name = "alsa_output.platform-soc_sound.stereo-fallback"
  * node.nick = "3f203000.i2s-wm8960-hifi wm8960-hifi-0"
    node.pause-on-idle = "false"
  * object.path = "alsa:acp:seeed2micvoicec:3:playback"
  * object.serial = "63"
    port.group = "playback"
  * priority.driver = "1000"
  * priority.session = "1000"
pi@sattelite-wohnzimmer:~ $ 









root@sattelite-wohnzimmer:/etc/alsa/conf.d# cat /proc/asound/cards 
 0 [vc4hdmi        ]: vc4-hdmi - vc4-hdmi
                      vc4-hdmi
 1 [seeed2micvoicec]: simple-card - seeed-2mic-voicecard
                      seeed-2mic-voicecard



root@sattelite-wohnzimmer:/etc/alsa/conf.d# amixer -c 1
Simple mixer control 'Headphone',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB]
Simple mixer control 'Headphone Playback ZC',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [6.00dB]
  Front Right: Playback 127 [100%] [6.00dB]
Simple mixer control 'Speaker AC',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 5
  Mono: 5 [100%]
Simple mixer control 'Speaker DC',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 5
  Mono: 4 [80%]
Simple mixer control 'Speaker Playback ZC',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'PCM Playback -6dB',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mono Output Mixer Left',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mono Output Mixer Right',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Playback',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 255
  Front Left: 255 [100%] [0.00dB]
  Front Right: 255 [100%] [0.00dB]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [30.00dB] [on]
  Front Right: Capture 63 [100%] [30.00dB] [on]
Simple mixer control 'Capture Volume ZC',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control '3D',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%] Playback [off]
Simple mixer control '3D Filter Lower Cut-Off',0
  Capabilities: enum
  Items: 'Low' 'High'
  Item0: 'Low'
Simple mixer control '3D Filter Upper Cut-Off',0
  Capabilities: enum
  Items: 'High' 'Low'
  Item0: 'High'
Simple mixer control 'ADC Data Output Select',0
  Capabilities: enum
  Items: 'Left Data = Left ADC;  Right Data = Right ADC' 'Left Data = Left ADC;  Right Data = Left ADC' 'Left Data = Right ADC; Right Data = Right ADC' 'Left Data = Right ADC; Right Data = Left ADC'
  Item0: 'Left Data = Left ADC;  Right Data = Right ADC'
Simple mixer control 'ADC High Pass Filter',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ADC PCM',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 255
  Front Left: Capture 195 [76%] [0.00dB]
  Front Right: Capture 195 [76%] [0.00dB]
Simple mixer control 'ADC Polarity',0
  Capabilities: enum
  Items: 'No Inversion' 'Left Inverted' 'Right Inverted' 'Stereo Inversion'
  Item0: 'No Inversion'
Simple mixer control 'ALC Attack',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 2 [13%]
Simple mixer control 'ALC Decay',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 3 [20%]
Simple mixer control 'ALC Function',0
  Capabilities: enum
  Items: 'Off' 'Right' 'Left' 'Stereo'
  Item0: 'Off'
Simple mixer control 'ALC Hold Time',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC Max Gain',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%]
Simple mixer control 'ALC Min Gain',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'ALC Mode',0
  Capabilities: enum
  Items: 'ALC' 'Limiter'
  Item0: 'ALC'
Simple mixer control 'ALC Target',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 4 [27%]
Simple mixer control 'DAC Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'DAC Mono Mix',0
  Capabilities: enum
  Items: 'Stereo' 'Mono'
  Item0: 'Stereo'
Simple mixer control 'DAC Polarity',0
  Capabilities: enum
  Items: 'No Inversion' 'Left Inverted' 'Right Inverted' 'Stereo Inversion'
  Item0: 'No Inversion'
Simple mixer control 'Left Boost Mixer LINPUT1',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Left Boost Mixer LINPUT2',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left Boost Mixer LINPUT3',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left Input Boost Mixer LINPUT1',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%] [29.00dB]
Simple mixer control 'Left Input Boost Mixer LINPUT2',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Left Input Boost Mixer LINPUT3',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Left Input Mixer Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Left Output Mixer Boost Bypass',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-21.00dB] Playback [off]
Simple mixer control 'Left Output Mixer LINPUT3',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-21.00dB] Playback [off]
Simple mixer control 'Left Output Mixer PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Noise Gate',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Noise Gate Threshold',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 0 [0%]
Simple mixer control 'Right Boost Mixer RINPUT1',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right Boost Mixer RINPUT2',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Right Boost Mixer RINPUT3',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Right Input Boost Mixer RINPUT1',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%] [29.00dB]
Simple mixer control 'Right Input Boost Mixer RINPUT2',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Right Input Boost Mixer RINPUT3',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Right Input Mixer Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right Output Mixer Boost Bypass',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 5 [71%] [-6.00dB] Playback [off]
Simple mixer control 'Right Output Mixer PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right Output Mixer RINPUT3',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 2 [29%] [-15.00dB] Playback [off]
root@sattelite-wohnzimmer:/etc/alsa/conf.d# 




root@sattelite-wohnzimmer:/etc/alsa/conf.d# amixer -c 1 controls
numid=12,iface=MIXER,name='Headphone Playback ZC Switch'
numid=11,iface=MIXER,name='Headphone Playback Volume'
numid=17,iface=MIXER,name='PCM Playback -6dB Switch'
numid=57,iface=MIXER,name='Mono Output Mixer Left Switch'
numid=58,iface=MIXER,name='Mono Output Mixer Right Switch'
numid=41,iface=MIXER,name='ADC Data Output Select'
numid=19,iface=MIXER,name='ADC High Pass Filter Switch'
numid=36,iface=MIXER,name='ADC PCM Capture Volume'
numid=18,iface=MIXER,name='ADC Polarity'
numid=2,iface=MIXER,name='Capture Volume ZC Switch'
numid=3,iface=MIXER,name='Capture Switch'
numid=1,iface=MIXER,name='Capture Volume'
numid=10,iface=MIXER,name='Playback Volume'
numid=23,iface=MIXER,name='3D Filter Lower Cut-Off'
numid=22,iface=MIXER,name='3D Filter Upper Cut-Off'
numid=25,iface=MIXER,name='3D Switch'
numid=24,iface=MIXER,name='3D Volume'
numid=33,iface=MIXER,name='ALC Attack'
numid=32,iface=MIXER,name='ALC Decay'
numid=26,iface=MIXER,name='ALC Function'
numid=30,iface=MIXER,name='ALC Hold Time'
numid=27,iface=MIXER,name='ALC Max Gain'
numid=29,iface=MIXER,name='ALC Min Gain'
numid=31,iface=MIXER,name='ALC Mode'
numid=28,iface=MIXER,name='ALC Target'
numid=21,iface=MIXER,name='DAC Deemphasis Switch'
numid=42,iface=MIXER,name='DAC Mono Mix'
numid=20,iface=MIXER,name='DAC Polarity'
numid=45,iface=MIXER,name='Left Boost Mixer LINPUT1 Switch'
numid=43,iface=MIXER,name='Left Boost Mixer LINPUT2 Switch'
numid=44,iface=MIXER,name='Left Boost Mixer LINPUT3 Switch'
numid=9,iface=MIXER,name='Left Input Boost Mixer LINPUT1 Volume'
numid=5,iface=MIXER,name='Left Input Boost Mixer LINPUT2 Volume'
numid=4,iface=MIXER,name='Left Input Boost Mixer LINPUT3 Volume'
numid=49,iface=MIXER,name='Left Input Mixer Boost Switch'
numid=53,iface=MIXER,name='Left Output Mixer Boost Bypass Switch'
numid=37,iface=MIXER,name='Left Output Mixer Boost Bypass Volume'
numid=52,iface=MIXER,name='Left Output Mixer LINPUT3 Switch'
numid=38,iface=MIXER,name='Left Output Mixer LINPUT3 Volume'
numid=51,iface=MIXER,name='Left Output Mixer PCM Playback Switch'
numid=35,iface=MIXER,name='Noise Gate Switch'
numid=34,iface=MIXER,name='Noise Gate Threshold'
numid=48,iface=MIXER,name='Right Boost Mixer RINPUT1 Switch'
numid=46,iface=MIXER,name='Right Boost Mixer RINPUT2 Switch'
numid=47,iface=MIXER,name='Right Boost Mixer RINPUT3 Switch'
numid=8,iface=MIXER,name='Right Input Boost Mixer RINPUT1 Volume'
numid=7,iface=MIXER,name='Right Input Boost Mixer RINPUT2 Volume'
numid=6,iface=MIXER,name='Right Input Boost Mixer RINPUT3 Volume'
numid=50,iface=MIXER,name='Right Input Mixer Boost Switch'
numid=56,iface=MIXER,name='Right Output Mixer Boost Bypass Switch'
numid=39,iface=MIXER,name='Right Output Mixer Boost Bypass Volume'
numid=54,iface=MIXER,name='Right Output Mixer PCM Playback Switch'
numid=55,iface=MIXER,name='Right Output Mixer RINPUT3 Switch'
numid=40,iface=MIXER,name='Right Output Mixer RINPUT3 Volume'
numid=16,iface=MIXER,name='Speaker AC Volume'
numid=15,iface=MIXER,name='Speaker DC Volume'
numid=13,iface=MIXER,name='Speaker Playback Volume'
numid=14,iface=MIXER,name='Speaker Playback ZC Switch'
root@sattelite-wohnzimmer:/etc/alsa/conf.d# 



wpctl status




# initial
amixer -c seeed2micvoicec set Headphone 100%
amixer -c seeed2micvoicec set "Speaker DC" 100%

# als service
alsactl store
alsactl restore



[Unit]
Description=Restore and Store ALSA settings
After=pipewire.service
Before=getty.target

[Service]
Type=oneshot
ExecStart=/usr/bin/amixer -c seeed2micvoicec set Headphone 100%
ExecStart=/usr/bin/amixer -c seeed2micvoicec set Speaker 100%
ExecStart=/usr/sbin/alsactl store
ExecStop=/usr/sbin/alsactl store
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

