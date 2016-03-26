# dockerized-airdcpp-webclient
Dockerization of https://github.com/airdcpp-web/airdcpp-webclient

Only tested on Linux

## Dependencies
- [Docker](https://docs.docker.com/engine/installation/)
- [Compose](https://docs.docker.com/compose/install/)
- Config files in `~/.airdc++` on host machine, at the minimum the below content in `~/.airdc++/WebServer.xml`
```
<WebServer>
	<Config>
		<Server Port="5600"/>
		<TLSServer Port="5601"/>
	</Config>
	<WebUsers>
		<WebUser Username="admin" Password="admin" LastLogin="1458996101" Permissions="admin"/>
	</WebUsers>
</WebServer>
```

## Run
```
docker-compose -d up
```
