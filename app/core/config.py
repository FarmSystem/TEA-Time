import secrets
import os
from typing import Union, Optional, Any
from pydantic import AnyHttpUrl
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = secrets.token_urlsafe(32)
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8
    SERVER_NAME: str = "localhost"
    SERVER_HOST: str = "localhost"
    """
    CORS 허용 URL 지정
    """
    BACKEND_CORS_ORIGINS: list[AnyHttpUrl] = ["http://localhost:8080", "http://localhost:8000"]
    PROJECT_NAME: str = "TeaTime"

    @staticmethod
    def assemble_cors_origin(self, v: Union[str, list[str]]) -> Union[list[str], str]:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)

    POSTGRES_SERVER: str = os.getenv("POSTGRES_SERVER") or "localhost"
    POSTGRES_USER: str = os.getenv("POSTGRES_USER") or "postgres"
    POSTGRES_PASSWORD: str = os.getenv("POSTGRES_PASSWORD") or "postgres"
    POSTGRES_DB: str = os.getenv("POSTGRES_DB") or "postgres"
    SQLALCHEMY_DATABASE_URI: str = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_SERVER}/{POSTGRES_DB}"

    def assemble_db_uri(self, v: Optional[str]) -> str:
        if isinstance(v, str):
            return v
        return self.SQLALCHEMY_DATABASE_URI

    def get_project_name(self, v: Optional[str]) -> str:
        if isinstance(v, str):
            return v.title()
        return self.PROJECT_NAME

    class Config:
        case_sensitive = True


settings = Settings()