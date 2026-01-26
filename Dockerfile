# Використовуємо поточний базовий образ
FROM ghcr.io/cloudnative-pg/postgresql:18.1-system-trixie

# Перемикаємось на root для встановлення пакетів
USER root

# Оновлюємо репозиторії та встановлюємо розширення
# postgresql-18-cron -> для pg_cron
# postgresql-plpython3-18 -> для plpython3u
# python3-pip -> для встановлення Python пакетів
# libldap -> системна бібліотека (пакет Debian trixie: libldap2)
RUN apt-get update && \
    apt-get install -y \
    postgresql-18-cron \
    postgresql-plpython3-18 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Копіюємо requirements.txt та встановлюємо Python пакети
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages --ignore-installed -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Обов'язково повертаємось до користувача postgres, як того вимагає CNPG
USER postgres
