# TEA-Time-Backend

---

## Migration

```
alembic revision -m "model migration"
alembic upgrade head
```

or

```
python pre_start.py
```

---

## Environment Variable

```
POSTGRES_SERVER=hostname
POSTGRES_USER=user
POSTGRES_PASSWORD=password
POSTGRES_DB=dbname
SQLALCHEMY_DATABASE_URI=dburl
```

---

## model file
```
weights.h5
```
in root directory
