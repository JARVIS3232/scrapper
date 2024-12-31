ARG PORT=443
FROM cypress/browsers:latest

# Install python3, python3-pip, and python3-venv (required for creating a virtual environment)
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

# Set the environment variable to make sure dependencies are installed in the local user directory
ENV PATH /home/root/.local/bin:${PATH}

# Run the application using uvicorn
CMD uvicorn main:app --host 0.0.0.0 --port $PORT
