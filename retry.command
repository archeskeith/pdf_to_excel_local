# Determine the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Change directory to the directory where the script resides
cd "$(dirname "$0")"

echo "Current directory: $(pwd)"

# Load environment variables from .env file
source "$DIR/.env"

# Debugging output
echo "API_KEY: $API_KEY"
echo "$(dirname "$0")"

# Check if the virtual environment activation script exists
VENV_ACTIVATE="$DIR/venv/bin/activate"
if [ ! -f "$VENV_ACTIVATE" ]; then
    echo "Virtual environment not found. Creating virtual environment..."
    python3 -m venv "$DIR/venv"
fi

# Activate the virtual environment
source "$VENV_ACTIVATE"

# Install pip if not installed
if ! command -v python3 -m pip &> /dev/null; then
    echo "pip not found. Installing pip..."
    python3 -m ensurepip && echo "pip installed successfully." || { echo "Failed to install pip."; exit 1; }
fi

export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

# Install Flask if not installed
if ! python3 -m pip show flask &> /dev/null; then
    echo "Flask not found. Installing Flask..."
    python3 -m pip install flask && echo "Flask installed successfully." || echo "Failed to install Flask."
fi

# Install dependencies even if some fail
echo "Installing dependencies..."
python3 -m pip install -r requirements_filtered.txt || echo "Some dependencies failed to install."
python3 -m pip install python-dotenv || echo "python-dotenv failed to install"
python3 -m pip install pymupdf || echo 'pymupdf failed to install'
python3 -m pip install tabula || echo 'tabula failed to install'
# python3 -m pip install tesseract || echo 'pytesseract failed to install'

# Add modified print statement to tesseract/__init__.py file
echo "Adding modified print statement to tesseract/__init__.py file..."
echo "print('Creating user config file: {}'.format(_config_file_usr))" >> /Library/Frameworks/Python.framework/Versions/3.12/lib/python3.12/site-packages/tesseract/__init__.py
sleep 5
# Run the Flask app
flask --app app.py --debug run

# Wait for a few seconds for the server to start
sleep 5

# Open the default browser to localhost:5000
open http://localhost:5000
