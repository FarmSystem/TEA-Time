from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
import uvicorn
from app.api.api import api_router
from app.core.config import settings


"""
OpenAPI docs: http://localhost:8080/api/docs
"""
app = FastAPI(
    title=settings.PROJECT_NAME, docs_url="/api/docs", openapi_url="/api"
)


"""
CORS middleware 지정
"""
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )


"""
API 라우터 경로를 /api/v1으로 지정
"""
app.include_router(api_router, prefix=settings.API_V1_STR)

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", reload=True, port=8000)