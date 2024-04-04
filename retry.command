# Determine the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Change directory to the directory where the script resides
cd "$(dirname "$0")"

echo "Current directory: $(pwd)"

# Install dependencies if they are not already installed
pip install -r requirements_filtered.txt




# Load environment variables from .env file
source "$DIR/venv/bin/activate"
source "$DIR/.env"

# Debugging output
echo "API_KEY: $API_KEY"
echo "$(dirname "$0")"

# Check if the virtual environment activation script exists
VENV_ACTIVATE="$DIR/venv/bin/activate"
if [ ! -f "$VENV_ACTIVATE" ]; then
    echo "Virtual environment not found. Please make sure your virtual environment is set up correctly."
    exit 1
fi

# Activate the virtual environment
source "$VENV_ACTIVATE"

# # Set FLASK_APP environment variable
# export FLASK_APP="$DIR/app.py"

# Run the Flask app in the background
# flask run  --debug &
flask --app app.py --debug run

# Wait for a few seconds for the server to start
sleep 5

# Open the default browser to localhost:5000
open http://localhost:5000
