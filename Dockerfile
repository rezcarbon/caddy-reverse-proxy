# Base image with minimal dependencies
FROM caddy:alpine

# Set working directory
WORKDIR /srv

# Copy the custom-built Caddy binary
COPY ./caddy.exe /usr/bin/caddy

# Copy the Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
