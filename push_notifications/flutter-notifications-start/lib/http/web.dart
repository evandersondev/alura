import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meetups/models/device.dart';
import 'package:meetups/models/event.dart';

const String baseUrl = 'http://192.168.100.41:8080/api';

Future<List<Event>> getAllEvents() async {
  final response = await http.get(Uri.parse('$baseUrl/events'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar os eventos');
  }
}

void sendDevice(Device device) async {
  final response = await http.post(
    Uri.parse('$baseUrl/devices'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({
      'token': device.token ?? '',
      'modelo': device.model ?? '',
      'marca': device.brand ?? '',
    }),
  );

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('pushToken', device.token!);
  prefs.setBool('tokenSent', false);

  if (response.statusCode != 200) {
    throw Exception('Falha criar um dispositivo');
  } else {
    prefs.setBool('tokenSent', true);
  }

  // return response;
}
