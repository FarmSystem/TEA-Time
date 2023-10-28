from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, JSON, String
from sqlalchemy.orm import relationship

from app.database.base_class import Base

if TYPE_CHECKING:
    from .diary import Diary


class DiaryResult(Base):
    __tablename__ = "diary_result"
    id = Column(Integer, primary_key=True, index=True)
    diary_id = Column(Integer)
    emotions = Column(JSON, nullable=True)
    sentences = Column(JSON, nullable=True)
    summation = Column(String(50), nullable=True)
    diary = relationship("Diary", back_populates="diary_result")