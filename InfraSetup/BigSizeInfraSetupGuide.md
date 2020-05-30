# 
1. [prepare-master-instance-which-make-worker-instances](#prepare-master-instance-which-make-worker-instances)
2. [master-instance-config-on-your-bashrc](#master-instance-config-on-your-bashrc)
3. [login-cloud-instance-on-master-instance](#login-cloud-instance-on-master-instance)
4. [docker-login-and-push-your-docker-image-google-container-registry](#docker-login-and-push-your-docker-image-google-container-registry)
5. [docker-swarm-config](#docker-swarm-config)
6. [make-instance-and-deploy-on-swarm-network](#make-instance-and-deploy-on-swarm-network)
7. [modulize](#modulize)

# Prepare Master Instance which make worker instances.
- Docker > 19.03
- DockerMachine > 0.16
- Google Cloud SDK > 273.0.0

# Master Instance config on your .bashrc
```
export MASTER_INSTANCE_PUBLIC_IP=$(curl ipecho.net/plain; echo)
```

# Login Cloud Instance on Master Instance
  - gcloud : ```gcloud auth application-default login```
  - awscli : ```aws configure```

# Docker Login and push your docker image (Google Container Registry)
- [Pull And Push Docker Image On Google Cloud](https://medium.com/google-cloud/using-googles-private-container-registry-with-docker-1b470cf3f50a)
  - Install gcloud
  - Gcloud Login
    - ```gcloud auth application-default login```
  - Docker Login
    - [Check Pricing](https://cloud.google.com/storage/pricing)
      - Data Comunication on Same Location (Not Same Region)
        ```
        us-east1 -> us-east1 (free)
        us-east1 -> us-east2 ($0.01/GB)
        us-east1 -> asia-northeast1 ($0.12/GB)
        ```
      - Google Container Registry Use Multi Region
        ```
        us-east1 -> us (free)
        us-east1 -> asis ($0.12/GB)
        ```
    - [Make a service key](https://www.magellanic-clouds.com/blocks/guide/create-gcp-service-account-key/)
    - [HOSTNAME should be one of these](https://cloud.google.com/container-registry/docs/pushing-and-pulling)
      ```[HOSTNAME]
      gcr.io (I don't recommend this for pricing reason.)
      us.gcr.io
      eu.gcr.io
      asia.gcr.io
      ```
    - check local image
      ```docker images```
    - docker login
      ```docker login -u _json_key -p "$(cat key.json)" https://[HOSTNAME]```
    - set image tag
      ```docker image tag [IMAGE_NAME] [HOSTNAME]/[YOUR-PROJECT-ID]/[IMAGE_NAME]```
    - push docker image
      ```docker push [HOSTNAME]/[YOUR-PROJECT-ID]/[IMAGE_NAME]```
    - pull docker image
      ```docker pull [HOSTNAME]/[YOUR-PROJECT-ID]/[IMAGE_NAME]```
    - [Check Stored Image](https://console.cloud.google.com/gcr/images)


# Docker Swarm config
  - Make Swarm
    - Make Empty Instance For Swarm Master
    - Install docker, docker-compose, docker-machine
    - init swarm network
      ```
      export MASTER_INSTANCE_PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
      docker swarm init --advertise-addr $MASTER_INSTANCE_PUBLIC_IP
      export SWARM_WORKER_TOKEN=$(docker swarm join-token worker -q)
      ```

# Make Instance and Deploy on Swarm Network
1. Run/Create Machine
- Run Machine you before
```
docker-machine start
```

- Create New Machine
  - Login Cloud Instance
    - gcloud : ```gcloud auth application-default login```
    - awscli : ```aws configure```
  - create instance
    - common
      ```--swarm``` : swarm worker
      ```--engine-label type=fancyapp-worker-instance-01``` : fancyapp-worker-instance-01 instance
    - aws
      ```--driver amazonec2``` : aws instance
      ```--amazonec2-region ap-northeast-2``` : region/location
      ```--amazonec2-instance-type t3.small``` : instance type
      ```--amazonec2-root-size 10``` : instance disk size
      ```--amazonec2-security-group fancyapp-worker-port``` : for port forwarding
    - gcp
      ```--driver google``` : google instance
      ```--google-project fancyapp``` : project-name
      ```--google-zone us-east1-c``` : region/location
      ```--google-machine-type g1-small``` : instance type
      ```--google-disk-size 10``` : instance disk size
      ```--google-tags fancyapp-worker-port``` : for port forwarding

    - Create GCP Worker Instance Example
      ```
      docker-machine create \
      --driver google \
      --google-project fancyapp \
      --google-zone us-east1-c \
      --google-tags fancyapp-worker-port \
      --google-machine-type n1-standard-1 \
      --google-disk-size 10 \
      --engine-label type=fancyapp-worker-instance-01 \
      --swarm fancyapp-worker-instance-01 && \
      docker-machine ssh fancyapp-worker-instance-01 'sudo gpasswd -a $(whoami) docker' && \
      docker-machine ssh fancyapp-worker-instance-01 'docker run swarm' && \
      docker-machine ssh fancyapp-worker-instance-01 'docker plugin install --grant-all-permissions vieux/sshfs DEBUG=1 sshkey.source=/home/$(whoami)/.ssh/' && \
      docker-machine ssh fancyapp-worker-instance-01 'FILE=~/.ssh/id_rsa.pub; if [[ ! -f "$FILE" ]]; then ssh-keygen -f ~/.ssh/id_rsa -q -N ""; fi; cat $FILE' >> ~/.ssh/authorized_keys && \
      docker-machine ssh fancyapp-worker-instance-01 "docker swarm join --token $SWARM_WORKER_TOKEN $MASTER_INSTANCE_PUBLIC_IP:2377"
      ```

    - Create AWS Worker Instance Example
      ```
      docker-machine create \
      --driver amazonec2 \
      --amazonec2-region ap-northeast-2 \
      --amazonec2-instance-type t3.small \
      --amazonec2-root-size 10 \
      --amazonec2-security-group fancyapp-worker-instance-01 \
      --engine-label type=fancyapp-worker-instance-01 \
      --swarm fancyapp-worker-instance-01 && \
      docker-machine ssh fancyapp-worker-instance-01 'sudo gpasswd -a $(whoami) docker' && \
      docker-machine ssh fancyapp-worker-instance-01 'docker plugin install --grant-all-permissions vieux/sshfs DEBUG=1 sshkey.source=/home/$(whoami)/.ssh/' && \
      docker-machine ssh fancyapp-worker-instance-01 'FILE=~/.ssh/id_rsa.pub; if [[ ! -f "$FILE" ]]; then ssh-keygen -f ~/.ssh/id_rsa -q -N ""; fi; cat $FILE' >> ~/.ssh/authorized_keys && \
      docker-machine ssh fancyapp-worker-instance-01 "docker swarm join --token $SWARM_WORKER_TOKEN $MASTER_INSTANCE_PUBLIC_IP:2377"
      ```

2. Update SSH Certificate you made
```
docker-machine regenerate-certs fancyapp-worker-instance-01
```

3. Deploy on the Machine you made
- docker-stack.yml
  ```docker-stack.yml
  version: '3.7'
  services:
    fancyapp-worker-instance-01:
      hostname: fancyapp-worker-instance-01
      build: "."
      working_dir: "/applications/service-worker"
      command: bash -c 'run your command'
      image: us.gcr.io/your-gcp-project/docker-image
      volumes:
      - worker-instance-volume:/applications/service-worker
      environment:
      - EC2_SECRET_ACCESS_KEY
      - EC2_ACCESS_KEY_ID
      privileged: true
      stdin_open: true
      tty: true
      depends_on: []
      deploy:
        placement:
          constraints:
          - engine.labels.type == fancyapp-worker-instance-01
  volumes:
    worker-instance-volume:
      driver: vieux/sshfs:latest
      driver_opts:
        sshcmd: "${USER}@${PUBLIC_IP}:/applications/service-worker"
        allow_other: ''
  ```
- deploy
  - With docker-stack.yml
    ```
    docker stack deploy --with-registry-auth -c docker-stack.yml engine
    ```
  - With Plain Text
    ```
    cat docker-stack.yml | docker stack deploy --with-registry-auth -c - engine
    ```

4. Remove Container
```
docker stack remove engine
```

5. Remove Instance
```
docker-machine rm fancyapp-worker-instance-01
```

# Modulize
- Make your own script