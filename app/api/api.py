from fastapi import APIRouter

from app.api.endpoints import core

api_router = APIRouter()
api_router.include_router(core.router, tags=["core"])
