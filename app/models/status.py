from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, Float, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship

from app.database.base_class import Base

if TYPE_CHECKING:
    from .user import User


class Status(Base):
    __tablename__ = "status"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"))
    score = Column(Float)
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
    user = relationship("User", back_populates="status")
