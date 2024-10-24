# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# Install redis-tools to get redis-cli
RUN apt-get update && apt-get install -y redis-tools && apt-get clean

# Copy scripts into the container
COPY ./scripts /app/scripts

# Make the consumer script executable
RUN chmod +x /app/scripts/consumer.sh

CMD ["bash", "/app/scripts/consumer.sh"]
