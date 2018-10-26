## Relica Docker Container - Unofficial

This is an unoffical Docker container to run [Relica Backup](https://relicabackup.com/).

If you like it please consider signing up with my [referral link](https://relicabackup.com/download?refid=e9d5fe71-6b90-480b-bd37-65d145b6df1b).

Relica is designed to be run on your local machine and there are a number of challenges to running it remotely, which this container aims to solve.

This container, if properly configured, is suitable to run on NAS or other remote machines.


## Features:

* Automatically download the latest version when the container is started.
* Suitable for local usage on http://localhost:1201 or remote usage on :1301
* Configurable User and Group (to avoid permissions issues when using host filesystems)
* HTTP Basic Auth (optional)
* Automatic HTTPS for domain names, if used (via Caddy)


### Configuration

```shell
# reccomended
RUID # 911
RGID # 1000

# optional
WEB_USERNAME
WEB_PASSWORD
LISTEN_ADDRESS # *
```

### Usage


```shell
docker run -v $(pwd)/config-dir:/config -v $(pwd)/backup-dir:/backup -p 1301:1301/tcp -e RGID=998 -e RUID=1000 rjocoleman/relica
open http://127.0.0.1:1301
```


### TODO

* Better documentation
* relica CMD usage
