from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, JSON, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship

from app.database.base_class import Base

if TYPE_CHECKING:
    from .user import User


class Diary(Base):
    __tablename__ = "diary"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"))
    diary = Column(JSON)
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
    user = relationship("User", back_populates="diaries")
    reaction = relationship("Reaction", back_populates="diary")
