var style_simple = new ol.style.Style({
    fill: new ol.style.Fill({
      color: 'lightgreen'
    }),
    stroke: new ol.style.Stroke({
      color: '#880000',
      width: 1
    })
  });
 var style_highlighted = new ol.style.Style({
   fill: new ol.style.Fill({
	 color: 'yellow'
   }),
   stroke: new ol.style.Stroke({
	 color: '#880000',
	 width: 1
   })
 });
function simpleStyle(feature) {
   if (feature.get("REGION_UN") == "Africa") {
     return style_highlighted;
   }
   return style_simple;
 }

  var layer = 'opengeo:countries';
  var projection_epsg_no = '900913';
  var map = new ol.Map({
    target: 'map',
    view: new ol.View({
      center: [0, 0],
      zoom: 2
    }),
    layers: [new ol.layer.VectorTile({
      style:simpleStyle,
      source: new ol.source.VectorTile({
        tilePixelRatio: 1, // oversampling when > 1
        tileGrid: ol.tilegrid.createXYZ({maxZoom: 19}),
        format: new ol.format.MVT(),
        url: '/geoserver/gwc/service/tms/1.0.0/' + layer +
            '@EPSG%3A'+projection_epsg_no+'@pbf/{z}/{x}/{-y}.pbf'
      })
    })]
 });