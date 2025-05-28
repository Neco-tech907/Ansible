# Используем официальный образ PostgreSQL
FROM postgres:15-alpine

# Настройки окружения

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=1234
#ENV POSTGRES_DB=contacts

COPY dump.sql /docker-entrypoint-initdb.d/


RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data && \
    chmod 700 /oracle/pg_data/archive

# Копируем SQL-скрипты для инициализации (если нужны)
COPY init.sql /docker-entrypoint-initdb.d/

COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Опционально: настраиваем порт
EXPOSE 5432
