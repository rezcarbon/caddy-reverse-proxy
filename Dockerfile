# Use a minimal base image for the custom-built Caddy binary
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache ca-certificates curl

# Set the working directory
WORKDIR /srv

# Copy the custom-built Caddy binary
COPY ./caddy /usr/bin/caddy

# Copy the Caddyfile into the container
COPY ./Caddyfile /etc/caddy/Caddyfile

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Start Caddy
CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
