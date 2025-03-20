FROM python:3.11-slim-bookworm AS builder

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Copy all application files
COPY script/ ./script/
COPY pyproject.toml ./
COPY sounds/ ./sounds/
COPY wyoming_satellite/ ./wyoming_satellite/
COPY docker/run ./
COPY examples/ ./examples/

# Run installation steps
RUN ./script/setup && \
    ./script/setup --vad && \
    ./script/setup --noisegain && \
    ./script/setup --respeaker

# Start second stage
FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        avahi-utils \
        alsa-utils \
        pulseaudio-utils \
        pipewire-bin \
        libasound2-plugins \
        pipewire-alsa && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy complete app directory from builder
COPY --from=builder /app /app

# Create and switch to non-root user
RUN useradd -m -s /bin/bash -u 1000 wyoming && \
    usermod -a -G audio wyoming && \
    chown -R wyoming:wyoming /app
USER wyoming

# Set ports for voice and led
EXPOSE 10700 10500

# Set start script
ENTRYPOINT ["/app/run"]
