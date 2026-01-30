#!/bin/bash

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate venv and install requirements
echo "Installing dependencies..."
source venv/bin/activate
pip install -r requirements.txt

# Start the server
echo "Starting the server..."
python server.py