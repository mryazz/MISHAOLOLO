# Описание к тестовому заданию 

## Установка docker

Для начала нужно удалить старые версии если такие имеются 
```
   sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
 ```                                                           
 Установить docker с помощью репозитория
```         
    sudo yum install -y yum-utils
    sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/rhel/docker-ce.repo
```       
Установить Docker Engine
 ```  
  sudo yum install docker-ce docker-ce-cli containerd.io 
 ```
Допуск к Docker без root
1. Создать Docker группу

```
sudo groupadd docker
```
2. Добавить своего пользователя в docker группу
```
sudo usermod -aG docker $USER
```
3. Выйдите из системы и войдите снова
4. Убедитесь, что можем запускать docker команды без sudo.
```
 docker run hello-world
```
## Настройте Docker для запуска при загрузке
```
 sudo systemctl enable docker.service
 sudo systemctl enable containerd.service
 ```
 ## Запуск локального image registry в docker контейнере
 Запуск реестра
 ```
 docker run -d -p 5000:5000 --name registry registry:2
 ```
 Качаем образы из dockerhub
 ```
 docker pull selenoid/hub:1.10.4
 docker pull aerokube/selenoid-ui:1.10.3
 docker pull selenoid/chrome:90.0
 docker pull selenoid/video-recorder:7.1
 ```
 Пометить immage чтобы docker указывал на локальный registry
```
docker image tag selenoid/hub:1.10.4 localhost:5000/selenoid/hub:1.10.4
docker image tag aerokube/selenoid-ui:1.10.3 localhost:5000/aerokube/selenoid-ui:1.10.3
docker image tag selenoid/chrome:90.0 localhost:5000/selenoid/chrome:90.0
docker image tag selenoid/video-recorder:7.1 localhost:5000/selenoid/video-recorder:7.1
```
Сохраняем image на локальном registry
```
docker push localhost:5000/selenoid/hub:1.10.4
docker push localhost:5000/aerokube/selenoid-ui:1.10.3
docker push localhost:5000/selenoid/chrome:90.0
docker push localhost:5000/selenoid/video-recorder:7.1
```
## Настройка Selenoid
Подготовьте конфигуриционный файл browsers.json
```json
{
    "chrome": {
        "default": "90.0",
        "versions": {
            "90.0": {
                "image": "localhost:5000/selenoid/chrome:90.0",
                "port": "4444",
                "path": "/",
                "cpu" : "0.5",  
                "env" : ["TZ=Europe/Moscow"],              
                "mem" : "512m"
            }
        }
    }
}
```
Запуск Selenoid для тестов
```
docker run -d                                   \
--name selenoid                                 \
-p 4444:4444                                    \
-v /var/run/docker.sock:/var/run/docker.sock    \
-v /tmp/selenoid/:/opt/selenoid/logs/              \
-v /home/qwe/sberbank/:/etc/selenoid/:ro    \
-e OVERRIDE_VIDEO_OUTPUT_DIR=/tmp/selenoid/ \
localhost:5000/selenoid/hub:1.10.4  \
-log-output-dir /opt/selenoid/logs/ \
-video-recorder-image localhost:5000/selenoid/video-recorder:7.1 \
-limit 2
```
```
docker run -d        \
--name selenoid-ui \
-p 8080:8080         \
--link selenoid     \
localhost:5000/aerokube/selenoid-ui:1.10.3 \
--selenoid-uri http://selenoid:4444 
