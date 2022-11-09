FROM daltonma/base:latest
USER root
SHELL ["/bin/sh", "-c"]
RUN echo "Installing code-server dependencies ..." && \
    apt-get update && \
    apt-get install -y  \
    jq \
    libatomic1 \
    net-tools \
    netcat \
    coreutils
USER user
RUN curl -fsSL https://code-server.dev/install.sh | sh
USER root
RUN mkdir /home/code-server/
RUN chown user /home/code-server/
USER user
ENV HOSTNAME codespace
ENV PATH /home/user/.local/bin:${PATH}
EXPOSE 8080
WORKDIR /home/user/
ENTRYPOINT ["/usr/bin/code-server", "--auth=none", "--extensions-dir=/home/code-server", "--bind-addr=0.0.0.0:8080", "--disable-getting-started-override", "--app-name='VS Code'"]
