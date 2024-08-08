# Stage 1: Build React app
ARG NODE_IMAGE=node:14.15.3-alpine3.12

FROM $NODE_IMAGE AS BUILD_IMAGE
WORKDIR /usr/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy all other files and build the React app
COPY . .
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy the build output from the previous stage
COPY --from=BUILD_IMAGE /usr/app/build .

# Copy custom Nginx configuration, if you have one
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for the Nginx web server
EXPOSE 80

# Nginx will automatically start with the container
