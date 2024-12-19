# websync docker
Websync updated to run on alpine linux with newer ssh and container format.  
Original from ```https://github.com/furier/websync```  

## websync@docker

websync can now be found @ docker, get it [here](https://registry.hub.docker.com/r/gibbz/websync)!

All you have to do is
```
sudo docker pull gibbz/websync
sudo docker run -d -p 3000:3000 -v /path/share:/path/share furier/websync
```
and you are done!

## docker compose
Create a websync folder with empty wsdata.json file if you want to store a copy of your data.
```
services:
  websync:
    image: gibbz/websync
    container_name: websync
    restart: unless-stopped
    volumes:
      - /backup_dir:/backup
      - /source_dir:/source
      - ./websync/wsdata.json:/src/wsdata.json
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 3000:3000
```

## dockerfile build notes

### To build from Dockerfile
```docker build -t gibbz/websync .```

### Open an image for browsing
```docker run -i -t gibbz/websync /bin/sh```


### Connect to a container
First run the container
```docker container run --name debug -d -w /src gibbz/websync node server.js```

Then connect
```docker container exec -it debug /bin/sh```
