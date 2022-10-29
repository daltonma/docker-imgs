FROM ubuntu:focal
# Enable UTF-8
ENV LANG C.UTF-8
# Add ca-certificates
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y ca-certificates 
# Add packages
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    bash \
    build-essential \
    ca-certificates \
    curl \
    htop \
    locales \
    man \
    python3 \
    python3-pip \
    software-properties-common \
    sudo \
    unzip \
    vim \
    emacs \
    fish \
    wget &&\
    add-apt-repository ppa:git-core/ppa && \ 
    DEBIAN_FRONTEND='noninteractive' apt-get install -y git && \
    locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# Add make gcc clang
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    make \
    automake \
    gcc \
    clang

# Add a user `coder` so that you're not developing as the `root` user
RUN useradd user \
      --create-home \
      --shell=/bin/bash \
      --uid=1000 \
      --user-group && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd


USER user

# Install brew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH /home/linuxbrew/.linuxbrew/bin:${PATH}
