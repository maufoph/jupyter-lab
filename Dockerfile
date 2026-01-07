# Use an official Python base image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Install uv (ultra fast Python package installer)
RUN pip install --upgrade pip && \
    pip install uv

# Set work directory
WORKDIR /app

# Copy dependency descriptor (pyproject.toml and optionally requirements.txt or requirements.uv)
# Uncomment below if you have those files; otherwise skip
# COPY pyproject.toml ./
# COPY requirements.uv ./

# Install dependencies with uv, if any
# RUN if [ -f "requirements.uv" ]; then uv pip install -r requirements.uv; fi

# Install Jupyter Lab
RUN uv pip install jupyterlab

# Expose Jupyter Lab port
EXPOSE 8888

# Launch Jupyter Lab, allow root, open to all, don't open browser
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]