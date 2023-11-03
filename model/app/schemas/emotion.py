from pydantic import BaseModel


class PredictData(BaseModel):
    data: str


class PostReactionRequest(BaseModel):
    reaction: str