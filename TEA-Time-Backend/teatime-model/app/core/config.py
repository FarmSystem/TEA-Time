import secrets
import os
from typing import Union, Optional, Any
from pydantic import AnyHttpUrl
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    API_V1_STR: str = "/model"
    SERVER_NAME: str = "localhost"
    SERVER_HOST: str = "localhost"
    """
    CORS 허용 URL 지정
    """
    BACKEND_CORS_ORIGINS: list[AnyHttpUrl] = ["http://localhost:8080", "http://localhost:8000"]
    PROJECT_NAME: str = "TeaTime Base API Server"
    EUREKA_SERVER: str = "http://localhost:8761/eureka/"
    APP_NAME: str = "teatime-model"
    INSTANCE_PORT: int = 8082

    @staticmethod
    def assemble_cors_origin(self, v: Union[str, list[str]]) -> Union[list[str], str]:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)

    def get_project_name(self, v: Optional[str]) -> str:
        if isinstance(v, str):
            return v.title()
        return self.PROJECT_NAME

    class Config:
        case_sensitive = True


settings = Settings()