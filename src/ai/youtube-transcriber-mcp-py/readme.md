# YouTube Transcription MCP Server

A Model Context Protocol (MCP) server that provides YouTube video transcription capabilities using the FastMCP framework.

## Features

- Extract video IDs from YouTube URLs (both youtube.com and youtu.be formats)
- Fetch video transcriptions using the YouTube Transcript API
- Support for multiple languages
- Built with FastMCP for easy integration with MCP clients

## Installation

### Setting Up a Virtual Environment

It's highly recommended to use a virtual environment to manage dependencies:

```bash
# Create a virtual environment
python -m venv venv

# Activate the virtual environment
# On Linux/macOS:
source venv/bin/activate
# On Windows:
# venv\Scripts\activate
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

## Usage

### Running the MCP Server Locally

Run the PowerShell script `youtube-transcriber-mcp/start.ps1` to create a virtual environment, install dependencies, and start the server on `http://127.0.0.1:8000/mcp`.

### Available Tools

#### `get_youtube_transcription`

Fetches the transcription of a YouTube video.

**Parameters:**

- `url` (required): The YouTube video URL (e.g., `https://www.youtube.com/watch?v=VIDEO_ID` or `https://youtu.be/VIDEO_ID`)
- `language` (optional): The language code for the transcript (default: "en"). Examples: "en" for English, "es" for Spanish, "fr" for French, etc.

**Returns:**

- The full transcription text of the video

**Example Usage:**

```python
# Using the MCP tool
result = get_youtube_transcription(
    url="https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    language="en"
)
```

## Testing with MCP Inspector

The [MCP Inspector](https://github.com/modelcontextprotocol/inspector) is an interactive developer tool for testing MCP servers. It provides a web-based UI to interact with your server's tools, prompts, and resources.

### Prerequisites

- Node.js and npm installed on your system
- Your virtual environment activated with dependencies installed

### Installation

Install the MCP Inspector globally:

```bash
npm install -g @modelcontextprotocol/inspector
```

### Running the Inspector

Launch the inspector after the server is running. Use a second terminal window or tab so the server can keep running in the background.

From `src/youtube-transcriber-mcp/`:

```bash
mcp-inspector --transport streamable-http --server-url http://127.0.0.1:8000/mcp
```

From the repository root:

```bash
mcp-inspector --transport streamable-http --server-url http://127.0.0.1:8000/mcp python src/youtube-transcriber-mcp/server.py
```

This will:

1. Open the MCP Inspector web UI (typically at http://localhost:5173)
2. Connect the inspector through the Streamable HTTP proxy to the running server on `http://127.0.0.1:8000/mcp`

### Using the Inspector

Once the inspector opens in your browser:

1. **View Available Tools**: Navigate to the Tools tab to see `get_youtube_transcription`
2. **Test the Tool**:
   - Click on `get_youtube_transcription`
   - Fill in the parameters:
     - `url` (required): Enter a YouTube video URL (e.g., `https://www.youtube.com/watch?v=dQw4w9WgXcQ`)
     - `language` (optional, default: "en"): Enter a language code (e.g., `en`, `es`, `fr`)
   - Click **Execute** or **Call Tool**
3. **View Results**: The inspector will display the returned transcript in the response panel
4. **Debug**: Check the Network tab for request/response details and the Console for logs

### Example Test Cases

Try these YouTube videos for testing:

- Short video: `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
- Video with multiple languages: Test different `language` parameter values
- Longer-form video: `https://www.youtube.com/watch?v=zTiLF3-BvGs`
- Invalid URL: Test error handling with `https://example.com/not-a-video`

### Troubleshooting

If the inspector fails to connect:

- Ensure your virtual environment is activated
- Verify all dependencies are installed: `pip install -r requirements.txt`
- Make sure `python server.py` is running in a separate terminal and showing `Uvicorn running on http://127.0.0.1:8000`
- Keep the inspector pointed at `http://127.0.0.1:8000/mcp`
- Check that no other service is using the default port
- Review server logs for error messages

## Deployment to Azure App Service

### Prerequisites

- Azure CLI installed and configured
- Azure subscription
- Resource group created in Azure

### Deployment Steps

1. **Create an Azure App Service Plan:**

```bash
az appservice plan create \
    --name youtube-transcriber-plan \
    --resource-group <your-resource-group> \
    --sku B1 \
    --is-linux
```

2. **Create the Web App:**

```bash
az webapp create \
    --resource-group <your-resource-group> \
    --plan youtube-transcriber-plan \
    --name <your-app-name> \
    --runtime "PYTHON:3.12"
```

3. **Configure the startup command:**

```bash
az webapp config set \
    --resource-group <your-resource-group> \
    --name <your-app-name> \
    --startup-file "python server.py"
```

4. **Deploy the code:**

```bash
# From the src directory
az webapp up \
    --resource-group <your-resource-group> \
    --name <your-app-name> \
    --runtime "PYTHON:3.12"
```

5. **Configure environment variables (if needed):**

```bash
az webapp config appsettings set \
    --resource-group <your-resource-group> \
    --name <your-app-name> \
    --settings SETTING_NAME=value
```

### Alternative: Deploy using ZIP

```bash
# Create a ZIP file of the src directory
cd src
zip -r ../deploy.zip .

# Deploy the ZIP file
az webapp deployment source config-zip \
    --resource-group <your-resource-group> \
    --name <your-app-name> \
    --src ../deploy.zip
```

## Configuration

The server uses FastMCP which handles the MCP protocol communication. No additional configuration is required for basic usage.

## Error Handling

The server includes comprehensive error handling for:

- Invalid YouTube URLs
- Missing transcripts
- Network errors
- General transcription failures

All errors are logged and returned with descriptive messages.

## Dependencies

See `requirements.txt` for the complete list of dependencies:

- `langchain`: LangChain framework
- `langchain-community`: Community integrations for LangChain
- `youtube-transcript-api`: YouTube transcript fetching
- `requests`: HTTP library
- `fastmcp`: FastMCP framework for MCP servers

## License

[Add your license information here]

## Contributing

[Add contribution guidelines here]
