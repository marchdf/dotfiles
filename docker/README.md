# Docker setup for chezmoi dotfiles

This Dockerfile creates an Ubuntu-based development environment with all my dotfiles and CLI utilities configured via chezmoi.

## Quick start

From the `docker` directory:

```bash
cd docker
UID=$(id -u) GID=$(id -g) docker compose build
docker compose run --rm ubuntu-marchdf
```

## Pushing

```bash
docker tag ubuntu-marchdf:latest ${REGISTRY}/${IMAGE_PATH}:${TAG}
docker push ${REGISTRY}/${IMAGE_PATH}:${TAG}
```

## Pulling

```bash
docker pull ${REGISTRY}/${IMAGE_PATH}:${TAG}
```

## Running

```bash
cd $HOME/.local/share/chezmoi/docker
docker compose up -d ubuntu-marchdf
docker compose exec ubuntu-marchdf zsh
```

# Stopping

```bash
docker compose down
```
