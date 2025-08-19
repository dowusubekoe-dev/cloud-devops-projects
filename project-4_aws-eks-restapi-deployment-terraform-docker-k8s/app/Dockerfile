# Use a slim, official Python image for a smaller footprint.
# 3.12 is a good choice as it's a recent, stable version.
FROM python:3.12-slim

# Set the working directory inside the container.
# All subsequent commands will be run from this directory.
WORKDIR /app

# Set environment variables for better Python and Docker integration.
# This ensures that logs are output in real-time, which is crucial for
# debugging and log collectors.
ENV PYTHONUNBUFFERED=1

# First, copy only the requirements file. This allows Docker to cache
# the layer of dependencies. If requirements.txt doesn't change,
# the pip install step will be skipped on subsequent builds.
COPY requirements.txt .

# Install Python dependencies. Using --no-cache-dir reduces the image size.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code. This is done after installing dependencies
# to leverage Docker's build cache. If only the code changes, this layer
# will be rebuilt, but the dependencies layer will not.
# We are copying a specific src directory, which is a good practice.
COPY src/ ./src

# Expose the port that the application listens on.
# This is a documentation step; it doesn't publish the port.
EXPOSE 5000

# Define the command to run the application when the container starts.
# We explicitly point to the app.py file within the src directory.
CMD ["python", "src/app.py"]