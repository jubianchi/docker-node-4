# docker-node-4 [![Build Status](https://travis-ci.org/jubianchi/docker-node-4.svg?branch=master)](https://travis-ci.org/jubianchi/docker-node-4)

## Why ?

Because:

* [hwestphal/nodebox](https://hub.docker.com/r/hwestphal/nodebox/) is not up-to-date (it tracks node 0.10 branch)
* you don't need a full Debian (or whatever distro) to run a single nodejs process
* nodejs 4.x is the future
* ...

## How ?

This docker image is built on top of [BusyBox](http://www.busybox.net/) (using [progrium/busybox](https://hub.docker.com/r/progrium/busybox/) as the base image)
and highly inspired of [hwestphal/nodebox](https://hub.docker.com/r/hwestphal/nodebox/).

Thanks to the size of BusyBox, the image weights about 40MB and provides everything you need to run a nodejs application.

## Use it

This is as simple as:

```sh
docker run --rm jubianchi/docker-node-4 -v
v4.1.0
```

Let's say you have an nodejs application which main file is `index.js`:

```js
'use strict';

let main = () => console.log('Hello World!');

process.on('SIGUSR2', () => main());
process.on('SIGINT', () => process.exit(1));
process.on('SIGTERM', () => process.exit(1));

main();
process.stdin.resume();
```

And you want to run it in a `docker-node-4` container:

```sh
docker run --rm -v $(pwd):/app --name test_app jubianchi/docker-node-4 /app/index.js
Hello World!
```

Now if you want to:

* restart the application: `docker kill -s SIGUSR2 test_app`
* stop the application: `docker kill test_app` or <kbd>CTRL</kbd>+<kbd>C</kbd>

Pretty simple! Now what if you want to run an actual application ?

## More complex use-case

You will likely want to run more complex application inside this container. In this case, you'll probably have to run `npm install` or whatever
is needed to make your app run. In this case you should extend this base image to build your own application container:

```
FROM jubianchi/docker-node-4

ENV NODE_ENV=production

COPY app /app

WORKDIR /app

RUN npm install && \
    npm cache clear

ENTRYPOINT ["/node-v4.1.0-linux-x64/bin/node", "/app/index.js"]
```
