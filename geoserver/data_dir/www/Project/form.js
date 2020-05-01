var map = L.map('map').setView([46.9, 8.1], 8);

var original =
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
  maxZoom: 15,
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
    '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  id: 'mapbox.streets'
}).addTo(map);

var WFSLayer = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
  maxZoom: 15,
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
    '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  id: 'mapbox.streets'
}).addTo(map);

var greenIcon = new L.Icon({
  iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41]
});



//Geolocation
var pos = 0
var x = document.getElementById("myLocation");

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

//elaborate the content of the location form tab
var test = "Insert CAP or city";
document.getElementById("myLocation").value = test;

function showPosition(position) {
  pos = position;
  document.getElementById("myLocation").value = position.coords.latitude + ";"+ position.coords.longitude;


}
function geolocation(){

var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
//BBOX
var radius = ((document.getElementById("umkreis").value)/100);
var y1 = pos.coords.longitude - (Math.sqrt(radius*radius*Math.PI)/2);
var y2 = pos.coords.longitude + (Math.sqrt(radius*radius*Math.PI)/2);
var x1 = pos.coords.latitude - (Math.sqrt(radius*radius*Math.PI)/2);
var x2 = pos.coords.latitude + (Math.sqrt(radius*radius*Math.PI)/2);
var comma = ','
var stringa = y1.toString().concat(comma,x1.toString(),comma,y2.toString(),comma,x2.toString());
//filter by event type
var eventtype = document.getElementById("eventtype").value;
//filter by date (future events)
var eventdate = document.getElementById("eventdate").value.concat(" 00:00:01");// formato da verificare, deve essere: (yyyy-mm-dd hh:mm:ss)

var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeNames : 'eventfinder:events',
    srsName : 'EPSG:4326',
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson',
    cql_filter : "catname="+"'"+eventtype+"'"+"AND datum>'"+eventdate+"'",// between (&cql_filter=datum BETWEEN '2020-08-01 00:00:00'AND'2020-08-15 00:00:00')
};

//http://localhost:8080/geoserver/eventfinder/ows?service=WFS&version=2.0&request=GetFeature&typeName=eventfinder:events&outputFormat=text/javascript&cql_filter=catname=%27sport%27
//http://localhost:8080/geoserver/eventfinder/ows?service=WFS&version=2.0&request=GetFeature&typeName=eventfinder:events&outputFormat=text/javascript&srsName=EPSG:4326&cql_filter=catname=%27sport%27
//http://localhost:8080/geoserver/wfs?service=wfs&version=2.0&request=GetFeature&typeNames=eventfinder:events&cql_filter=datum>'2020-08-30 00:00:00'
//http://api.geonames.org/findNearbyPostalCodesJSON?postalcode=3014&country=CH&radius=10&maxRows=1&username=elia

//Funcion for the server request
var parameters = L.Util.extend(defaultParameters);
var URL = owsrootUrl + L.Util.getParamString(parameters);
console.log(URL)
var ajax = $.ajax({
    url : URL,
    dataType : 'jsonp',
    jsonpCallback : 'getJson',
    success : function (response) {
        WFSLayer = L.geoJson(response, {
            style: function (feature) {
                return {
                  icon : greenIcon,
                };

            },
            onEachFeature: function (feature, layer) {
                popupOptions = {maxWidth: 300};
                layer.bindPopup(feature.properties.name + "<br> " +
                feature.properties.datum + "<br><br> " +
                feature.properties.catname + " | " +feature.properties.subcatname + "<br> " +
                feature.properties.website  + "<br><br> " +
                feature.properties.beschreibung,popupOptions);
            }

        }).addTo(map);
        var zoom;
        if ((document.getElementById("umkreis").value)==10) {zoom =12;}
        else if ((document.getElementById("umkreis").value)==20) {zoom =11;}
        else if ((document.getElementById("umkreis").value)==50) {zoom =9.5;}
        else if ((document.getElementById("umkreis").value)==100) {zoom =8.5;}
        else { zoom = 10}


      map.flyTo([pos.coords.latitude, pos.coords.longitude], zoom);
    }
});}

//Function Form
function confirm() {
  map.eachLayer(function (layer) {
      map.removeLayer(WFSLayer);
  });
  geolocation();
};
function clean() {
  document.getElementById("form1").reset();
};
