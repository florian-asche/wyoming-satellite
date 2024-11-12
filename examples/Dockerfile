FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install needed packages
RUN apt-get update && \
    apt-get install --yes --no-install-recommends python3-spidev python3-gpiozero

WORKDIR /app

# Copy app
COPY commands/ ./commands/
COPY websocket-service/ ./websocket-service/
COPY 2mic_service.py ./2mic_service.py
COPY 4mic_service.py ./4mic_service.py


# Install needed python packages
#RUN python3 -m venv --system-site-packages .venv
#RUN .venv/bin/pip3 install --upgrade pip
#RUN .venv/bin/pip3 install --upgrade wheel setuptools
#RUN .venv/bin/pip3 install 'wyoming==1.5.2'
#RUN .venv/bin/pip3 install 'pixel-ring'

WORKDIR /app

EXPOSE 10500
ENTRYPOINT ["python3" "2mic_service.py" "--uri" 'tcp://0.0.0.0:10500']
