#!/bin/bash
set -e

# Ждем пока каталог будет создан (обычно создается при инициализации БД)
until [ -d /var/lib/postgresql/data ]; do
  sleep 1
done

# Добавляем настройки в конфигурационные файлы
{
  echo "listen_addresses = '*'"
  echo "archive_mode = on"
  echo "archive_command = 'mkdir -p /oracle/pg_data/archive && cp %p /oracle/pg_data/archive/%f'"
  echo "max_wal_senders = 10"
  echo "wal_level = replica"
  echo "wal_log_hints = on"
} >> /var/lib/postgresql/data/postgresql.conf


echo "host replication repl_user 192.168.9.0/24 scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf

# Запускаем основной процесс
exec "$@"

