from xml.dom.minidom import parse
import requests
import xml.dom.minidom
import codecs
import psycopg2
import xml.etree.ElementTree as ET

# Variables definition
category = 'konzert'  # update control category in database!! and control categories in API
pagenum = '1'
numpag = '100'
metro_area = '27451'
city = 'Basel'
lat_s = '7.6'
lon_s = '47.5667'
plz = 4001
API_songkick = 'https://api.songkick.com/api/3.0/metro_areas/' + metro_area + '/calendar.xml'

# API request
payload = {'apikey': 'algYKQsTPPPoEQaQ', 'per_page': numpag, 'page': pagenum}
r = requests.get(API_songkick, params=payload)
r.encoding = 'utf-8'
xmldata = r.text

# connect to the database
connection = psycopg2.connect("dbname=eventfinder user=postgres password=postgres host=localhost port=5432")
cursor = connection.cursor()

# XML elaboration with DOM API
DOMTree = xml.dom.minidom.parseString(xmldata)
collection = DOMTree.documentElement
if collection.hasAttribute("event"):
    print('Root element:' + collection.getAttribute("event"))

# Get all the events in the collection
events = collection.getElementsByTagName("event")

# Extract and write the data
file = codecs.open('/XML_extractor/events.csv', 'w', 'utf-8')
for event in events:
    time = event.childNodes[1].getAttribute('time')  # OK
    date = event.childNodes[1].getAttribute('date')  # OK
    datum = date + ' ' + time  # OK
    title = event.getAttribute('displayName')  # OK
    venue = event.childNodes[5].getAttribute('displayName')  # OK
    ort = city + ' ' + venue  # OK
    weblink = event.getAttribute('uri')  # OK
    if event.getElementsByTagName('venue')[0].getAttribute('lat') != '':
        lat = event.getElementsByTagName('venue')[0].getAttribute('lat')
        lon = event.getElementsByTagName('venue')[0].getAttribute('lng')
    else:
        lat = event.getElementsByTagName('location')[0].getAttribute('lat')
        lon = event.getElementsByTagName('location')[0].getAttribute('lng')
    if lat != '':
        geom = 'POINT(' + lon + ' ' + lat + ')'  # OK
    else:
        geom = 'POINT(' + lon_s + ' ' + lat_s + ')'
    sql = "INSERT INTO public.events (name,ort,plz,datum,website,teilnehmer,catname,geom) VALUES(%s,%s,%s,%s,%s,%s,%s,ST_GeomFromText((%s),4326));"
    param = [title, ort, plz, datum, weblink, 1, category, geom]
    cursor.execute(sql, param)
    connection.commit()
    file.write(title + ',' + ort + ',' + str(plz) + ',' + datum + ',' + weblink + ',1,' + category + ',' + geom + '\n')
file.close()
