# Use Python 3.11 (matches your Mac environment)
FROM python:3.11-slim

# Install system libraries required by Scanpy and Flet
RUN apt-get update && apt-get install -y \
    build-essential \
    libhdf5-dev \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1. Copy requirements first
COPY requirements.txt .

# 2. Install Python dependencies (Strict versions)
RUN pip install --no-cache-dir -r requirements.txt

# 3. Copy the main app
COPY main.py .

# 4. Set the port for Flet
ENV PORT=8080
EXPOSE 8080

# 5. Run the app
CMD ["python", "main.py"]