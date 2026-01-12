# Dockerfile for chezmoi dotfiles environment
# Based on the CI workflow for Ubuntu
FROM ubuntu:24.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Set default shell to bash for RUN commands
SHELL ["/bin/bash", "-c"]

# Create a non-root user for development
ARG USERNAME=marchdf
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Install minimal bootstrap dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    locales \
    hunspell-en-us \
    tzdata \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Set locale environment variables
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create the user with sudo privileges (handle existing GID gracefully)
RUN if ! getent group $USER_GID > /dev/null 2>&1; then groupadd --gid $USER_GID $USERNAME; fi \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && mkdir -p /etc/sudoers.d \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to the non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Copy bootstrap script and run as user (with sudo)
COPY --chown=$USERNAME:$USERNAME ../bin/executable_install_bootstrap_dependencies.sh /tmp/install_bootstrap.sh
RUN bash /tmp/install_bootstrap.sh && rm /tmp/install_bootstrap.sh

# Ensure chezmoi is in PATH
ENV PATH="/home/$USERNAME/.local/bin:${PATH}"

# Initialize chezmoi with dotfiles from GitHub
RUN chezmoi init https://github.com/marchdf/dotfiles.git \
    --promptBool test_machine=f,"Use ZSH_ROOT_DIR for tmux shell"=f \
    --promptString email="marchdf@docker-container.com" \
    && chezmoi apply

# Pre-initialize zinit by running zsh once (this downloads all plugins)
RUN zsh -i -c "exit"

# Pre-initialize Emacs by running in batch mode (installs all use-package packages)
RUN emacs --batch -l ~/.emacs --eval "(message \"Emacs packages initialized\")"

# Set environment variables for interactive shell
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV IN_DOCKER=true

# Set the default shell to zsh
CMD ["/bin/zsh", "-l"]
