from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
import pickle

app = FastAPI()

# Define Pydantic models for request and response
class DiaryInput(BaseModel):
    content: str

class EmotionResponse(BaseModel):
    emotion: str

# Load the model once when the application starts
class EmotionAnalyzer:
    def __init__(self, model_path="model/emotion_analyzer.pkl"):
        with open(model_path, 'rb') as f:
            self.model = pickle.load(f)

    def analyze_emotion(self, text: str):
        return self.model.analyze_emotion(text)

# Dependency to load model
def get_analyzer() -> EmotionAnalyzer:
    return EmotionAnalyzer()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/predict", response_model=EmotionResponse)
def predict(diary: DiaryInput, analyzer: EmotionAnalyzer = Depends(get_analyzer)):
    try:
        emotion_result = analyzer.analyze_emotion(diary.content)
        return EmotionResponse(emotion=emotion_result)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)