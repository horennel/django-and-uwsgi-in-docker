## django-and-uwsgi-on-docker

-This is a test program about Django, uwsgi and docker

### Start

```
docker build -t centos:01 .
docker run --name django01 -p 8001:8001 -d centos:01
docker builder prune
```
-Test url: http://localhost:8001