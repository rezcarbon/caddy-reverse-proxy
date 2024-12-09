# Use Alpine Linux as the base image
FROM alpine:latest

# Install required dependencies
RUN apk add --no-cache \
    ca-certificates \
    curl \
    libc6-compat # Ensure compatibility for some Go binaries

# Ensure permissions for the binary
RUN mkdir -p /usr/bin && chmod +x /usr/bin

# Copy the custom-built Caddy binary
COPY ./caddy /usr/bin/caddy

# Copy the Caddyfile configuration
COPY ./Caddyfile /etc/caddy/Caddyfile

# Ensure execute permissions for the Caddy binary
RUN chmod +x /usr/bin/caddy

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Default command to run Caddy
CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
