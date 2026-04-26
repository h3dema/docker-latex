FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install texlive-full and latexmk
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-full \
        latexmk \
        perl \
        wget \
        ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /workspace/doc

# Copy compile script
COPY compile.sh /usr/local/bin/compile.sh
RUN chmod +x /usr/local/bin/compile.sh

WORKDIR /workspace/doc

CMD ["/usr/local/bin/compile.sh"]

