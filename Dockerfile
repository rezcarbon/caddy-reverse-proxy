# Use the official Caddy base image
FROM caddy:alpine

# Set the working directory
WORKDIR /srv

# Copy the Caddyfile into the container
COPY Caddyfile /etc/caddy/Caddyfile

# Ensure certificates are securely written from environment variables
# and permissions are restricted
RUN mkdir -p /app && \
    chmod 700 /app && \
    echo "$CLOUDFLARE_CERT" > /app/cloudflare-origin.pem && \
    echo "$CLOUDFLARE_KEY" > /app/cloudflare-key.pem && \
    chmod 600 /app/cloudflare-origin.pem /app/cloudflare-key.pem

# Expose the default Caddy ports (80 and 443)
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
