# Docker setup for chezmoi dotfiles

This directory contains Dockerfiles for Ubuntu-based development environments with dotfiles configured via chezmoi.

## Production container (ubuntu-marchdf)

Full environment with dotfiles baked in at build time.

```bash
cd docker
UID=$(id -u) GID=$(id -g) docker compose build ubuntu-marchdf
docker compose run --rm ubuntu-marchdf
```

## Test container (ubuntu-test)

Minimal container for iterating on local chezmoi changes. Mounts local source as read-only.

```bash
cd docker
docker compose build ubuntu-test
docker compose run --rm ubuntu-test

# Inside container - first time setup:
chezmoi init --source /dotfiles-source \
    --promptBool test_machine=f,"Use ZSH_ROOT_DIR for tmux shell"=f,use_large_install_dir=f \
    --promptString email="marchdf@docker-container.com"
chezmoi apply

# Iterating on changes (edit files on host, then in container):
chezmoi apply
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
docker compose up -rm ubuntu-marchdf
```

## Stopping

```bash
docker compose down
```
