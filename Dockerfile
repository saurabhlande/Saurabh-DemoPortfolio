# Use an official Node.js image as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Install http-server globally
RUN npm install -g http-server

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to start the static server
CMD ["http-server", "-p", "8000"]
