# SPDX-FileCopyrightText: 2022-2025 Tim Hawes <me@timhawes.com>
#
# SPDX-License-Identifier: CC0-1.0

FROM python:3.13-alpine
COPY --from=ghcr.io/astral-sh/uv:0.8.14 /uv /uvx /bin/

COPY . /app
WORKDIR /app
RUN uv sync --locked
ENV PATH="/app/.venv/bin:$PATH"

ENV DJANGO_SETTINGS_MODULE=tokenmanager.settings_docker

RUN rm -f db.sqlite3 local_settings.py settings_local.py \
    && apk add runuser \
    && adduser -D django \
    && python manage.py check \
    && python manage.py makemigrations

COPY docker-entrypoint.sh /docker-entrypoint.sh

ARG GIT_COMMIT
ENV GIT_COMMIT=${GIT_COMMIT}

EXPOSE 8000
VOLUME [ "/data/config", "/data/database", "/data/static" ]
ENTRYPOINT ["/docker-entrypoint.sh"]
