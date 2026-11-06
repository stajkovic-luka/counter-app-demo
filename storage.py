import os

import redis


def get_client():
    return redis.Redis(
        host=os.getenv("REDIS_HOST", "localhost"),
        port=int(os.getenv("REDIS_PORT", "6379")),
        decode_responses=True,
    )


def increment() -> int:
    return get_client().incr("visits")


def ping() -> bool:
    try:
        return get_client().ping()
    except redis.exceptions.ConnectionError:
        return False
