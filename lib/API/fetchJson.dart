import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class FetchApi {

  getApi(url) async
  {
     Response res =  await http.get(Uri.parse(url));
     // //print("API Testing ${res.body}");
     // //print("+++++++++++++++++++++++API Testing ${url}");
     // //print("+++++++++++++++++++++++API Testing ${res.body}");
     // //print("+++++++++++++++++++++++API Testing ${res}");
     return res.body;
  }

}