from typing import TYPE_CHECKING

from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from app.database.base_class import Base

if TYPE_CHECKING:
    from .user import User
    from .diary import Diary


class Reaction(Base):
    __tablename__ = "reaction"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    diary_id = Column(Integer)
    reaction_type = Column(String(50))
    diary = relationship("Diary", back_populates="reaction")
    user = relationship("User", back_populates="reaction")
