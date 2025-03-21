# Use Alpine as a lightweight base image
FROM alpine:latest

# Install required dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg \
    git \
    curl \
    pipx \
    bash  # Ensure a shell is available

# Ensure pipx installs globally
ENV PIPX_BIN_DIR=/usr/local/bin
ENV PIPX_HOME=/usr/local/pipx
RUN pipx install yt-dlp

# Set working directory for downloads
WORKDIR /downloads

# Add a script to update yt-dlp automatically
RUN printf '#!/bin/sh\n\
echo "Updating yt-dlp..."\n\
pipx upgrade yt-dlp\n\
echo "Update complete! Running yt-dlp..."\n\
exec yt-dlp "$@"\n' > /usr/local/bin/yt-dlp-update && \
    chmod +x /usr/local/bin/yt-dlp-update

# Ensure the script has correct permissions
RUN ls -l /usr/local/bin/yt-dlp-update

# Set entrypoint to always update yt-dlp before running
ENTRYPOINT ["/usr/local/bin/yt-dlp-update"]
