# Base Node.js Alpine image for building
FROM node:alpine AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application in production mode
RUN npm run build --prod

# Base NGINX Alpine image for serving
FROM nginx:alpine

# Copy the built Angular app files to the NGINX HTML folder
COPY --from=build /usr/src/app/dist/demoapp /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80