This is an experimental prototype and should not be used for anything!


Relica web requires being accessed from localhost origin only.

Locally (using Docker net host):
There is an older commit in the history that does just this.

```shell
docker build -t rjocoleman/relica .
docker run -v config-dir:/root/.relica -v storage-dir:/storage --net=host rjocoleman/relica
open http://127.0.0.1:1201
```

Remote (via Caddy as a proxy):

```shell
docker build -t rjocoleman/relica-caddy .
docker run -v config-dir:/root/.relica -v storage-dir:/storage -p 1301:1301/tcp rjocoleman/relica-caddy
open http://127.0.0.1:1301
```

In Caddy mode the env variables WEB_USERNAME and WEB_PASSWORD can be set for HTTP basic auth
