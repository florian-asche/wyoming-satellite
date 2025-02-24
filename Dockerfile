FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends avahi-utils alsa-utils pulseaudio-utils pipewire-bin build-essential libasound2-plugins pipewire-alsa

# setup alsa-sound
RUN echo 'pcm.!default { type plug slave.pcm "pipewire" }' | tee /etc/asound.conf
RUN echo 'ctl.!default { type pipewire }' | tee -a /etc/asound.conf

# set workdir
WORKDIR /app

# copy content for voice
COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY script/run ./script/
COPY script/run_2mic ./script/
COPY script/run_4mic ./script/
COPY pyproject.toml ./
COPY wyoming_satellite/ ./wyoming_satellite/
COPY docker/run ./

# copy content for led
COPY examples/ ./examples/

# run installation
RUN ./script/setup
RUN ./script/setup --vad
RUN ./script/setup --noisegain
RUN ./script/setup --respeaker
#RUN .venv/bin/pip3 install 'pixel-ring'

#RUN useradd -m -s /bin/bash -u 1000 debian
#USER debian

# set port for voice and led
EXPOSE 10700 10500

# set start script
# add parameters in docker
ENTRYPOINT ["/app/run"]
#ENTRYPOINT ["/app/script/run_2mic" "--uri" "tcp://0.0.0.0:10500"] for led
