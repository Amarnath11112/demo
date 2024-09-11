FROM ubuntu:20.04

# Update package list and install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove default content
RUN rm -rf /var/www/html/*

# Copy your custom index.html into the container
COPY index.html /var/www/html/

# Expose the ports for Nginx
EXPOSE 80 443

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
