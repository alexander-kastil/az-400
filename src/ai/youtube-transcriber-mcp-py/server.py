"""YouTube Transcription MCP Server

This MCP server provides tools for transcribing YouTube videos using the 
youtube-transcript-api through langchain-community's YoutubeLoader.
"""

import logging
from urllib.parse import urlparse, parse_qs

from fastmcp import FastMCP
from langchain_community.document_loaders import YoutubeLoader

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize FastMCP server
mcp = FastMCP("youtube-transcriber")


def extract_video_id(url: str) -> str:
    """Extract the video ID from a YouTube URL.
    
    Args:
        url: YouTube URL (e.g., https://www.youtube.com/watch?v=VIDEO_ID or https://youtu.be/VIDEO_ID)
        
    Returns:
        The extracted video ID
        
    Raises:
        ValueError: If the URL is not a valid YouTube URL
    """
    parsed_url = urlparse(url)
    
    # Handle youtu.be short URLs
    if parsed_url.hostname in ('youtu.be', 'www.youtu.be'):
        return parsed_url.path[1:]
    
    # Handle youtube.com URLs
    if parsed_url.hostname in ('youtube.com', 'www.youtube.com'):
        query_params = parse_qs(parsed_url.query)
        if 'v' in query_params:
            return query_params['v'][0]
    
    raise ValueError(f"Not a valid YouTube URL: {url}")


@mcp.tool()
def get_youtube_transcription(
    url: str,
    language: str = "en",
) -> str:
    """Get the transcription of a YouTube video.
    
    This tool fetches and returns the transcript of a YouTube video in the specified language.
    
    Args:
        url: The YouTube video URL (e.g., https://www.youtube.com/watch?v=VIDEO_ID or https://youtu.be/VIDEO_ID)
        language: The language code for the transcript (default: "en"). Examples: "en" for English, "es" for Spanish, etc.
        
    Returns:
        The full transcription text of the video
        
    Raises:
        ValueError: If the URL is not a valid YouTube URL
        Exception: If transcription fails for any reason
    """
    try:
        logger.info(f"Processing transcription request for URL: {url}, language: {language}")
        
        # Extract video ID from URL
        video_id = extract_video_id(url)
        logger.info(f"Extracted video ID: {video_id}")
        
        # Load the YouTube video transcript using langchain
        loader = YoutubeLoader(
            video_id=video_id,
            language=language
        )
        
        # Load the transcript
        transcript = loader.load()
        
        if not transcript:
            raise ValueError("No transcript found for this video")
        
        # Extract the content from the first document
        transcribed_content = transcript[0].page_content
        
        logger.info(f"Successfully transcribed video {video_id}, content length: {len(transcribed_content)} characters")
        
        return transcribed_content
        
    except ValueError as e:
        logger.error(f"Validation error: {e}")
        raise
    except Exception as e:
        logger.error(f"Error during transcription: {e}")
        raise Exception(f"Failed to transcribe the YouTube video: {str(e)}")


if __name__ == "__main__":
    # Run the MCP server with Streamable HTTP transport by default
    mcp.run(transport="streamable-http")
