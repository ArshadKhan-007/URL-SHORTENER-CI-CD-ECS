FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get upgrade -y --no-install-recommends \
    && rm -rf /var/lib/apt/list/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip uninstall -y setuptools wheel

RUN adduser --disabled-password --gecos "" --no-create-home appuser

COPY --chown=appuser:appuser app/ ./app/

USER appuser

EXPOSE 8000

CMD ["sh", "-c", "python -m app.init_db && exec uvicorn app.main:app --host 0.0.0.0 --port 8000"]