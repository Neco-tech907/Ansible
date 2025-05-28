#!/bin/bash
set -e

echo "Ждём, пока мастер будет доступен..."
until pg_isready -h 192.168.9.100 -U repl_user; do
  echo "Ожидаем доступность мастера..."
  sleep 2
done

echo "Полностью очищаем PGDATA вручную..."
rm -rf "$PGDATA"/*

echo "Копируем данные с мастера через pg_basebackup..."
export PGPASSWORD=debian
su postgres -c "pg_basebackup -R -h 192.168.9.100 -U repl_user -D '$PGDATA' -Fp -Xs -P"

echo "Репликация завершена, устанавливаем права и запускаем PostgreSQL..."
chown -R postgres:postgres "$PGDATA"
chmod 0700 "$PGDATA"

exec su postgres -c "postgres"
