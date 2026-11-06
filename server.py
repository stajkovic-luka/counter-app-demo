import socket

import redis
import storage
from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI()


@app.get("/")
def root():
    host = socket.gethostname()
    print(f"GET / host={host}")
    return {"message": "Hey!", "host": host}


@app.get("/visits")
def visits():
    print("GET /visits")
    try:
        return {"visits": storage.increment()}
    except redis.exceptions.ConnectionError:
        return JSONResponse(status_code=503, content={"status": "error"})


@app.get("/health")
def health():
    if storage.ping():
        return {"status": "ok"}
    return JSONResponse(status_code=503, content={"status": "redis unavailable"})
