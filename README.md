# Docker Compose for Webstrates

Setting up a Webstrates server requires setting up a MongoDB, checking out the source code from GitHub, building, configuring and running the server. We created this Docker Compose project to ease this process, and provide two alternative preset configurations: (i) a no-ssl configuration where the Webstrates server is accessible on `http://localhost:7007/` and (ii) a with-ssl configuration where the Webstrates server is accessible via `https://webstrates.local/`.

## Run Webstrates server (no-ssl configuration)

Start the Webstrates server with the following docker compose command.

```
cp config/config-sample.json config/config.json
cd no-ssl
docker-compose up -d
```

It takes a few seconds until the mongodb and the Webstrates server are up and running. When they are running, navigate to [http://localhost:7007/](http://localhost:7007/)

You can stop the docker containers with `docker-compose down`.

## Run Webstrates server with nginx and SSL

This section is based on the [Medium article](https://medium.com/@francoisromain/set-a-local-web-development-environment-with-custom-urls-and-https-3fbe91d2eaf0) by François Romain

### Make an url point to localhost
To have the custom url `webstrates.local` pointing to localhost, we need to modifiy the `/etc/hotst` file. In the terminal, edit the hosts file with the `nano` texteditor.

```
sudo nano /etc/hosts
```

Navigate with the arrows to the end of the file and add the line:

```
127.0.0.1        webstrates.local
```

Type `ctrl + x`, then `y` to save and exit nano. Now, the custom url points to localhost.

### Add HTTPS

#### Create a self-signed SSL certificate for a custom domain
To create the certificates, we use the create-ssl-certificate command line tool (by Christian Alfoni). First we install it globally with `npm i -g create-ssl-certificate`.

    * go to ./nginx-proxy/certs/.
    * issue a certificate with create-ssl-certificate --hostname webstrates --domain local.
    * Rename the files ssl.crt and ssl.key to webstrates.local.crt and webstrates.local.key.

#### Trust the certificate
    * Add the webstrates.local.crt file to the Keychain Access app.
    * In Keychain Access, click on the certificate name to open a popup.
    * In this popup, click on the small arrow in front of Trust.

In When using this certificate, select Always trust and close the popup.
Now Chrome trusts the certificate. Firefox is a bit more picky and we have to explicitly trust the certificate when prompted.

### Start docker containers

Then start the docker containers with the following command and wait until mongodb, nginx, and Webstrates server are up and running.

```
cp config/config-sample.json config/config.json
cd with-ssl
docker-compose up -d
```

When they are running, navigate to [https://webstrates.local/](https://webstrates.local/)

You can stop the docker containers with `docker-compose down`.

# Acknowledgements

The docker compose for Webstrates is inspired by François Romain who wrote an excellent Medium article on how to set up Docker Compose with the [nginx-proxy](https://github.com/jwilder/nginx-proxy) by Jason Wilder