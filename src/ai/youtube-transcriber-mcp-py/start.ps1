# Check if venv exists
if (!(Test-Path venv)) {
    Write-Host "Creating virtual environment..."
    python -m venv venv
}

# Install requirements using venv python
Write-Host "Installing dependencies..."
& .\venv\Scripts\python.exe -m pip install -r requirements.txt

# Start the server
Write-Host "Starting the server..."
& .\venv\Scripts\python.exe server.py