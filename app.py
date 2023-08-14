from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from new_model.pickle_load import get_emotion
import uvicorn

app = FastAPI()

class DiaryInput(BaseModel):
    content: str

class EmotionResponse(BaseModel):
    emotion: dict[str, int]

@app.get("/api/health")
def health():
    return {"status": "ok"}


@app.post("/api/predict", response_model=EmotionResponse)
def predict(diary: DiaryInput):
    try:
        emotion_result = get_emotion(diary.content)
        return EmotionResponse(emotion=emotion_result)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)
