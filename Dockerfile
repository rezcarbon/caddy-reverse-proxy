FROM alpine:latest

# Install required dependencies
RUN apk add --no-cache ca-certificates curl

# Copy the custom-built Caddy binary
COPY ./caddy /usr/bin/caddy

# Copy the Caddyfile
COPY ./Caddyfile /etc/caddy/Caddyfile

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
