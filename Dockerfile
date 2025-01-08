# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    python3 \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH
ENV PATH="/usr/games:$PATH"

# Copy application files
COPY . /app
WORKDIR /app

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the application port
EXPOSE 4499

# Start the application
CMD ["./wisecow.sh"]
