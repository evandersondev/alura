import 'dart:io';

import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final messaging = FirebaseMessaging.instance;

  final token = await messaging.getToken();
  setPushToken(token);

  runApp(App());
}

void setPushToken(String? token) async {
  final prefs = await SharedPreferences.getInstance();
  final prefsToken = prefs.getString('pushToken');
  final prefSent = prefs.getBool('tokenSent');

  if (prefsToken != token || (prefsToken == token && prefSent == false)) {
    final deviceInfo = DeviceInfoPlugin();
    String? brand;
    String? model;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
      brand = androidInfo.brand;
    } else {
      final iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
      brand = 'Apple';
    }

    final device = Device(brand: brand, model: model, token: token);
    sendDevice(device);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
    );
  }
}
