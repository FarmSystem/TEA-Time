from pydantic import BaseModel
from typing import Optional


class PostDiaryRequest(BaseModel):
    title: str
    content: str
    emotion: str
    is_private: bool


class PatchDiaryResponse(BaseModel):
    id: int
    title: str
    content: str
    emotion: str
    is_private: bool
    created_at: str
    updated_at: str


class GetDiaryResponse(BaseModel):
    id: int
    title: str
    summary: str
    emoji: str
    picture_url: str
    emotion: Optional[str] = None
    is_private: Optional[bool] = None
