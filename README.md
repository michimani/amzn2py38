amzn2py38
---
Amazon Linux 2 with Python 3.8 installed. 

# Usage 

Use this image for creating AWS Lambda Layers for runtime Python 3.8.

```
.
├── Dockerfile
├── dist
├── docker-compose.yml
└── requirements.txt
```

### `Dockerfile`

```dockerfile
FROM michimani/amzn2py38:latest

RUN mkdir /home/dist
```

### `docker-compose.yml`

```yaml
version: "3"
services:
  app:
    build: .
    volumes:
      - ".:/home"
    command: >
      bash -c "
      mkdir -p /home/tmp/python &&
      pip3.8 install -r /home/requirements.txt -t /home/tmp/python --upgrade &&
      cd /home/tmp &&
      zip -r /home/dist/layer.zip ./python &&
      cd /home &&
      rm -rf /home/tmp"
```

Run following command to generate ZIP file for AWS Lambda Layers.

```bash
$ docker-compose up --build
```

And, run following AWS CLI command to publish layer.

```bash
$ aws lambda publish-layer-version --layer-name my_layer --zip-file fileb://dist/layer.zip
```

