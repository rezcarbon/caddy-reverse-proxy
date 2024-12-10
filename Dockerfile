# Use a minimal base image
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache ca-certificates curl

# Set up working directory
WORKDIR /app

# Write Cloudflare certificate and key from environment variables
RUN mkdir -p /app && \
    echo "$CLOUDFLARE_CERT" > /app/cloudflare-origin.pem && \
    echo "$CLOUDFLARE_KEY" > /app/cloudflare-key.pem && \
    chmod 600 /app/cloudflare-origin.pem /app/cloudflare-key.pem

# Copy the Linux-compatible Caddy binary
COPY ./caddy /usr/bin/caddy

# Grant execute permissions to the binary
RUN chmod +x /usr/bin/caddy

# Copy the Caddyfile
COPY ./Caddyfile /etc/caddy/Caddyfile

# Set default environment variables (optional)# Set default environment variables
ENV PORT 8080  # Default port if not provided by Railway

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
