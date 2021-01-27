# Example of simple FastAPI sevice

Example of simple container for FastAPI REST service. To run it from docker container use `make run` command.
You can also run it locally with `make local`, but you need to install the dependencies first, e.g.
`pip install -r requirements.txt`. There are example API calls to the service in Makefile, they can be 
invoked using `make calls` (assuming that the service is running).

See also:
 - [FastAPI documentation](https://fastapi.tiangolo.com/tutorial/)
 - [Flask vs FastAPI comparison](https://testdriven.io/blog/moving-from-flask-to-fastapi/#deployment)
 - [Introduction to curl](https://www.baeldung.com/curl-rest)
 - [Uvicorn documentation](https://www.uvicorn.org/)
