from fastapi import APIRouter

from app.api.endpoints import core
from app.api.endpoints import predict

api_router = APIRouter()
api_router.include_router(core.router, tags=["core"])
api_router.include_router(predict.router, tags=["predict"])