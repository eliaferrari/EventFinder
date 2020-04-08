var map = L.map('map').setView([46.9, 8.1], 8);

var original =
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
  maxZoom: 10,
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
    '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  id: 'mapbox.streets'
}).addTo(map);

//Geolocation
var x = document.getElementById("location");

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
  document.getElementById("myLocation").value = position.coords.latitude + ";"+ position.coords.longitude;

}


//Function Form
function submit() {
  document.getElementById("form1").submit();
}
function reset() {
  document.getElementById("form1").reset()
}


//MAP GEOSERVER
var wmsLayer= L.tileLayer.wms("http://localhost:8080/geoserver/gwc/service/z", {
    layers: 'eventfinder:events',
    format: 'image/png',
    transparent: true
});
//map.addLayer(wmsLayer);

//var geojsonLayer = new L.GeoJSON.AJAX("http://localhost:8080/geoserver/eventfinder/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=eventfinder%3Aevents&maxFeatures=50&outputFormat=application%2Fjson");

var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeName : 'eventfinder:events',
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson',
    SrsName : 'EPSG:4326'
};

var parameters = L.Util.extend(defaultParameters);
var URL = owsrootUrl + L.Util.getParamString(parameters);

var WFSLayer = null;
var ajax = $.ajax({
    url : URL,
    dataType : 'jsonp',
    jsonpCallback : 'getJson',
    success : function (response) {
        WFSLayer = L.geoJson(response, {
            style: function (feature) {
                return {
                    stroke: false,
                    fillColor: 'FFFFFF',
                    fillOpacity: 0
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
    }
});
