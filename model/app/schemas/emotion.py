from pydantic import BaseModel


class PredictData(BaseModel):
    content: str
