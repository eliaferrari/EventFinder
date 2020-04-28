

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

var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
//Bbox solo quadrata quindi dal cerchio devo calcolare area equivalente
//L=sqrt( r^2 * pi) --> L/2 in direzione x e y --> basso sinistra, alto a destra
//Funcion BBOX request
var radius = document.getElementById("umkreis");
var y1 = position.coords.longitude - (Math.sqrt(Number(radius)*Number(radius)*Math.PI)/2);
var y2 = position.coords.longitude + (Math.sqrt(Number(radius)*Number(radius)*Math.PI)/2);
var x1 = position.coords.latitude - (Math.sqrt(Number(radius)*Number(radius)*Math.PI)/2);
var x2 = position.coords.latitude + (Math.sqrt(Number(radius)*Number(radius)*Math.PI)/2);

var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeNames : 'eventfinder:events',
    srsName : 'EPSG:4326',
    Bbox : 'x1,y1,x2,y2',//lon,lat?
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson'
};


//http://localhost:8080/geoserver/wfs?service=wfs&version=2.0&request=GetFeature&typeNames=eventfinder:events&cql_filter=catname='concert'
//Funcion filter by event type
var eventtype = document.getElementById("eventtype");
var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeNames : 'eventfinder:events',
    cql_filter : 'catname=eventtype',
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson',
    srsName : 'EPSG:4326'
};

//http://localhost:8080/geoserver/wfs?service=wfs&version=2.0&request=GetFeature&typeNames=eventfinder:events&cql_filter=datum>'2020-08-30 00:00:00'
//Funcion filter by date (just future events)
var date = document.getElementById("date");// formato da verificare (yyyy-mm-dd hh-mm-ss)
var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeNames : 'eventfinder:events',// between (&cql_filter=datum BETWEEN '2020-08-01 00:00:00'AND'2020-08-15 00:00:00')
    cql_filter : 'datum>date',//
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson',
    srsName : 'EPSG:4326'
};

//Funcion for the server request
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

//Function Form
function submit() {
  document.getElementById("form1").submit();
}
function reset() {
  document.getElementById("form1").reset()
}
