from pydantic import BaseModel


class PredictData(BaseModel):
    data: str
