#!/bin/bash

if [[ x$1 = x"--help" ]]
then
    echo "usage: ./weather.sh"
    echo "config: weather.cfg"
    echo "config fields:"
    echo $'\t'"timeout - timeout to wait before next weather update"
    echo $'\t'"city - city"
    exit
fi

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

