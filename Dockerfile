# Use the official Caddy base image
FROM caddy:alpine

# Set the working directory
WORKDIR /srv

# Copy the Caddyfile into the container
COPY Caddyfile /etc/caddy/Caddyfile

# Copy SSL certificates into the container
COPY ssl /ssl

# Expose the default Caddy port (80 and 443)
EXPOSE 80
EXPOSE 443

# Run Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
