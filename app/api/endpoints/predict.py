from fastapi import APIRouter
from app.ai.emotion_model import EmotionModel
from pydantic import BaseModel

router = APIRouter()


class PredictData(BaseModel):
    data: str


@router.post("/predict")
async def predict(predict_data: PredictData):
    emotion = EmotionModel()
    result = emotion.analyze_emotion(predict_data.data)
    return {"message": result}