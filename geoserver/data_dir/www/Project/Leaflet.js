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
map.addLayer(wmsLayer);
