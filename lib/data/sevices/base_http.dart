import 'dart:convert';
import 'package:http/http.dart' as http;
class UserClient extends http.BaseClient {
  final http.Client _inner;

  UserClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _inner.send(request);
  }
}

class AppHttpClient {
  static const String BASE_URL = "https://jsonplaceholder.typicode.com/";

  UserClient get client => UserClient(http.Client());

  Future<http.Response> fetch(String api) {
    var uri = Uri.parse(BASE_URL + api);

    return client.get(uri, headers: {'content-type': 'application/json'});
  }
}