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

var eventContainer = document.getElementById("event");

var parameters = L.Util.extend(defaultParameters);
var URL = owsrootUrl + L.Util.getParamString(parameters);

var ourRequest = new XMLHttpRequest();
ourRequest.open('GET', URL);

ourRequest.onload = function(){
  var ourData = JSON.parse(ourRequest.responseText);
  renderHTML(ourData);
};
ourRequest.send();


function renderHTML(data) {
  var HTMLstirng = "test"
  eventContainer.insertAdjacentHTML('beforeend', HTMLstirng)

}
