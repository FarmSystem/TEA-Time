from pydantic import BaseModel
from datetime import date


class GetUserInfoResponse(BaseModel):
    nickname: str
    grade: str
    exp: int


class GetMyInfoResponse(BaseModel):
    nickname: str
    grade: str
    exp: int
    email: str
    gender: str
    birth: date
