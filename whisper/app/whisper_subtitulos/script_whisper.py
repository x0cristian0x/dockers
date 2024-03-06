from datetime import timedelta
import os
import whisper

# charge directory
os.chdir("/app")

# lista de carpetas
paths = []
[paths.append(f) for f in os.listdir() if os.path.isdir(f) ]


# lista de files .mp4
files = []
for i in paths:
    for j in os.listdir(i):
        if j[-4:] == ".mp4":
            files.append( i+"/"+j)

# Modelo
model = whisper.load_model("medium") 

# function
def transcribe_audio(path):
 
    transcribe = model.transcribe(audio=path)
    segments = transcribe['segments']

    for segment in segments:
        startTime = str(0)+str(timedelta(seconds=int(segment['start'])))+',000'
        endTime = str(0)+str(timedelta(seconds=int(segment['end'])))+',000'
        text = segment['text']
        segmentId = segment['id']+1
        segment = f"{segmentId}\n{startTime} --> {endTime}\n{text[1:] if text[0] == ' ' else text}\n\n"

        srtFilename = path[:-4]+ ".srt"
        with open(srtFilename, 'a', encoding='utf-8') as srtFile:
            srtFile.write(segment)

    return srtFilename

# transcripcion
for i in range(len(files)):
    transcribe_audio(files[i])