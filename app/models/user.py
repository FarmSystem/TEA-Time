from typing import TYPE_CHECKING

from sqlalchemy import Column, JSON, String, TIMESTAMP, BigInteger
from sqlalchemy.orm import relationship

from app.database.base import Base


class User(Base):
    __tablename__ = "user"
    id = Column(BigInteger, primary_key=True, index=True)
    nickname = Column(String(50), unique=True, index=True)
    userinfo = Column(JSON)
    profile_url = Column(String(200))
    role_type = Column(String(50))
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
    rank = relationship("Rank", uselist=False, back_populates="user")
    authentication = relationship("Authentication", uselist=False, back_populates="user")
    status = relationship("Status", uselist=False, back_populates="user")
    diaries = relationship("Diary", back_populates="user")
    reaction = relationship("Reaction", back_populates="user")
