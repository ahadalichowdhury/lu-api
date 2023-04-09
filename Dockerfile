# Use an official Node.js runtime as a parent image
FROM node:16-alpine

# Install dependencies
RUN apk add --no-cache \
    bash \
    chromium \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    fontconfig \
    udev

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json to /app
COPY package*.json ./

# Install the app's dependencies
RUN npm install

# Copy the rest of the application to /app
COPY . .

# Set the environment variable for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Expose the port that the app is running on
EXPOSE 8080

# Start the app
CMD ["npm", "start"]
