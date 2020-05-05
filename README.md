# EventFinder
Website with all kind of events in Switzerland, the javascript integration allows filtering of results based on date, category and geoposition (from device or from postal code).


## Project Structure:
main.html:     Basic acess with home page.

form.js:       Contain the JavaScript code for the creating of the Leaflet map and the operations.

Geodatabase_PgAdmin:    Backup of the database with some 2020 events in Switzerland.

API request songkick.py:    Request events on songkick API and updating the database

API request eventful.py:    Request events on eventufl API and updating the database

## further developments
Integration data from other API (sonkcik have the exclusive for live music!).
Expansion to other states (currently only Switzerland is included).

## Resources
ERD Database: https://www.draw.io/#15nodZrNZ8yIbMXXAM2DCIMrhHMEb3SDj

## Istructions
1 - Clone the project /n
2 - Install PgAdmin or a database manager
3 - Follow the istruction on https://docs.geoserver.org for the installation and configuration of GeoServer (Java included)
4 - Set the system enviroment variables for GEOSERVER_DATA_DIR as folder data_dir and for GEOSERVER_HOME as folder GEOSERVER
5 - Start the Database with the database manager (PgAdmin or similar) and start the GeoServer as istruction on website
6 - Open the main page from http://localhost:8080/geoserver/www/Project/main.html
