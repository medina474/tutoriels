

Installation Raspberry

```shell
sudo apt update && sudo apt upgrade -y
sudo reboot
```
Installation

```shell
sudo apt install postgresql
```

```shell
sudo nano /etc/postgresql/17/main/pg_hba.conf
```

```
host    all    all     0.0.0.0/0     scram-sha-256
```

```shell
sudo nano /etc/postgresql/17/main/postgresql.conf
```

```
listen_addresses = '*'
```

```shell
sudo systemctl restart postgresql
sudo -u postgres psql
```

```sql
create user belhocine WITH password 'geii2025';
create database belhocine OWNER belhocine;
```

useradd -m -p geii2025 bananga
