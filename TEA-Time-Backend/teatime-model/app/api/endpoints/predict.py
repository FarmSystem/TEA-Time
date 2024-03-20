from fastapi import APIRouter
from app.ai.emotion_model import EmotionModel
from app.schemas.emotion import PredictData

router = APIRouter()


@router.post("/predict")
async def predict(predict_data: PredictData):
    emotion = EmotionModel()
    score, emotions = emotion.analyze_emotion(predict_data.content)
    return {"score": score, "emotion": emotions}