var owsrootUrl = 'http://localhost:8080/geoserver/eventfinder/ows';
var defaultParameters = {
    service : 'WFS',
    version : '2.0',
    request : 'GetFeature',
    typeName : 'eventfinder:events',
    outputFormat : 'text/javascript',
    format_options : 'callback:getJson',
    SrsName : 'EPSG:4326'
};

var parameters = L.Util.extend(defaultParameters);
var URL = owsrootUrl + L.Util.getParamString(parameters);

var WFSLayer = null;
var ajax = $.ajax({
    url : URL,
    dataType : 'jsonp',
    jsonpCallback : 'getJson',
    success : function (response) {
        WFSLayer = L.geoJson(response, {
            style: function (feature) {
                return {
                    stroke: false,
                    fillColor: 'FFFFFF',
                    fillOpacity: 0
                };
            },
            onEachFeature: function (feature, layer) {
              $(document).ready(function()
              {

                  var data =JSON.parse(feature);
                  var ul = document.getElementById("event");
                  for( var i = 0; i < response.length; i++ )
                  {
                    var o = response[i];
                    var li = document.createElement("li");
                    li.appendChild(document.createTextNode(o.catname));
                    ul.appendChild(li);
            }
        })


}
})}})
