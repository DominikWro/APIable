FROM python:3.6

RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
RUN pip install pipenv && pipenv install --system

COPY . /opt/services/djangoapp/src
RUN cd APIable && python manage.py collectstatic --no-input  # <-- here

EXPOSE 8000
CMD ["gunicorn", "--chdir", "APIable", "--bind", ":8000", "APIable.wsgi:application"]