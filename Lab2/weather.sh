#!/bin/bash

timeout=`awk '{print $2}' weather.cfg`
echo 'Обновление :' $timeout 'секунд'

while [[ 1 ]]
do
    wget -q -O .weather.tmp http://export.yandex.ru/weather-ng/forecasts/26850.xml
    weather=`head -n30 .weather.tmp | grep '\<weather_type\>' | awk -F"[><]" '{print $3}'`
    temperature=`head -n30 .weather.tmp | grep temperature | awk -F"[><]" '{print $3}'`
    rm .weather.tmp

    echo 'Минск:' $weather', температура '$temperature' C'
    sleep $timeout
done

