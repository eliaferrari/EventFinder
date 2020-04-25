

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

//Bbox solo quadrata quindi dal cerchio devo calcolare area equivalente
//L=sqrt( r^2 * pi) --> L/2 in direzione x e y --> basso sinistra, alto a destra
//Funcion BBOX request
var radius = document.getElementById("UNKREIS?????");
var y1 = position.coords.longitude - (Math.sqrt(radius*radius*Math.PI)/2);
var y2 = position.coords.longitude + (Math.sqrt(radius*radius*Math.PI)/2);
var x1 = position.coords.latitude - (Math.sqrt(radius*radius*Math.PI)/2);
var x2 = position.coords.latitude + (Math.sqrt(radius*radius*Math.PI)/2);

var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
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