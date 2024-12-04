# SPDX-FileCopyrightText: 2022-2024 Tim Hawes <me@timhawes.com>
#
# SPDX-License-Identifier: CC0-1.0

FROM python:3.13

WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install --require-hashes -r requirements.txt

COPY . .

ENV DJANGO_SETTINGS_MODULE=tokenmanager.settings_docker

RUN rm -f db.sqlite3 local_settings.py settings_local.py \
    && useradd django \
    && python manage.py check \
    && python manage.py makemigrations

COPY docker-entrypoint.sh /docker-entrypoint.sh

ARG GIT_COMMIT
ENV GIT_COMMIT=${GIT_COMMIT}

EXPOSE 8000
VOLUME [ "/data/config", "/data/database", "/data/static" ]
ENTRYPOINT ["/docker-entrypoint.sh"]
