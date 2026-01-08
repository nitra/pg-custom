# Використовуємо ваш поточний базовий образ
FROM ghcr.io/cloudnative-pg/postgresql:18-system-trixie

# Перемикаємось на root для встановлення пакетів
USER root

# Оновлюємо репозиторії та встановлюємо розширення
# postgresql-18-cron -> для pg_cron
# postgresql-plpython3-18 -> для plpython3u
RUN apt-get update && \
    apt-get install -y \
    postgresql-18-cron \
    postgresql-plpython3-18 && \
    rm -rf /var/lib/apt/lists/*

# Обов'язково повертаємось до користувача postgres, як того вимагає CNPG
USER postgres

#