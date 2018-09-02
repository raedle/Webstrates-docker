FROM node:8-alpine

# Install git -> git is also required by Webstrates to build the client and server
RUN apk update && apk upgrade && \
    apk add --no-cache git

# Check out Webstrates from GitHub
RUN git clone https://github.com/Webstrates/Webstrates.git /app

# Set app as working directory
WORKDIR /app

# Install npm packages
RUN npm install --production

# Build client and server
RUN npm run build

# The Webstrates server runs on port 7007
EXPOSE 7007

# Start Webstrates server when container starts
ENTRYPOINT [ "npm", "start" ]