import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkClient {
  var client = http.Client();
  NetworkClient();
  static dynamic request(
    String path,
  ) async {
    Map<String, String> originalHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var client = http.Client();

    var url =
        Uri.https("818a914f-ca28-4c63-bfaf-89a128b7c536.mock.pstmn.io/", path);
    Response response = http.Response("", 200);
    response = await client.get(url, headers: originalHeaders);

    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
