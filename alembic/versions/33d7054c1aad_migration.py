"""migration

Revision ID: 33d7054c1aad
Revises: ca90d428fa17
Create Date: 2023-10-28 20:35:41.000536

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '33d7054c1aad'
down_revision: Union[str, None] = 'ca90d428fa17'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    pass


def downgrade() -> None:
    pass
