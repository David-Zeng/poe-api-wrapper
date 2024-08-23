# Use a 64-bit ARM base image
FROM --platform=linux/arm64 python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

RUN pip uninstall -y websocket-client
RUN pip uninstall -y websocket
RUN pip install --no-cache-dir websocket-client

# Copy application code
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Expose port
EXPOSE 9000

# Run the application
CMD ["python", "./poe_api_wrapper/openai/api.py"]

# docker build -f dockerfile -t poe_api_image .
# docker run -p 9000:9000 -d --name poe_api_app poe_api_image
