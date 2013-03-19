#!/bin/bash

timeout=`awk '{print $2}' weather.cfg`
echo 'Обновление :' $timeout 'секунд'

while [[ 1 ]]
do
    data=`wget -q -O .weather.tmp http://export.yandex.ru/weather-ng/forecasts/26850.xml`
    weather=`echo "$data" | head -n30 .weather.tmp | grep '\<weather_type\>' | awk -F"[><]" '{print $3}'`
    temperature=`echo "$data" | head -n30 .weather.tmp | grep temperature | awk -F"[><]" '{print $3}'`

    echo 'Минск:' $weather', температура '$temperature' C'
    sleep $timeout
done

