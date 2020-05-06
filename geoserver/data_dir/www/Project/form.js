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
var testloc = true;
var pos = 0;
var lat;
var lon;
var x = document.getElementById("myLocation");

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

//elaborate the content of the location form tab
var test = "Insert CAP";
document.getElementById("myLocation").value = test;

function showPosition(position) {
  pos = position;
  lat = position.coords.latitude
  lon = position.coords.longitude
  document.getElementById("myLocation").value = lat + ";" + lon;
  testloc = false;
}

function getCAP() {
  var z = document.getElementById("myLocation").value;
  var URL1 = 'http://api.geonames.org/findNearbyPostalCodesJSON?postalcode=' + z + '&country=CH&radius=10&maxRows=1&username=elia';
  var ajax1 = $.ajax({
    url: URL1,
    dataType: 'json',
    format_options: 'callback:getJson',
    success: function(response) {
      for (var property in response) {
        var PostalCodes = response[property];
        for (var prop in PostalCodes) {
          var zero = PostalCodes[prop];
          lat = zero['lat']
          lon = zero['lng']
          wait = false;
        }
      }
    }
  });

};

function geolocation() {

  var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
  //BBOX
  var radius = ((document.getElementById("umkreis").value) / 100);
  var y1 = lon - (Math.sqrt(radius * radius * Math.PI) / 2);
  var y2 = lon + (Math.sqrt(radius * radius * Math.PI) / 2);
  var x1 = lat - (Math.sqrt(radius * radius * Math.PI) / 2);
  var x2 = lat + (Math.sqrt(radius * radius * Math.PI) / 2);
  var comma = ','
  var stringa = x1.toString().concat(comma, y1.toString(), comma, x2.toString(), comma, y2.toString());
  //filter by event type
  var eventtype = document.getElementById("eventtype").value;
  //filter by date (future events)
  var eventdate = document.getElementById("eventdate").value.concat(" 00:00:01"); // formato da verificare, deve essere: (yyyy-mm-dd hh:mm:ss)

  var defaultParameters = {
    service: 'WFS',
    version: '2.0',
    request: 'GetFeature',
    typeNames: 'eventfinder:events',
    srsName: 'EPSG:4326',
    outputFormat: 'text/javascript',
    format_options: 'callback:getJson',
    cql_filter: "catname=" + "'" + eventtype + "'" + "AND datum>'" + eventdate + "' AND bbox(geom," + stringa + ")", // between (&cql_filter=datum BETWEEN '2020-08-01 00:00:00'AND'2020-08-15 00:00:00')
  };

  //Funcion for the server request
  var parameters = L.Util.extend(defaultParameters);
  var URL = owsrootUrl + L.Util.getParamString(parameters);
  console.log(URL)

  var table = document.getElementById("event");
  var rowCount = table.rows.length;
  var row = table.insertRow(rowCount);
  var tableHeaderRowCount = 1;
  for (var i = tableHeaderRowCount; i < rowCount; i++) {
    table.deleteRow(tableHeaderRowCount);
  }

  var deltaLat;
  var deltaLon;
  var ajax = $.ajax({
    url: URL,
    dataType: 'jsonp',
    jsonpCallback: 'getJson',
    success: function(response) {
      WFSLayer = L.geoJson(response, {
        style: function(feature) {
          return {
            icon: greenIcon,
          };

        },
        onEachFeature: function(feature, layer) {
          popupOptions = {
            maxWidth: 300
          };
          // Distance calculation
                  var lat1 = (feature.geometry["coordinates"][1]);
                  var lon1 = (feature.geometry["coordinates"][0]);
                  deltaLon=lon-lon1;
                  var radlat1 = Math.PI * lat/180;
                  var radlat2 = Math.PI * lat1/180;
                  var raddeltalon = Math.PI * deltaLon/180;
                  var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(raddeltalon);
                  dist = Math.acos(dist);
                  dist = dist * 180/Math.PI;
                  dist = Math.ceil(dist*111.189577);
                  //Date transformation
          var date = new Date(feature.properties.datum);

          layer.bindPopup(feature.properties.name + "<br> " +
            date.getDate() + "." + date.getMonth() + "." + date.getFullYear() + "<br><br> " +
            feature.properties.catname + " | " + feature.properties.subcatname + "<br> " +
            feature.properties.website + "<br><br> " +
            feature.properties.beschreibung, popupOptions);

          var rowCount = table.rows.length;
          var row = table.insertRow(rowCount);

          row.insertCell(0).innerHTML = date.getDate() + "." + date.getMonth() + "." + date.getFullYear();
          row.insertCell(1).innerHTML = feature.properties.name;
          row.insertCell(2).innerHTML = feature.properties.ort;
          row.insertCell(3).innerHTML = dist;
          row.insertCell(4).innerHTML = "km";
        }

      }).addTo(map);
      var zoom;
      if ((document.getElementById("umkreis").value) == 10) {
        zoom = 12;
      } else if ((document.getElementById("umkreis").value) == 20) {
        zoom = 11;
      } else if ((document.getElementById("umkreis").value) == 50) {
        zoom = 9.5;
      } else if ((document.getElementById("umkreis").value) == 100) {
        zoom = 8.5;
      } else {
        zoom = 10
      }


      map.flyTo([lat, lon], zoom);
      sortTable();
    }
  });
}
var wait = true;

function checkFlag() {
  if (wait == true) {
    window.setTimeout(checkFlag, 1); /* this checks the flag every 100 milliseconds*/
  } else {
    geolocation()
  }
};


//Function Form
function confirm() {

  var z = document.getElementById("myLocation").value;
  if (z == "" || z == "Insert CAP") {
    alert("Location must be filled out with your PLZ or click on get my location!");
  }
  else if (testloc == false) {
    map.eachLayer(function(layer) {
      map.removeLayer(WFSLayer);
    });

  geolocation()
  }
   else {
    getCAP();

    map.eachLayer(function(layer) {
      map.removeLayer(WFSLayer);
    });

    checkFlag();
  }
};

function clean() {
  document.getElementById("form1").reset();
};

//Function sort table
function sortTable() {
  var table, rows, switching, i, r, r1, shouldSwitch;
  table = document.getElementById("event");
  switching = true;

  while (switching) {
    switching = false;
    rows = table.rows;

    for (i = 2; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      r = rows[i].getElementsByTagName("td")[3].innerHTML;
      r1 = rows[i + 1].getElementsByTagName("td")[3].innerHTML;
      if (Number(r) > Number(r1)) {
        shouldSwitch = true;
        break;
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }
}
