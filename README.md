# youtube-dl-api
A server application with bookmarklet that allows you to tell a server to download videos. Created as a replacement for Plex's Watch Later feature.

## Step 1: Install
The best way to install is to use Docker, though this just uses python so you could run things manually.

docker-compose.yml:
```
  youtube-dl-api:
    build: youtube-dl-api
    container_name: youtube-dl-api
    restart: always
    ports:
      - 8080
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /storage/video/Watch Later:/data
    environment:
      - TOKEN=${TOKEN}
      - EXTHOST=https://youtube-dl-api.${DOMAINNAME}
      - FORMAT=%(title)s - %(uploader)s - %(id)s.%(ext)s
      - TZ=${TZ}
      - PUID=${PUID}
      - PGID=${PUID}
    networks:
      - traefik_proxy
    labels:
      - "traefik.enable=true"
      - "traefik.tags=frontend"
      - "traefik.frontend.passHostHeader=true"
      - "traefik.admin.backend=youtube-dl-api"
      - "traefik.admin.frontend.rule=Host:youtube-dl-api.${DOMAINNAME}"
      - "traefik.admin.port=8080"
      - "traefik.admin.protocol=http"
      - "traefik.frontend.headers.SSLRedirect=true"
      - "traefik.frontend.headers.STSSeconds=315360000"
      - "traefik.frontend.headers.browserXSSFilter=true"
      - "traefik.frontend.headers.contentTypeNosniff=true"
      - "traefik.frontend.headers.forceSTSHeader=true"
      - "traefik.frontend.headers.STSIncludeSubdomains=true"
      - "traefik.frontend.headers.STSPreload=true"
      - "traefik.frontend.headers.frameDeny=true"
```

A token can be any random string, but you can generate them here: https://www.guidgenerator.com/online-guid-generator.aspx

The external host variable should be whatever URL is used to access the service remotely.

The `/data` volume is where videos are downloaded to.

`FORMAT` is optional and can be used to control the filename format for `youtube-dl`.

## Step 2: Get your bookmarklet
Visit `https://youtube-dl-api.${DOMAINNAME}?token=037816e898d2497b8a93e3be4d42ada9`

Now drage the `Watch Later` link into your bookmarks.

## Step 3: Use it
When on a page with a video, simply click the bookmarklet.
