docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)




docker run -d                                   \
--name selenoid                                 \
-p 4444:4444                                    \
-v /var/run/docker.sock:/var/run/docker.sock    \
-v /home/qwe/sberbank/video/:/opt/selenoid/video/            \
-v /home/qwe/sberbank/logs/:/home/qwe/sberbank/logs/            \
-v /home/qwe/sberbank/:/etc/selenoid/:ro    \
-e OVERRIDE_VIDEO_OUTPUT_DIR=/home/qwe/sberbank/        \
localhost:5000/aerokube/selenoid:latest -limit 2 -log-output-dir /home/qwe/sberbank/logs/

drokube/selenoid-ui --selenoid-uri http://172.18.0.1:4444

docker run -d                                   \
--name selenoid                                 \
-p 4444:4444                                    \
-v /var/run/docker.sock:/var/run/docker.sock    \
-v /tmp/:/opt/selenoid/video/            \
-v /tmp/:/opt/selenoid/logs/              \
-v /home/qwe/sberbank/:/etc/selenoid/:ro    \
-e OVERRIDE_VIDEO_OUTPUT_DIR=/tmp \
localhost:5000/aerokube/selenoid:latest -log-output-dir /opt/selenoid/logs/ -limit 2

