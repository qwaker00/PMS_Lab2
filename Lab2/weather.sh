#!/bin/bash

timeout=`awk '{print $2}' weather.cfg`
echo 'Update timeout:' $timeout 'second(s)'

echo 'Will get info from http://export.yandex.ru/'

while [[ 1 ]]
do
    weather=`wget -q -O - http://export.yandex.ru/weather-ng/forecasts/26850.xml | head -n20 | grep temperature | awk -F"[><]" '{print $3}'`
    echo 'Weather in Minsk:' $weather
    sleep $timeout
done

