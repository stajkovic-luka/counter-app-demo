FROM python:3.12-alpine
WORKDIR /app

ENV APP_PORT=8080

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY server.py storage.py ./

RUN adduser -D appuser
USER appuser

EXPOSE 8080
CMD ["sh","-c","exec uvicorn server:app --host 0.0.0.0 --port ${APP_PORT}"]
