FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install -y sudo curl git build-essential libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy your entire forked repository into the container
COPY . .

# Make all scripts executable
RUN chmod +x *.sh

# Copy and set up the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the default port (Railway will override this with $PORT)
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]