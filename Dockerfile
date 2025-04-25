FROM python:3.10.6-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Copy the application code (including requirements if needed)
COPY . .

# Expose the port that Uvicorn will run on
EXPOSE 5005

# Set the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
