from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
import uvicorn
# from py_eureka_client import eureka_client
from app.api.api import api_router
from app.core.config import settings


"""
OpenAPI docs: http://localhost:8080/model/docs
"""
app = FastAPI(
    title=settings.PROJECT_NAME, docs_url="/model/docs", openapi_url="/model"
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
Eureka Server Registration
"""
# @app.on_event("startup")
# async def startup_event():
#     await eureka_client.init_async(
#         eureka_server = settings.EUREKA_SERVER,
#         app_name = settings.APP_NAME,
#         instance_port = settings.INSTANCE_PORT
#     )

"""
API 라우터 경로를 /model으로 지정
"""
app.include_router(api_router, prefix=settings.API_V1_STR)

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", reload=True, port=8082)