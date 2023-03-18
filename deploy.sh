# !/bin/bash

DEFAULT_CONF="/root/nginx/default.conf"
IS_BLUE_RUNNING=$(docker ps | grep blue)

if [ -n "$IS_BLUE_RUNNING" ]; then
    DEPLOY="green"
    RUNNING="blue"
else
    DEPLOY="blue"
    RUNNING="green"
fi

echo "########################### $RUNNING is running... ###########################"

echo "########################### Pull docker image to $DEPLOY... ###########################"
docker compose pull $DEPLOY

echo "########################### Deploy $DEPLOY... ###########################"
docker compose up -d $DEPLOY

while true
do
    echo " health checking $DEPLOY..."
    REQUEST=$(docker exec nginx curl http://$DEPLOY:8080)
    echo $REQUEST
    if [ -n "$REQUEST" ]; then
        break;
    fi
    sleep 3
done;


echo "########################### Nginx reload... ###########################"
sed -i "s/$RUNNING/$DEPLOY/g" $DEFAULT_CONF
docker exec -d nginx service nginx reload

echo "########################### Stop $RUNNING... ###########################"
docker compose stop $RUNNING

echo "########################### Deploy finished!! ###########################"