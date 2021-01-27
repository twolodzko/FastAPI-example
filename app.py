#!/usr/bin/env python

import time
import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime

app = FastAPI()
STARTUP_TIME: float


@app.on_event('startup')
def startup():
    """
    Run this function when initializing the app.
    """
    global STARTUP_TIME
    STARTUP_TIME = time.time()


@app.get("/")
def root():
    return {"message": "I'm running!"}


@app.get('/hello')
def hello():
    return {"message": "Hello World!"}


@app.get('/hello/{name}')
def hello_get(name: str):
    return {"message": f"Hello {name}!"}


@app.get('/runtime')
async def runtime():
    global STARTUP_TIME
    seconds = time.time() - STARTUP_TIME
    return {"message": f"I've been running for {seconds:.1f} seconds"}


class Data(BaseModel):
    timestamp: datetime
    name: str
    value: float



@app.post('/data')
def post_data(data: Data):
    return {
        "data_age_seconds": datetime.now() - data.timestamp,
        "name": data.name,
        "value/2": data.value/2,
    }


if __name__ == "__main__":
    uvicorn.run("app:app", host="0.0.0.0", port=8000)
