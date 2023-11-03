from fastapi import APIRouter
from app.ai.emotion_model import EmotionModel
from app.schemas.emotion import PredictData

router = APIRouter()


@router.post("/predict")
async def predict(predict_data: PredictData):
    emotion = EmotionModel()
    result = emotion.analyze_emotion(predict_data.data)
    return {"message": result}