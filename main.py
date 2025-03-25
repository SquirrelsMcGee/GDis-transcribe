import io

import torch
from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from faster_whisper import WhisperModel

# Initialize the FastAPI app
app = FastAPI()

# Check if CUDA is available and select the appropriate device
device = "cuda" if torch.cuda.is_available() else "cpu"

print("using device=" + device)

# Initialize the Faster-Whisper model (with CUDA support)
model_id = "large-v3-turbo" #"large"
model = WhisperModel("large", device=device)  # Choose "base", "small", "medium", or "large"

@app.post("/transcribe")
async def transcribe_audio(file: UploadFile):
    try:
        # Read the file data (ensure it is in binary format)
        file_content = await file.read()

        # Load the audio file from the byte content into a BytesIO buffer
        audio = io.BytesIO(file_content)
        
        # Run transcription using faster-whisper
        segments, info = model.transcribe(audio, "en")

        # Extract the transcriptions and time codes
        print(segments)
        transcription = ""
        for segment in segments:
            part = segment.text
            transcription += part
        
        # Return the transcription result as a JSON response
        return JSONResponse(content={"transcription": transcription, "info": info})

    except Exception as e:
        # Handle errors
        print(e)
        return JSONResponse(content={"error": str(e)}, status_code=500)

# To run the API, use the following command (without quotes):
# uvicorn main:app --reload --port 5005