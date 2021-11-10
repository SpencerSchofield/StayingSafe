import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:staying_safe/copyrights_page.dart";

const String apiKey = "RZrPN8h5C4BWs2TaHhBm8akd925h2n0L";

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final canterburyCoords = LatLng(51.27597, 1.07561);
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: canterburyCoords, zoom: 13.0),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.27597, 1.07561),
                      builder: (BuildContext context) => const Icon(
                          Icons.location_on,
                          size: 60.0,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                child: Image.asset("images/tt_logo.png"))
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.copyright),
          onPressed: () async {
            http.Response response = await getCopyrightsJSONResponse();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CopyrightsPage(
                        copyrightsText: parseCopyrightsResponse(response))));
          },
        ),
      ),
    );
  }
}

Future<http.Response> getCopyrightsJSONResponse() async {
  Uri url = "https://api.tomtom.com/map/1/copyrights.json?key=$apiKey" as Uri;
  var response = await http.get(url);
  return response;
}

String parseCopyrightsResponse(http.Response response) {
  if (response.statusCode == 200) {
    StringBuffer stringBuffer = StringBuffer();
    var jsonResponse = convert.jsonDecode(response.body);
    parseGeneralCopyrights(jsonResponse, stringBuffer);
    parseRegionsCopyrights(jsonResponse, stringBuffer);
    return stringBuffer.toString();
  }
  return "Can't get copyrights";
}

void parseRegionsCopyrights(jsonResponse, StringBuffer sb) {
  List<dynamic> copyrightsRegions = jsonResponse["regions"];
  copyrightsRegions.forEach((element) {
    sb.writeln(element["country"]["label"]);
    List<dynamic> cpy = element["copyrights"];
    cpy.forEach((e) {
      sb.writeln(e);
    });
    sb.writeln("");
  });
}

void parseGeneralCopyrights(jsonResponse, StringBuffer sb) {
  List<dynamic> generalCopyrights = jsonResponse["generalCopyrights"];
  generalCopyrights.forEach((element) {
    sb.writeln(element);
    sb.writeln("");
  });
  sb.writeln("");
}
