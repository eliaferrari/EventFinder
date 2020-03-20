// Gli elementi base possono esssere inseriti in un file a parte ed importati con import
var postDataOL = null;
var request = new XMLHttpRequest();
var url = "http://localhost:8080/geoserver/wfs";
var method = "POST";
var async = true;

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

var extent = [2420000, 130000, 2900000, 1350000];
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
var optionsForm = document.getElementById('options-form');

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

Modify.modify.on('modifyend', function(e) {
	var features = e.features.getArray();
	var feature = null;
	for (var i=0;i<features.length;i++){
		feature = features[i];
		var p = feature.getGeometry();
		var attributeValue = feature.getProperties().name;
		var id = feature.getId();
		attributeValue = prompt("Please enter the name", attributeValue);
		feature.set('name',attributeValue,false);
		var new_feature = new ol.Feature({
			geom: p,
			name: attributeValue
		})
		new_feature.setId(id);
		new_feature.setGeometryName("geom");
		transactWFS('update', new_feature);
		request = new XMLHttpRequest();
		request.onload = function () {
			var status = request.status;
			var data = request.responseText;
			console.log("==Server Response==");
			console.log(status);
			console.log(data);
		};
		request.open(method, url, async);
		request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");
		request.send(postDataOL);
	}
});
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
Draw.Point.on('drawend',function(evt){
	var feature = evt.feature;
	var p = feature.getGeometry();
	var attributeValue = prompt("Please enter the name", "web test punkt");
	var new_feature = new ol.Feature({
		geom: p,
		name: attributeValue
	})
	transactWFS('insert', new_feature);
	request = new XMLHttpRequest();
	request.onload = function () {
		var status = request.status;
		var data = request.responseText;
		console.log("==Server Response==");
		console.log(status);
		console.log(data);
	};
	request.open(method, url, async);
	request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");
	request.send(postDataOL);
});


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
var snap = new ol.interaction.Snap({
source: vector.getSource()
});
map.addInteraction(snap);

var transactWFS = function (mode, f) {
	var formatWFS = new ol.format.WFS();
	var formatGML = new ol.format.GML({
		featureNS: 'http://geoserver.org/testuebung',
		featurePrefix: 'testuebung',
		featureType: 'punkte'//,
	});
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
