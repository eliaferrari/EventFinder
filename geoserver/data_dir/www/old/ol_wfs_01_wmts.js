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
				color: 'blue'
			})
		})
	})
});

//Definition des Kartenextents für WMS/WMTS
var extent = [2420000, 130000, 2900000, 1350000];

//Laden des WMTS von geo.admin.ch > Hintergrdungkarte in der Applikation
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

// Initialisierung der Karte in der Applikation
// Es können im Attributlayers auch mehrere Ebenen hinzugefügt werden
var map = new ol.Map({
	// Auflistung der erstellten Layer
	layers: [wmtsLayer,vector],
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