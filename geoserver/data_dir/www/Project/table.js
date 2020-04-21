
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
    success : function (feature, layer) {
                      $('#event').append(
                              '<tr><td>' + feature.properties.datum
                                      + '</td><td>'
                                      + feature.properties.name
                                      + '</td><td>'
                                      + feature.properties.catname
                                      + '</td><td>')
            }
        });
