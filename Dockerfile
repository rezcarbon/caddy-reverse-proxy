# Use a minimal base image
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates curl

# Copy the Linux-compatible binary
COPY ./caddy /usr/bin/caddy

# Copy the Caddyfile
COPY ./Caddyfile /etc/caddy/Caddyfile

# Grant execute permissions
RUN chmod +x /usr/bin/caddy

# Expose ports
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
