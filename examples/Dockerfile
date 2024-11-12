FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install needed packages
RUN apt-get update && \
    apt-get install --yes --no-install-recommends python3-spidev python3-gpiozero

WORKDIR /app

# Copy app
COPY commands/ ./examples/commands/
COPY websocket-service/ ./examples/websocket-service/
COPY 2mic_service.py ./examples/2mic_service.py
COPY 4mic_service.py ./examples/4mic_service.py
COPY ../script/run_2mic ./script/run_2mic
COPY ../script/run_4mic ./script/run_4mic

# Install needed python packages
RUN python3 -m venv --system-site-packages .venv
RUN .venv/bin/pip3 install --upgrade pip
RUN .venv/bin/pip3 install --upgrade wheel setuptools
RUN .venv/bin/pip3 install 'wyoming==1.5.4'
#RUN .venv/bin/pip3 install 'pixel-ring'

EXPOSE 10500
ENTRYPOINT ["/app/script/run_2mic" "--uri" 'tcp://0.0.0.0:10500']
