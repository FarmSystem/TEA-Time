from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship

from app.database.base_class import Base

if TYPE_CHECKING:
    from .user import User


class Authentication(Base):
    __tablename__ = "authentication"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"))
    access_token = Column(String(50))
    refresh_token = Column(String(50))
    expire_duration = Column(Integer)
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
    user = relationship("User", back_populates="authentication")