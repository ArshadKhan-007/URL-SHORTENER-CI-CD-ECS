"""Create tables if they do not exist. Runs once at container start."""

from app import models  # noqa: F401  (registers the tables on Base)
from app.database import Base, engine


def main():
    Base.metadata.create_all(bind=engine)


if __name__ == "__main__":
    main()
