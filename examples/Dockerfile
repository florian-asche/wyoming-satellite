FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends python3-spidev python3-gpiozero

WORKDIR /app

COPY examples/ ./examples/

WORKDIR /app/examples

RUN python3 -m venv --system-site-packages .venv
RUN .venv/bin/pip3 install --upgrade pip
RUN .venv/bin/pip3 install --upgrade wheel setuptools
RUN .venv/bin/pip3 install 'wyoming==1.5.2'
#RUN .venv/bin/pip3 install 'pixel-ring'

WORKDIR /app

EXPOSE 10500
ENTRYPOINT ["/app/examples/.venv/bin/python3 2mic_service.py" "--uri" 'tcp://127.0.0.1:10500']
