var postDataOL;

var transactWFS = function (mode, f) {   		
var formatWFS = new ol.format.WFS();

	var formatGML = new ol.format.GML({
	featureNS: 'http://geoserver.org/testuebung',
	featurePrefix: 'testuebung',
	featureType: 'punkte'//,
	//srsName: 'EPSG:2056'
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
};

var url = "http://localhost:8080/geoserver/wfs";
var method = "POST";

//Generierung XML mit OL
var new_feature = new ol.Feature({
	geom: new ol.geom.Point([2654390,1176590]),
	name: 'TEST new Feature'
})
transactWFS('insert', new_feature);

console.log(postDataOL);
// asynchrone Abfragen erlauben, sonst werden alle Interaktion bis zur
// Serverantwort blockiert
var async = true;

var request = new XMLHttpRequest();
// definiert wie der Server mit der HTTP response verfahren soll 
// über die XMLHttpRequest "onload" Eigenschaft
request.onload = function () {
   // Because of javascript's fabulous closure concept, the XMLHttpRequest "request"
   // object declared above is available in this function even though this function
   // executes long after the request is sent and long after this function is
   // instantiated. This fact is CRUCIAL to the workings of XHR in ordinary
   // applications.

   // You can get all kinds of information about the HTTP response.
   var status = request.status; // HTTP response status, e.g., 200 for "200 OK"
   var data = request.responseText; // Returned data, e.g., an HTML document.
   //Ausgabe der Rückgabewerte als alert
   alert(status);
   alert(data);
   //Ausgabe der Rückgabewerte in die Konsole
	console.log(status);
	console.log(data);
}		
request.open(method, url, async);

request.setRequestHeader("Content-Type", "application/xml;charset=UTF-8");
// Or... request.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");	
// Actually sends the request to the server.
request.send(postDataOL);	