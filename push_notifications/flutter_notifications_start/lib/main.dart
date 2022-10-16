import 'dart:io';

import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCQE-mwERpzutmr4jHF2CZouJngnzQMO04',
      appId: '1:704499944798:web:699729978f31b763cd13cf',
      messagingSenderId: '704499944798',
      projectId: 'pushnotification-f3529',
    ),
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    _startPushNotificationsHandler(messaging);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    _startPushNotificationsHandler(messaging);
  } else {
    print('Permission don\'t authorized');
  }

  runApp(App());
}

Future<void> _startPushNotificationsHandler(FirebaseMessaging messaging) async {
  final token = await messaging.getToken(
    vapidKey:
        'BHaGyQojjkByhf5k41NMO89zr4xH3B-X8J-Gmb3-aOdznVGj6c0U8yeejOWla23gOW0k2bUndLo79HNwc4mvqN4',
  );
  setPushToken(token);

  // Foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print(message.notification!.title);
      print(message.notification!.body);
    }
  });

  // Background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Terminated
  final notificationFromTerminated =
      await FirebaseMessaging.instance.getInitialMessage();
  if (notificationFromTerminated?.data != null &&
      notificationFromTerminated!.data['message'].length > 0) {
    showMyDialog(notificationFromTerminated.data['message']);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received from background');
  print('Message: ${message.notification}');
}

void showMyDialog(String message) {
  Widget okButton = OutlinedButton(
    onPressed: () => Navigator.pop(navigatorKey.currentContext!),
    child: Text('OK'),
  );

  AlertDialog alert = AlertDialog(
    title: Text('Promotion meetups'),
    content: Text(message),
    actions: [okButton],
  );

  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return alert;
    },
  );
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
      navigatorKey: navigatorKey,
      home: EventsScreen(),
    );
  }
}
