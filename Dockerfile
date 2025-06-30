# -------- Stage 1: Builder --------
FROM python:3.10-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies into a virtual environment
COPY requirements.txt .
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# -------- Stage 2: Runtime --------
FROM python:3.10-slim

# Create appuser
RUN adduser --disabled-password --gecos '' appuser

# Set up working directory
WORKDIR /app

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv

# Activate virtualenv by default
ENV PATH="/opt/venv/bin:$PATH"

# Copy app code
COPY . .

# Set file ownership to appuser
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8000

# Run app
CMD ["gunicorn", "notesapp.wsgi:application", "--bind", "0.0.0.0:8000"]

