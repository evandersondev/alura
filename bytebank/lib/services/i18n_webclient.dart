import 'dart:convert';

import 'http_service.dart';

// ignore: constant_identifier_names
const MESSAGES_URI =
    'https://gist.githubusercontent.com/evandersondev/9aa65218e92b16f34a5ce69163390fff/raw/a4bf3f54c726e3c1f18f0295daee926e8d7001e6/';

class I18NWebClient {
  Future<Map<String, dynamic>> findAll(String viewKey) async {
    final client = HttpService().instance;
    final response = await client.get(Uri.parse('$MESSAGES_URI$viewKey.json'));
    return jsonDecode(response.body);
  }
}
