Relica web requires being accessed from localhost origin only.

Locally (using Docker net host):

```shell
docker build -t rjocoleman/relica .
docker run -v config-dir:/root/.relica -v storage:/storage --net=host rjocoleman/relica
```
