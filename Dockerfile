ARG PORT=443
FROM cypress/browsers:latest

# Install python3, python3-pip, and python3-venv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment in /venv
RUN python3 -m venv /venv

# Set the virtual environment as the active environment for the subsequent commands
ENV PATH="/venv/bin:$PATH"

# Copy the requirements.txt file and install dependencies inside the virtual environment
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of your application files
COPY . .

# Run the Flask app using Gunicorn on the specified port
CMD gunicorn -b 0.0.0.0:$PORT main:app
