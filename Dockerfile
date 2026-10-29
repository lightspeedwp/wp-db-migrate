# Dockerfile for wp-db-migrate cloud deployment
# Usage:
#   docker build -t wp-db-migrate:latest .
#   docker run -v /path/to/wordpress:/wordpress wp-db-migrate

FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    grep \
    sed \
    ca-certificates

# Copy package files
COPY package*.json ./

# Install npm dependencies
RUN npm ci --only=production

# Copy project files
COPY . .

# Make scripts executable
RUN chmod +x skill/scripts/*.sh

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S claude -u 1001

# Change ownership to non-root user
RUN chown -R claude:nodejs /app

# Switch to non-root user
USER claude

# Set environment variables
ENV NODE_ENV=production
ENV PATH="/app/skill/scripts:${PATH}"

# Run preflight check on container startup
ENTRYPOINT ["/app/skill/scripts/preflight-check.sh"]

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD [ -x "/app/skill/scripts/preflight-check.sh" ] || exit 1

# Labels for metadata
LABEL maintainer="Ash Shaw <ashley@lightspeedwp.agency>"
LABEL version="1.1.0"
LABEL description="WordPress database migration tool for MySQL → SQLite in WordPress Studio"
LABEL org.opencontainers.image.source="https://github.com/lightspeedwp/wp-db-migrate"
