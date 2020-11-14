import 'package:http/http.dart' as http;

class ApiClient {

  Future requestGet(String url, Map headers) async{
    var response = await http.get(url, headers: headers);
    return response;
  }
}
