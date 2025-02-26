# Stage 1: Build the React application
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the application using a lightweight Node.js server
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy the build output from the previous stage
COPY --from=build /app/dist ./dist

# Install a lightweight HTTP server to serve the static files
RUN npm install -g serve

# Expose port 3000 (default port for serve)
EXPOSE 3000

# Start the server
CMD ["serve", "-s", "dist", "-l", "3000"]
