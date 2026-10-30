FROM python:3.12-slim
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
COPY manifest.webmanifest .
COPY static ./static
# Hugging Face Spaces uses port 7860 by default.
# /data can be mounted to persistent storage from Space settings.
RUN mkdir -p /app/data && chown -R 10001:10001 /app/data
ENV DATABASE_PATH=/app/data/omidwar.db
EXPOSE 8000
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]
