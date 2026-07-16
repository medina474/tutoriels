  sonarqube:
    image: sonarqube:community
    depends_on:
      database:
        condition: service_healthy
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://database:5432/sonarqube
      SONAR_JDBC_USERNAME: sonarqube_user
      SONAR_JDBC_PASSWORD: supermotdepasse
    ports:
      - "9000:9000"
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_temp:/opt/sonarqube/temp

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  sonarqube_temp:


```sql
create role sonarqube_user with
  login
  nosuperuser
  nocreatedb
  nocreaterole
  noinherit
  noreplication
  connection limit -1
  password 'supermotdepasse';

create database sonarqube with
  owner sonarqube_user;
```
