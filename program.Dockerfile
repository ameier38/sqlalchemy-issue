FROM python:3.7

WORKDIR /app

RUN apt-get update && apt-get install -y libpq-dev

COPY Pipfile .
COPY Pipfile.lock .

ENV PYTHONPATH=/app:/app

RUN pip install pipenv \
    && pipenv install --system --deploy

COPY . .

ENTRYPOINT ["python", "main.py"]
