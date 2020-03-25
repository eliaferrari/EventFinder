// Variable für die Übermittlung der Daten im HTTP POST Request
var postDataOL = null;
//Parameters HTTP Request
var request = new XMLHttpRequest();
var url = "http://localhost:8080/geoserver/wfs";
var method = "POST";
// Async aktivieren async = true!
// Ansonsten werden alle Befehle blockiert bis zur Serverantwort.
var async = true;

// Definition der Datensaetze und Layer
// WFS Layer - Geoserver
// Quelle zum Vektor-Datensatz, welcher vom Geoserver abgerufen wird  
var vectorSource = new ol.source.Vector({
	format: new ol.format.GeoJSON(),
	url: function(extent) {
	  return 'http://localhost:8080/geoserver/wfs?service=WFS&' +
			  'version=1.1.0&request=GetFeature&typename=testuebung:punkte&' +
			  'outputFormat=application/json';
	},
	strategy: ol.loadingstrategy.bbox
});

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

//Definition des Kartenextents für WMS/WMTS
var extent = [2420000, 130000, 2900000, 1350000];
// WMS Layer 
// Laden des WMTS von geo.admin.ch > Hintergrundkarte in der Applikation	
var wmtsLayer = new ol.layer.Tile({
	extent: extent,
	source: new ol.source.TileWMS({
		url: 'https://wms.geo.admin.ch/',
		crossOrigin: 'anonymous',
		attributions: '© <a href="http://www.geo.admin.ch/internet/geoportal/' +
				  'en/home.html">Pixelmap 1:1000000 / geo.admin.ch</a>',
		projection: 'EPSG:2056',
		params: {
		  'LAYERS': 'ch.swisstopo.pixelkarte-farbe-pk1000.noscale',
		  'FORMAT': 'image/jpeg'
		},
		serverType: 'mapserver'
	})
});
// Initialisierung der Karte in der Applikation: Vektor-Layer + WMTS
var map = new ol.Map({
	layers: [wmtsLayer, vector], // layer
	target: document.getElementById('map'),
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
// Interaktion
// Steuerung der Optionenauswahl > Form am Anfang des body	
var optionsForm = document.getElementById('options-form');

// Modify
// Initialisierung der Variable Modify, um Features zu verschieben	
var Modify = {
  init: function() {
	  this.select = new ol.interaction.Select();
	  map.addInteraction(this.select);
	  this.modify = new ol.interaction.Modify({
		  features: this.select.getFeatures()
	  });
	  map.addInteraction(this.modify);
	  this.setEvents();
  },
  setEvents: function() {
	  var selectedFeatures = this.select.getFeatures();
	  this.select.on('change:active', function() {
		  selectedFeatures.forEach(selectedFeatures.remove, selectedFeatures);
	  });
  },
  setActive: function(active) {
	  this.select.setActive(active);
	  this.modify.setActive(active);
  }
};
Modify.init();

// Funktion On Modify end: definiert was nach Modify geschehen soll:
// Speichern der geänderten Daten und senden des HTTP POST Request (Änderung in DB = 'update'!)
Modify.modify.on('modifyend', function(e) {
	var features = e.features.getArray();
	var feature = null;
	for (var i=0;i<features.length;i++){
		feature = features[i];
		var p = feature.getGeometry();
		var attributeValue = feature.getProperties().name;
		var id = feature.getId();
		// Attribute erfassen
		attributeValue = prompt("Please enter the name", attributeValue);
		feature.set('name',attributeValue,false);
		// Generierung feature für das WFS update
		var new_feature = new ol.Feature({
			geom: p,
			name: attributeValue
		})
		new_feature.setId(id);
		// Wichtig: "geometry name" muss gesetzt werden ansonsten wird folgender Fehler ausgegeben:
		// error: no such property: geometry
		new_feature.setGeometryName("geom"); 
		// generiert XML code für WFS update von new_feature in der Variable 'postDataOL'
		transactWFS('update', new_feature);
		// senden der XMLHttpRequest an den Server
		request = new XMLHttpRequest();
		// Serverrueckmeldung des WFS Servers, für die Verifikation der Abfrage
		request.onload = function () {
			var status = request.status; // HTTP response status, e.g., 200 for "200 OK"
			var data = request.responseText; // Returned data, e.g., an HTML document.
			// Ausgabe der Antwort als log
			console.log("==Server Response==");
			console.log(status);
			console.log(data);	
		};		  
		request.open(method, url, async);
		request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");
		// Or... request.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
		request.send(postDataOL);
	}
});
// Draw
// Initialisierung der Variable Draw zum zeichnen von Features
var Draw = {
	init: function() {
		map.addInteraction(this.Point);
		this.Point.setActive(false);
	},
	Point: new ol.interaction.Draw({
		source: vector.getSource(),
		type: /** @type {ol.geom.GeometryType} */ ('Point')
	}),
	getActive: function() {
		return this.activeType ? this[this.activeType].getActive() : false;
	},
	setActive: function(active) {
		var type = optionsForm.elements['draw-type'].value;
		if (active) {
			this.activeType && this[this.activeType].setActive(false);
			this[type].setActive(true);
			this.activeType = type;
		} else {
			this.activeType && this[this.activeType].setActive(false);
			this.activeType = null;
		}
	}
};
Draw.init();
// Funktion On Draw end: definiert was nach Draw geschehen soll:
// Speichern der geänderten Daten und senden des HTTP POST Request (Änderung in DB = 'insert'!)
Draw.Point.on('drawend',function(evt){
	var feature = evt.feature;
	var p = feature.getGeometry();
	// Attribute erfassen
	var attributeValue = prompt("Please enter the name", "web test punkt");
	// Generierung feature für das WFS update
	var new_feature = new ol.Feature({
		geom: p,
		name: attributeValue
	})
	// generiert XML code für WFS insert von new_feature in der Variable 'postDataOL'
	transactWFS('insert', new_feature);		
	// Actually sends the request to the server.		
	request = new XMLHttpRequest();
	// Serverrueckmeldung des WFS Servers, für die Verifikation der Abfrage
	request.onload = function () {
		var status = request.status; // HTTP response status, e.g., 200 for "200 OK"
		var data = request.responseText; // Returned data, e.g., an HTML document.
		// Ausgabe der Antwort als log
		console.log("==Server Response==");
		console.log(status);
		console.log(data);	
	};
	request.open(method, url, async);
	request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");
	// Or... request.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
	request.send(postDataOL);
});
 
// Optionenauswahl-Listener, soll geändert oder gezeichnet werden
// Lässt den Nutzer den 'geometry type' ändern 
// @param {Event} e Change event.
optionsForm.onchange = function(e) {
	var type = e.target.getAttribute('name');
	var value = e.target.value;
	if (type == 'draw-type') {
		Draw.getActive() && Draw.setActive(true);
	} else if (type == 'interaction') {
		if (value == 'modify') {
			Draw.setActive(false);
			Modify.setActive(true);
		} else if (value == 'draw') {
			Draw.setActive(true);
			Modify.setActive(false);
		}
	}
};

Draw.setActive(true);
Modify.setActive(false);
// Die snap interaction muss nach den Modify und Draw interactions hinzugefügt werden
// Damit diese Event handler zuerst ausgelöst werden. Ihre Handler sind für
// das ausführen des Snapping verantwortlich.
var snap = new ol.interaction.Snap({
source: vector.getSource()
});
map.addInteraction(snap);

// Funktion für HTTP POST Request > Output: postDataOL als XML
// generiert XML code für WFS transaction von new_feature 
// und speichert diese in der Variable 'postDataOL'
var transactWFS = function (mode, f) {
	var formatWFS = new ol.format.WFS();
	var formatGML = new ol.format.GML({
		featureNS: 'http://geoserver.org/testuebung',	// Abgleichen mit Link des Geoserver-Datenspeichers
		featurePrefix: 'testuebung',					// Abgleichen mit Geoserver-Arbeitsbereich-Name
		featureType: 'punkte'//,						// Abgleichen mit Geoserver-Datenspeicher-Name
		//srsName: 'EPSG:2056'
	});
	//testuebung:punkte
	var xs = new XMLSerializer();
	var node;
	switch (mode) {
		case 'insert':
			node = formatWFS.writeTransaction([f], null, null, formatGML);
		break;
		case 'update':
			node = formatWFS.writeTransaction(null, [f], null, formatGML);
		break;
		case 'delete':
			node = formatWFS.writeTransaction(null, null, [f], formatGML);
		break;
		}
	postDataOL = xs.serializeToString(node);
	console.log("==Server Request for drawend==");
	console.log(postDataOL);
};