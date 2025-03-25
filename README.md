# wyoming-satellite

[![CI](https://github.com/florian-asche/wyoming-satellite/actions/workflows/docker-build-release.yml/badge.svg)](https://github.com/florian-asche/wyoming-satellite/actions/workflows/docker-build-release.yml) [![GitHub Package Version](https://img.shields.io/github/v/tag/florian-asche/wyoming-satellite?label=version)](https://github.com/florian-asche/wyoming-satellite/pkgs/container/wyoming-satellite) [![GitHub License](https://img.shields.io/github/license/florian-asche/wyoming-satellite)](https://github.com/florian-asche/wyoming-satellite/blob/main/LICENSE.md) [![GitHub last commit](https://img.shields.io/github/last-commit/florian-asche/wyoming-satellite)](https://github.com/florian-asche/wyoming-satellite/commits) [![GitHub Container Registry](https://img.shields.io/badge/Container%20Registry-GHCR-blue)](https://github.com/florian-asche/wyoming-satellite/pkgs/container/wyoming-satellite)

This repository provides a Docker image for [Wyoming Satellite](https://github.com/rhasspy/wyoming-satellite), a voice assistant service that can be used with various voice assistants. The image is designed to be easily integrated into your home automation setup.

## Features

- Pre-built Docker image for Wyoming Satellite
- Supports multiple architectures (linux/amd64 and linux/aarch64)
- Automated builds with artifact attestation for security
- Easy integration with voice assistants

## Usage

### Basic Usage

To run Wyoming Satellite:

```bash
docker run --rm -it ghcr.io/florian-asche/wyoming-satellite:latest
```

### Docker Compose

For a complete example configuration, check out the `docker-compose.yml` file in this repository.


### Parameter Overview

| Parameter | Description |
|-----------|-------------|


## Build Information

Image builds can be tracked in this repository's `Actions` tab, and utilize [artifact attestation](https://docs.github.com/en/actions/security-guides/using-artifact-attestations-to-establish-provenance-for-builds) to certify provenance.

The Docker images are built using GitHub Actions, which provides:

- Automated builds for different architectures
- Artifact attestation for build provenance verification
- Regular updates and maintenance

### Available Tags

- `latest`: Latest stable release
- `nightly`: Builds from the main branch (may be unstable)
- Version-specific tags (e.g., `1.0.0`): Stable releases

### Build Process

The build process includes:

- Multi-architecture support (linux/amd64 and linux/aarch64)
- Security verification through artifact attestation
- Automated testing and validation
- Regular updates to maintain compatibility

For more information about the build process and available architectures, please refer to the Actions tab in this repository.

## Documentation

For detailed documentation and examples, please visit the [docs](docs/) directory in this repository.
