var map = L.map('map').setView([46.9, 8.1], 8);

var original =
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
  maxZoom: 10,
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
    '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  id: 'mapbox.streets'
}).addTo(map);

function onEachFeature(feature, layer) {
// does this feature have a property named popupContent?
if (feature.properties && feature.properties.popupContent) {
  layer.bindPopup(feature.properties.popupContent);
}
};

//GeoJSON-Dateien
//var Autobahn =

//var Messtellen = 
;



//Funktion, welche den Style der Punkte definiert
var geojsonMarkerOptions = {
radius: 8,
fillColor: "#ff7800",
color: "#000",
weight: 1,
opacity: 1,
fillOpacity: 0.8
};


//Funktion damit der Layer definiert wird und angezeigt wird.

var layer_Autobahn = L.geoJSON(Autobahn, {
pointToLayer: function (feature, latlng) {
  return L.circleMarker(latlng, geojsonMarkerOptions);
},
onEachFeature: function (feature, layer) {
     layer.bindPopup('<b>ID: ' + feature.properties.fid +'</b>' + '</br> Veränderung der durchschnittlichen Anzahl Fahrzeuge pro Tag zwischen 2002 und 2017: 67,3'); //function OnEachFeature  und bindPopup machen, dass es ein Popup gibt mit den Features der GeoJSON - Datei
 },

});

var layer_Messtellen = L.geoJSON(Messtellen, {
pointToLayer: function (feature, latlng) {
  return L.circleMarker(latlng, geojsonMarkerOptions);
},
onEachFeature: function (feature, layer) {
     layer.bindPopup('<b>ID: ' + feature.properties.ID +'</b>' + '</br> Name der Station: ' + feature.properties.Messpunkt + '</br> Durchschnittliches Tagesverkehr: ' + '</br> 2002: ' + feature.properties.y2002+ '</br> 2003: ' + feature.properties.y2003+ '</br> 2004: ' + feature.properties.y2004+ '</br> 2005: ' + feature.properties.y2005+ '</br> 2006: ' + feature.properties.y2006+ '</br> 2007: ' + feature.properties.y2007+ '</br> 2008: ' + feature.properties.y2008+ '</br> 2009: ' + feature.properties.y2009+ '</br> 2010: ' + feature.properties.y2010+ '</br> 2011: ' + feature.properties.y2011+ '</br> 2012: ' + feature.properties.y2012+ '</br> 2013: ' + feature.properties.y2013+ '</br> 2014: ' + feature.properties.y2014+ '</br> 2015: ' + feature.properties.y2015 + '</br> 2016: ' + feature.properties.y2016+ '</br> 2017: ' + feature.properties.y2017); //function OnEachFeature  und bindPopup machen, dass es ein Popup gibt mit den Features der GeoJSON - Datei
 },

});


//Definiton der Popups und Markers


var popup1 = L.popup()
  .setLatLng([46.064759055719838,8.926279541066688])
  .setContent('<p>Im Gotthard läuft‘s rund</p>');

var popup2 = L.popup()
   .setLatLng([47.310915106041774,8.543878028523991])
   .setContent('<p>Gut vernetzt</p>');

var popup3 = L.popup()
  .setLatLng([46.499731033365917,6.213464297697112])
  .setContent('<p>Offene Grenzen</p>');



var LeafIcon = L.Icon.extend({
options: {
  //shadowUrl: 'file:///Users/eneagentilini/Dropbox%20(Personale)/Blockprojekt_I/Leaflet/IMG/Shadow.png',
  iconSize:     [38, 38],
  //shadowSize:   [40, 40],
  iconAnchor:   [19,19],
  //shadowAnchor: [20,0],
  popupAnchor:  [1,-15]
  }
});

L.icon = function (options) {
return new L.Icon(options);
  };

var greenIcon = new LeafIcon({iconUrl: 'file:///Users/eneagentilini/Dropbox%20(Personale)/Blockprojekt_I/Leaflet/IMG/Car_Green.png'}),
  redIcon = new LeafIcon({iconUrl: 'file:///Users/eneagentilini/Dropbox%20(Personale)/Blockprojekt_I/Leaflet/IMG/Car_Red.png'}),
  blaueIcon = new LeafIcon({iconUrl: 'file:///Users/eneagentilini/Dropbox%20(Personale)/Blockprojekt_I/Leaflet/IMG/Car_Blue.png'});


var marker1 = L.marker([45.964759055719838,8.926279541066688], {icon: redIcon}).bindPopup('<b>Fakt 1: Im Gotthard läuft‘s rund</b>' + '</br> Der Rückgang des Autobahnverkehrs ist auf den Neubau des Gotthard Basistunnels zurückzuführen, da nun die LKWs, welche zuvor auf der Autobahn unterwegs waren, nunmehr auf das Schienennetz verlagert wurden.').openPopup();
var marker2 = L.marker([47.210915106041774,8.543878028523991], {icon: greenIcon}).bindPopup('<b>Fakt 2: Gut vernetzt</b>'  + '</br> In Baar (ZG) wurde ein Rückgang der Auslastung von fast 25% verzeichnet! Der Dank gilt dem Neubau der Tangente Baar-Zug. Diese entlastet die Hauptstrassen der Dörfer indem sie den Verkehr direkt auf die Autobahn in die Richtungen Zürich und Luzern/Gotthard leitet.').openPopup();
var marker3 = L.marker([46.399731033365917,6.213464297697112],  {icon: blaueIcon}).bindPopup('<b>Fakt 3: Offene Grenzen</b>'  + '</br> Die höhere Auslastung auf der Autobahn kann auf die Zunahme der Grenzgänger aus Frankreich, Deutschland und Italien zurückgeführt werden. Die französischen Pendler nutzen die Autobahn A1 um z.B. nach Genf oder Lausanne zu kommen, die deutschen Pendler nutzen vermehrt die Autobahn A7 in Richtung Winterthur, weshalb hier bei Müllheim ein Anstieg um 99,7% verzeichnet wurde.').openPopup();



//Erstellung der Layers

var Autobahn =L.layerGroup([layer_Autobahn]);
var Messtellen =L.layerGroup([layer_Messtellen]);
var Fakten = L.layerGroup([original,marker1,marker2,marker3, popup1,popup2,popup3]).addTo(map);
var Orig = L.layerGroup([original]);


//Generierung der Karte

var baseMaps = {
"Fakten": Fakten,
"Original": Orig};

var overlayMaps = {
"Autobahn": Autobahn,
"Messtellen": Messtellen};

L.control.layers(baseMaps, overlayMaps).addTo(map);
