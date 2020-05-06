import requests
from xml.dom.minidom import parse
import xml.dom.minidom
import codecs
import psycopg2

# Variables definition
category = 'concert'  # update categories in API
pagenum = '100'
API_eventful = 'http://api.eventful.com/rest/events/search'

# API request
payload = {'app_key': 'kxPnNrdf6DhPm93k', 'page_size': pagenum, 'location': 'Switzerland', 'date': 'Future',
           'category': category}
r = requests.get(API_eventful, params=payload)
r.encoding = 'utf-8'
xmldata = r.text
print(xmldata)

# connect to the database
connection = psycopg2.connect("dbname=eventfinder user=postgres password=postgres host=localhost port=5432")
cursor = connection.cursor()

# XML elaboration with DOM API
DOMTree = xml.dom.minidom.parseString(xmldata)
collection = DOMTree.documentElement
if collection.hasAttribute("shelf"):
    print('Root element:' + collection.getAttribute("shelf"))

# Get all the events in the collection
events = collection.getElementsByTagName("event")

# Extract and write the data
file = codecs.open('C:/Users/Martina/PycharmProjects/EventFinder/XML_extractor/events.csv', 'w', 'utf-8')
for event in events:
    title = event.getElementsByTagName('title')[0]
    title = title.childNodes[0].data
    city = event.getElementsByTagName('city_name')[0]
    venue = event.getElementsByTagName('venue_name')[0]
    ort = city.childNodes[0].data + ' ' + venue.childNodes[0].data
    datum = event.getElementsByTagName('start_time')[0]
    datum = datum.childNodes[0].data
    try:
        beschreibung = event.getElementsByTagName('description')[0]
        beschreibung = beschreibung.childNodes[0].data
    except IndexError:
        beschreibung = ' '
    weblink = event.getElementsByTagName('url')[0]
    weblink = weblink.childNodes[0].data
    lat = event.getElementsByTagName('latitude')[0]
    lon = event.getElementsByTagName('longitude')[0]
    geom = 'POINT(' + lon.childNodes[0].data + ' ' + lat.childNodes[0].data + ')'
    sql = "INSERT INTO public.events (name,ort,datum,beschreibung,website,teilnehmer,catname,geom) VALUES(%s,%s,%s,%s,%s,%s,%s,ST_GeomFromText((%s),4326));"
    param = [title, ort, datum, beschreibung, weblink, 1, category, geom]
    cursor.execute(sql, param)
    connection.commit()
    file.write(
        title + ',' + ort + ',0,' + ort + ',' + beschreibung + ',' + weblink + ',1,' + category + ',,' + geom + '\n')
file.close()
