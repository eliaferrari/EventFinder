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
var wmsLayer= L.tileLayer.wms("http://localhost:8080/geoserver/gwc/service/wms", {
    layers: 'eventfinder:events',
    format: 'image/png',
    transparent: true
});
//map.addLayer(wmsLayer);

        var camping = new L.tileLayer.wms("http://vps143339.ovh.net:8080/geoserver/camping/wms", {
            layers: 'eventfinder:events',
            format: 'image/png',
            srs: "EPSG:3857",
            transparent: true,
            pointerCursor: true
        }).addTo(map);
        map.addEventListener('click', Identify);

        function Identify(e) {
            var BBOX = map.getBounds().toBBoxString();
            var WIDTH = map.getSize().x;
            var HEIGHT = map.getSize().y;
            var X = map.layerPointToContainerPoint(e.layerPoint).x;
            var Y = map.layerPointToContainerPoint(e.layerPoint).y;
            var URL = wms_server + '&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&LAYERS=camping:camping&QUERY_LAYERS=camping:camping&BBOX=' + BBOX + '&FEATURE_COUNT=1&HEIGHT=' + HEIGHT + '&WIDTH=' + WIDTH + '&INFO_FORMAT=text%2Fhtml&SRS=EPSG%3A3857&X=' + X + '&Y=' + Y;
            $.ajax({
                url: URL,
                datatype: "html",
                type: "GET",
                success: function(data) {
                    var popup = new L.popup({
                        maxWith: 300
                    });
                    popup.setContent(data);
                    popup.setLatLng(e.latlng);
                    map.openPopup(popup);
                }
            });
        }

//GEOSERVER WITH GEOJSO
