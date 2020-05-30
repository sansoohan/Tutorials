# Infra Controll Environmet on GCP
- Pin the Services you use

  <img width="292" src="./images/ab0c9090-6e2a-4d55-b306-ed8994874956.png">
- I recommend you to pin these Services

  <img width="291" src="./images/b743a286-c7b9-4552-a227-f419c8c53324.png">
- Add your SSH Pub key on your project(It allow you to access the instances)
  - Select your project

    <img width="479" src="./images/68b5b8fb-85e9-401b-a110-a14bd78e2719.png">
  - Go Compute Engine > Metadata

    <img width="255" src="./images/1f5183a9-4caa-44a3-a2ba-154b2340f7fd.png">
  - SSH keys -> Edit

    <img width="689" src="./images/d7c9cb3c-11da-46ea-9191-8b77b475e6cb.png">
   - Add you ssh-pub key from your computer and save it.
     - you can see your ssh-pub key
        ```
        cat ~/.ssh/id_rsa.pub
        ```
     - If there is no ssh-pub key, you need to make one
        ```
        ssh-keygen
        ```
# Make/Backup Instance
- Backup Stopped Instance
  - Go Compute Engine > Images

    <img width="255" src="./images/1f5183a9-4caa-44a3-a2ba-154b2340f7fd.png">
  - Create New Image

    <img width="828" src="./images/f95c75f5-395b-4b7e-9f4b-f2b26ac47b61.png">
    -  Insert These Data and create
       - Name : (Example : InstanceName202004161225)
       - Source : Disk
       - Source disk : (Select Stopped Instance)
- Backup Running Instance
  - Go Compute Engine > Snapshots

    <img width="255" src="./images/1f5183a9-4caa-44a3-a2ba-154b2340f7fd.png">
  - Create snapshot

    <img width="648" src="./images/b976f37d-820f-4cc1-8480-f45d7d181177.png">
    -  Insert These Data and create
       - Name : (Example : InstanceNameSnapshot202004161225)
       - Source disk : (Select Stopped Instance)
     - Create Instance with snapshot
     
       - Go Compute Engine > VM instance > Create

          <img width="255" src="./images/1f5183a9-4caa-44a3-a2ba-154b2340f7fd.png">
        -  Insert These Data and create
           - Name : (Example : InstanceName202004161225)
           - Region : (Same region with other instance)
           - Machine type
           - Boot disk : (Select Snapshop)
           - Disks : uncheck Delete boot disk when instance is deleted
   - Remove Instance you just made
   - Create Image with the disk remaining
     - Go Compute Engine -> Images
     - Create Image with instance name you removed


# Let's Encrypt and Nginx
- Install Nginx
  ```
  sudo apt-get update
  sudo apt-get install nginx
  ```
- Check SSL already made
  ```
  cd /etc/letsencrypt/live
  ```
- Make certbot SSL(Let's Encrypt)
  - Go https://certbot.eff.org/ and Select Remote OS and Nginx

    <img width="781" src="./images/58e73f11-904c-488e-93e4-a29d5fea4562.png">
  - Install Certbot
  - Make SSL
    - For Nginx
      ```
      sudo certbot --nginx
      ```
      - Make Nginx Config with SSL
        ```
        vi /etc/nginx/sites-available/xxx.example.com
        ```
        - [Nginx Config Example](#nginx-config)
      - Set Nginx Config
        ```
        ln -s /etc/nginx/sites-available/xxx.example.com /etc/nginx/sites-enabled/xxx.example.com
        ```
      - Check Nginx Config before update nginx config
        ```
        nginx -t
        ```
      - Restart Nginx and update nginx config
        ```
        sudo systemctl restart nginx
        ```
      - Check Nginx Status
        ```
        sudo systemctl status nginx
        ```

    - For Common use
      ```
      sudo certbot certonly --standalone
      ```
    - For Serveral Domain
        ```
        certbot certonly --manual -d *.example.com
        ```
- Remove SSL
  - Remove SSL
    ```
    sudo certbot revoke --cert-pat=/etc/letsencrypt/live/xxx.example.com/cert.pem
    ```
  - Unset Nginx Config(If it is related with nginx)
    ```
    rm /etc/nginx/sites-enabled/xxx.example.com
    ```

# Nginx Config
- For Single Instance
  - DataFlow
    - Nginx get 443 port -> unix:///home/deployer/app/myapp/shared/tmp/sockets/puma.sock
    - How to rails run for this
      ```
      rails s -b 
  - Config Example
    ```
    upstream app-server {
      server unix:///home/deployer/app/myapp/shared/tmp/sockets/puma.sock fail_timeout=0;
    }

    server {
      listen [::]:443 ssl ipv6only=on; # managed by Certbot
      listen 443 ssl; # managed by Certbot
      ssl_certificate /etc/letsencrypt/live/myapp.com/fullchain.pem; # managed by Certbot
      ssl_certificate_key /etc/letsencrypt/live/myapp.com/privkey.pem; # managed by Certbot      
      
      server_name myapp.com, stage.myapp.com;

      root /home/deployer/app/myapp/current/public;
      access_log /home/deployer/app/myapp/shared/log/nginx-access.log;
      error_log /home/deployer/app/myapp/shared/log/nginx-error.log;
      error_page 404 /404.html;
      location /404.html { root /home/deployer/app/myapp/current/public; }
      error_page 500 /500.html;
      location /500.html { root /home/deployer/app/myapp/current/public; }
      client_max_body_size 4G;
      keepalive_timeout 10;
      location ^~ /assets/ {
        gzip_static on;
        expires max;
        add_header Cache-Control public;
      }
      try_files $uri/index.html $uri @app-server;
      location @app-server {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_read_timeout 30;
        proxy_redirect off;
        proxy_pass http://app-server;
      }
    }
    ```



- For Load Balanced Instance
  - DataFlow
    - You don't need to make SSL for nginx
      - Load Balancer Frontend will catch 443 and pass to Instance 80
    - Nginx get 80 port -> unix:///home/deployer/app/myapp/shared/tmp/sockets/puma.sock
    - How to rails run for this
      ```
      rails s -b /home/deployer/app/myapp/shared/tmp/sockets/puma.sock
      ```
  - Example
    ```
    upstream app-server {
      server unix:///home/deployer/app/myapp/shared/tmp/sockets/puma.sock fail_timeout=0;
    }

    server {
      listen 80;
      
      server_name myapp.com, stage.myapp.com;

      root /home/deployer/app/myapp/current/public;
      access_log /home/deployer/app/myapp/shared/log/nginx-access.log;
      error_log /home/deployer/app/myapp/shared/log/nginx-error.log;
      error_page 404 /404.html;
      location /404.html { root /home/deployer/app/myapp/current/public; }
      error_page 500 /500.html;
      location /500.html { root /home/deployer/app/myapp/current/public; }
      client_max_body_size 4G;
      keepalive_timeout 10;
      location ^~ /assets/ {
        gzip_static on;
        expires max;
        add_header Cache-Control public;
      }
      try_files $uri/index.html $uri @app-server;
      location @app-server {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_read_timeout 30;
        proxy_redirect off;
        proxy_pass http://app-server;
      }
    }
    ```






# Make Group for Auto Load Balance
- [Backup Instance as image](#makebackup-instance)
- Make Instance Template
  - Go Compute Engine > Instance templates

    <img width="255" src="./images/1f5183a9-4caa-44a3-a2ba-154b2340f7fd.png">
  - Create New Instance Template

    <img width="810" src="./images/994c183d-28a8-4483-a0f4-f77632c0a400.png">

    -  Insert These Data and create
      - Name : (Example : InstanceNameTemplate202004161225)
      - Machine configuration
      - Boot disk : (Instance Image)
- Make Instance Group
  - Go Compute Engine > Instance groups
  - Create Instance Group

    <img width="874" src="./images/bd1ae3f1-610b-4a1d-90fc-e750f0816149.png">

    -  Insert These Data and create
      - Name : (Example : InstanceNameGroup202004161225)
      - Location
      - Region
      - Instance template 
      - Autoscaling mode

# Make Group for Manual Load Balance
- Prepare Instance to insert into Group
  - Go Compute Engine > VM instances
  - Create Instance

- Make Network endpoint group
  - Go Compute Engine > Network endpoint groups
  -  Insert These Data and create
    - Name : (Example : InstanceNameGroup202004161225)
    - Network endpoint group type
    - Default port(This should be same as your nginx port. I recommend you to set 80)

- Add Instance Into Group
  - Go Compute Engine > Network endpoint groups

    <img width="584" src="./images/ed9c7444-b4cf-4130-96c2-cd8988910175.png">

  - Add network endpoint
  - Select VM instance
  - Click [Check primary IP addresses & alias IP range in 'nic0']
  - Copy Instance IP

    <img width="443" src="./images/37525e64-09c9-4085-86d5-5a18a73ac722.png">
  - Click Add network endpoint and insert Instance IP
  - Set port and create(This should be same as your nginx port. I recommend you to set 80)

    <img width="539" src="./images/c770c9ca-b3da-4542-81cd-04cb12d5203a.png">

# Setup Load Balancer
- You can add Manual/Auto Load Balance Group Both
- You need to prepare Load Balance Group
- Flow
  - User Access 443 -> Load Balance Front 443
  - Load Balance Front end 443 -> Load Balance Back end 80
  - Load Balance Back end 80 -> Load Balance Instance Nginx 80
    - Load Balance Instance Nginx 80 -> Load Balance Instance Nginx Reverse proxy localhost:8080
    - Load Balance Instance Nginx 80 -> Load Balance Instance Nginx Reverse proxy puma.sock
- Go Network services > Load balancing > Create Load Balancer
  - In here  select HTTP(S) Load Balancing
    <img width="1034" src="./images/c3dfa715-d219-4acb-8d24-0d307a3c2f8a.png">
  - Select From Internet to my VMs
  - Click Backend configuration and add Load Balance Group you made
  - Click Frontend configuration and make SSL cert with 443 port
    - Name : (Example : InstanceNameFrontend202004161225)
    - Protocol : HTTPS
    - IP address : Create Static IP Address(Example : InstanceNameFrontendIP)
    - Port : 443
    - Certificate : create a new certificate with domain
    - SSL policy : TSL 1.2 modern

# Set Instance Static IP
- You can set Static IP for each Instance
- Go VPC network > External IP Address
  - Reserve a static address with these data
    - Name
    - Region
    - Attated to

# Setup DNS
- Go Network services > Cloud DNS

  <img width="638" src="./images/5644007f-882f-49b8-ac28-479a0e0cc75d.png">

  - Get some DNS from the sites(If you don't have one)
    - For example : https://www.freenom.com/en/index.html?lang=en
    - Create Zone
  - go one of zone > Add record set

     <img width="509" src="./images/943face9-2dd0-4127-b234-6caa63f918f9.png">
  - Insert DNS record : Static IP

    <img width="824" src="./images/4379b2a7-4c4b-4aa1-a399-6a3449fe19cf.png">
