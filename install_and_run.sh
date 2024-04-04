#!/bin/bash

# Install dependencies
pip install -r requirements.txt

# Run Flask
flask --app app.py --debug run &

# Wait for Flask to start
sleep 5

# Open localhost:5000 in the default browser
open http://localhost:5000
