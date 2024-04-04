#!/bin/bash

# Determine the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the virtual environment activation script
VENV_ACTIVATE="$DIR/venv/bin/activate"

# Check if the virtual environment activation script exists
if [ ! -f "$VENV_ACTIVATE" ]; then
    echo "Virtual environment not found. Please make sure your virtual environment is set up correctly."
    exit 1
fi

# Activate the virtual environment
source "$VENV_ACTIVATE"

# Set FLASK_APP environment variable
export FLASK_APP="$DIR/app.py"

# Run the Flask app in the background
flask run --debug &

# Wait for a few seconds for the server to start
sleep 5

# Open the default browser to localhost:5000
open http://localhost:5000
