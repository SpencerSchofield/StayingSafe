import "package:http/http.dart" as http;
import "dart:convert" as convert;

const String apiKey = "RZrPN8h5C4BWs2TaHhBm8akd925h2n0L";

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
