# Use official Node.js image as the base image
FROM node AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build
RUN npm install convex

# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["npm", "run", "dev"]