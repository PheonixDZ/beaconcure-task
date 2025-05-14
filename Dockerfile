############################################################
# Build Stage: Compile TypeScript Code
############################################################
FROM node:16-alpine3.13 AS builder
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./

RUN npm install

# Copy TypeScript configuration and source files
COPY . ./

# Run the build script to compile TypeScript code into /app/dist
RUN npm run build

############################################################
# Production Stage: Create Final Image
############################################################
FROM node:16-alpine3.13
WORKDIR /app

# Install dumb-init for proper signal handling
RUN apk --no-cache add dumb-init

# (Optional) Remove APK related directories if you need to minimize image size
RUN rm -rf /sbin/apk /etc/apk /lib/apk /usr/share/apk /var/lib/apk

# Copy production dependencies and compiled code from the builder
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/config ./config

# Use a non-root user for security
USER node

# Expose the port your application listens on
EXPOSE 3000

# Healthcheck to ensure your service is running (adjust as needed)
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -k https://localhost:3000/ || exit 1

# Start the application (ensure your "start" script in package.json points to "node dist/index.js")
CMD ["dumb-init", "npm", "start"]
