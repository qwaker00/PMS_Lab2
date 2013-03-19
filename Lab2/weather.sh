#!/bin/bash

timeout=`grep timeout weather.cfg | awk '{print $2}'`
city=`grep city weather.cfg | awk '{print $2}'`

citydata=`wget -q -O - http://weather.yandex.ru/static/cities.xml`
cityid=`echo "$citydata" | grep -i ">$city</city>" | awk -F"\"" '{print $2}'`

echo 'Обновление :' $timeout 'секунд'

while [[ 1 ]]
do
    data=`wget -q -O - http://export.yandex.ru/weather-ng/forecasts/$cityid.xml`
    weather=`echo "$data" | head -n30 | grep '\<weather_type\>' | awk -F"[><]" '{print $3}'`
    temperature=`echo "$data" | head -n30 | grep temperature | awk -F"[><]" '{print $3}'`

    echo "$city:" $weather', температура '$temperature' C'
    sleep $timeout
done

