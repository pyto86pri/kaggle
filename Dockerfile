FROM python:3.7-slim

RUN apt-get -yq update && \
    apt-get install -yq tk-dev curl

ENV PIP_NO_CACHE_DIR=true \
    POETRY_VERSION=1.1.4 \
    POETRY_HOME=/opt/poetry \
    POETRY_VIRTUALENVS_CREATE=false
ENV PATH ${POETRY_HOME}/bin:$PATH

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

WORKDIR /app
COPY ./pyproject.toml ./poetry.lock /app/

RUN poetry install

RUN jupyter serverextension enable --py jupyterlab
