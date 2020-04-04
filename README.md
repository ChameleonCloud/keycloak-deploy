# keycloak-deploy

## Notes

You MUST start mariadb first and wait until it is reachable. This can take upwards of 2 minutes.
Wait until you see a line like "MySQL init process done. Ready for start up."

```shell
docker-compose up -d mariadb
docker-compose logs -f mariadb
```

Then you can start everything else:

```shell
VIRTUAL_HOST=... docker-compose up -d
```
