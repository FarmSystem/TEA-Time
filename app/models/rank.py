from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

from app.database.base import Base

if TYPE_CHECKING:
    from .user import User


class Rank(Base):
    __tablename__ = "rank"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"))
    grade = Column(String(50))
    exp = Column(Integer)
    user = relationship("User", back_populates="rank")
