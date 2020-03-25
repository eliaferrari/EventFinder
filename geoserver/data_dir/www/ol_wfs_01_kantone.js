// Instanziierung einer Vector Source mittels einer WFS GetFeature Abfrage
var vectorSource = new ol.source.Vector({
	format: new ol.format.GeoJSON(),
	url: function(extent) {
		// Pfad zur WFS Resource auf dem GeoServer
		return 'http://localhost:8080/geoserver/wfs?service=WFS&' +
			'version=1.1.0&request=GetFeature&typename=testuebung:punkte&' +
			'outputFormat=application/json';
	},
	strategy: ol.loadingstrategy.bbox
});

// Instanziierung eines Vector Layers mit einer Source und der Darstellung
var vector = new ol.layer.Vector({
	source: vectorSource,
	style: new ol.style.Style({
		image: new ol.style.Circle({
			radius: 4,
			fill: new ol.style.Fill({
				color: 'black'
			}),
			stroke: new ol.style.Stroke({
			  color: '#FFFFFF',
			  width: 1
			})
		})
	})
});
// Stile definieren
var style_simple = new ol.style.Style({
	fill: new ol.style.Fill({
	  color: 'rgba(233, 227, 255, 0.63)'
	}),
	stroke: new ol.style.Stroke({
	  color: '#666666',
	  width: 1
	})
});
var style_highlighted = new ol.style.Style({
	fill: new ol.style.Fill({
	 color: 'rgba(255, 250, 201, 0.63)'
	}),
	stroke: new ol.style.Stroke({
	 color: '#666666',
	 width: 1
	})
});

var simpleStyle = function(feature){ // z.B. AREA_HA (Spaltenname der Attribute)
	if (Number(feature.get('AREA_HA')) < 50000) {
		return style_highlighted;
	}
	return style_simple;			
};

// Instanziierung einer Vector Source mittels einer WFS GetFeature Abfrage
var vectorSourceKantone = new ol.source.Vector({
	format: new ol.format.GeoJSON(),
	url: function(extent) {
		// Pfad zur WFS Resource auf dem GeoServer
		return 'http://localhost:8080/geoserver/wfs?service=WFS&' +
			'version=1.1.0&request=GetFeature&typename=testuebung:kantone&' +
			'outputFormat=application/json';
	},
	strategy: ol.loadingstrategy.bbox
});

// Instanziierung eines Vector Layers mit einer Source und der Darstellung
var vectorKantone = new ol.layer.Vector({
	source: vectorSourceKantone,
	style: simpleStyle,
});

// Initialisierung der Karte in der Applikation
// Es können im Attributlayers auch mehrere Ebenen hinzugefügt werden
var map = new ol.Map({
	// Auflistung der erstellten Layer
	layers: [vectorKantone,vector],
	// In welches HTML-Element (bspw. Div-Tag) wird die Karte gezeichnet
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