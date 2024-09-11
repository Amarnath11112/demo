# Use an appropriate base image
FROM ubuntu:latest

# Update package list and install dependencies
RUN apt-get update && \
    apt-get install -y -q curl gnupg2

# Add the Nginx signing key
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

# Add Nginx repository and install Nginx
RUN echo "deb http://nginx.org/packages/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install -y -q nginx

# Remove default content
RUN rm -rf /var/www/html/*

# Copy your custom index.html into the container
COPY index.html /var/www/html/

# Uncomment and add your custom configuration files if needed
# ADD nginx.conf /etc/nginx/
# ADD server.conf /etc/nginx/conf.d/

# Expose the ports for Nginx
EXPOSE 80 443

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
