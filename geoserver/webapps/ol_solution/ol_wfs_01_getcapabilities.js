//Initialisierung XML POST String
var postString = null;
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
var postString = "http://localhost:8080/geoserver/wfs?service=wfs&version=1.1.0&request=GetCapabilities";
request.send(postString);

//Funktion welche ausgeführt wird, wenn Server antwortet
request.onload = function () {
	// HTTP response status, e.g., 200 for "200 OK"
	var status = request.status;
	//Returned data, e.g., an HTML document.
	var data = request.responseText;

	//Ausgabe der Rückgabewerte in die Konsole
	console.log(status);
	console.log(data);
};