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

// Set vectorTileOptions
var vectorTileOptions = {
vectorTileLayerStyles: {
'events': function() {
return {
  color: 'red',
  opacity: 1,
  fillColor: 'yellow',
  fill: true,
}
},
},
interactive: true,	// Make sure that this VectorGrid fires mouse/pointer events
}

// Set the coordinate system
var projection_epsg_no = '2056';
// Set the variable for storing the workspace:layername
var campground_geoserverlayer = 'eventfinder:events';
// Creating the full vectorTile url
var campingURL = '/geoserver/gwc/service/tms/1.0.0/' + campground_geoserverlayer + '@EPSG%3A' + projection_epsg_no + '@pbf/{z}/{x}/{-y}.pbf';
// Creating the Leaflet vectorGrid object
var camping_vectorgrid = L.vectorGrid.protobuf(campingURL, vectorTileOptions)

// Define the action taken once a polygon is clicked. In this case we will create a popup with the camping name
camping_vectorgrid.on('click', function(e) {
    L.popup()
      .setContent(e.layer.properties.naamnl)
      .setLatLng(e.latlng)
      .openOn(map);
  })
  .addTo(map);

// Add the vectorGrid to the map
camping_vectorgrid.addTo(map);

