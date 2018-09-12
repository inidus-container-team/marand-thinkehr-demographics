# Marand Think!EHR Demographics

Provides a docker container for Marand Think!EHR Demographics service.

## Getting Started
These instructions will get you a Think!EHR Demographics service up and running on your local machine for development and testing purposes.

### Modify application.properties
Docker COPYs `conf/application.properties` when building the image. See `conf/README.md` for example config.

### Build the image
- `docker build . -t demographics-app`

### Run the container
Start a PostgreSQL container

- `docker run --name demographics-db -e POSTGRES_USER=demographics -e POSTGRES_PASSWORD=demographics -e POSTGRES_DB=demographics -d postgres`

Start a Demographics container
- `docker run --name demographics-app -e SPRING_DATASOURCE_URL=jdbc:postgresql://demographics-db/demographics -e SPRING_DATASOURCE_USERNAME=demographics -e SPRING_DATASOURCE_PASSWORD=demographics --link db:postgres -d  demographics-app`

Follow the logs
- `docker logs -f demographics-app`

### Testing with Docker Compose
- `docker-compose -f stack.yml up`

### Deploy as Docker stack
- `docker stack deploy -c stack.yml test`

### Backup the database
- `docker run -it --rm --link demographics-db:postgres postgres psql -h demographics-db -U demographics`
