//Instanziierung einer Vector Source mittels einer WFS GetFeature Abfrage
var vectorSource = new ol.source.Vector({
  format: new ol.format.GeoJSON(),
  url: function(extent) {
    return 'http://localhost:8080/geoserver/wfs?service=WFS&' +
      'version=1.1.0&request=GetFeature&typename=testuebung:punkte&' +
      'outputFormat=application/json';
  },

  strategy: ol.loadingstrategy.bbox
});
//Instanziierung eines Vector Layers mit einer Source und der Darstellung
var vector = new ol.layer.Vector({
  source: vectorSource,
  style: new ol.style.Style({
    image: new ol.style.Circle({
      radius: 4,
      fill: new ol.style.Fill({
        color: 'blue'
      })
    })
  })
});
//Instanziierung einer Karte mit dem erzeigten Layer
//Es können im Attribut layers auch mehrere Ebenen hinzugefügt werden

//Definition des Kartenextents für WMS/WMTS
var extent = [2420000, 130000, 2900000, 1350000];

var wmtsLayer = new ol.layer.Tile({
  extent: extent,
  source: new ol.source.TileWMS({
    url: 'https://wms.geo.admin.ch/',
    crossOrigin: 'anonymous',
    attributions: 'href = "http://www.geo.admin.ch/internet/geoportal/' +
    'en/home.html">Pixelmap 1:1000000 /geo.admin.ch </a>',
    projection: 'EPSG:2056',
    params: {
      'LAYERS': 'ch.swisstopo.pixelkarte-farbe-pk1000.noscale',
      'FORMAT': 'image/jpeg'
    },
    serverType: 'mapserver'
  })
});
// OpenLayers TileMap
var map = new ol.Map({
  target: 'map',

  layers: [
    wmtsLayer,
		vector,

  ],

  view: new ol.View({
  center: [2600000, 1200000],
  maxZoom: 10,
  zoom: 8,
  projection: new ol.proj.Projection({
    code: 'EPSG:2056',
    units: 'm'
  })
  })
  });



  //Parameter http Request
  var url = "http://localhost:8080/geoserver/wfs";
  var method = "POST";
  //Anfrage wird asynchron ausgeführt, d.h. Programmausführung wartet nicht
  //auf Antwort
  var async = true;
  //Instanziierung XMLHTTPRequest Objekt (Achtung dieses Objekt muss
  //bei jedem Request neu instanziiert werden)
  var request = new XMLHttpRequest();
  request.open(method, url, async);
  request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");

  //Senden des POST XML String
  request.send(vectorSource);
  //Funktion welche ausgeführt wird, wenn Server antwortet
  request.onload = function() {
    // HTTP response status, e.g., 200 for "200 OK"
    var status = request.status;
    //Returned data, e.g., an HTML document.
    var data = request.responseText;
    //Ausgabe der Rückgabewerte in die Konsole
    console.log(status);
    console.log(data);
  };

  //Instanziierung Geometrie
  var demoGeom = new ol.geom.Point();
  //Instanziierung Attributwert
  var attributeValue = "bsp. Attributwert";
  //Generierung Geometrieobjekt
  var new_feature = new ol.Feature({
    geom: demoGeom,
    name: attributeValue
  })
  //Setzen eines eindeutigen Identifikators (z.B. der PK in der DB)
  new_feature.setId();

  //Instanziierung eines Interaktionsobjekts für Selektion einer Geometrie
  var select = new ol.interaction.Select();
  //Instanziierung eines Modifikationsobjekts
  var modify = new ol.interaction.Modify({
    features: select.getFeatures()
  });
  //Funktion die ausgeführt wird, sobald Modifikation abgeschlossen ist
  modify.on('modifyend', function(e) {
    var features = e.features.getArray();
    var feature = null;
    //Iteration über modifizierte Objekte
    for (var i = 0; i < features.length; i++) {
      feature = features[i];
      //Extraktion der Geometrie, der Sachdaten sowie des Identifikators
      var demoGeom = feature.getGeometry();
      var attributeValue = feature.getProperties().name;
      var id = feature.getId();
    }
  });

  //Instanziierung eines Interaktionsobjekts eines gezeichneten Objektes

  var addPoint = new ol.interaction.Draw({
    source: vector.getSource(),
    type: /** @type {ol.geom.GeometryType} */ ('Point')
  });

  //Funktion die ausgeführt wird, sobald neues Objekt gezeichnet wurde
  addPoint.on('drawend', function(e) {
    //Extraktion der Geometrie und der Sachdaten
    var feature = e.feature;
    var demoGeom = feature.getGeometry();
  });
