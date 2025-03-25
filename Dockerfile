FROM python:3.10.6

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . .

# Expose the port that Uvicorn will run on
EXPOSE 5005

# Set the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]