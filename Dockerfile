FROM cypress/browsers:latest

# Install python3, pip, and required dependencies for Chrome to run in headless mode
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    libx11-xcb1 libfontconfig1 libgbm1 \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment and install dependencies
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of your files
COPY . .

# Run the Flask app using Gunicorn
CMD gunicorn -b 0.0.0.0:$PORT main:app
