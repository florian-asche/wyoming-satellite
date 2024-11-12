FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends avahi-utils alsa-utils pulseaudio-utils pipewire-bin

# set workdir
WORKDIR /app

# copy content
COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY script/run ./script/
COPY setup.py requirements.txt requirements_audio_enhancement.txt requirements_vad.txt MANIFEST.in ./
COPY wyoming_satellite/ ./wyoming_satellite/
COPY docker/run ./

# run installation
RUN python3 -m venv .venv
RUN .venv/bin/pip3 install --upgrade pip
RUN .venv/bin/pip3 install --upgrade wheel setuptools
RUN .venv/bin/pip3 install --extra-index-url 'https://www.piwheels.org/simple' -f 'https://synesthesiam.github.io/prebuilt-apps/' -r requirements.txt -r requirements_audio_enhancement.txt -r requirements_vad.txt

# set port
EXPOSE 10700

# set start script
# add parameters in docker
ENTRYPOINT ["/app/run"]
