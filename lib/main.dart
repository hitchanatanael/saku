import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:saku/routes/app_routes.dart';

//popup allow notification
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

//package firebase;
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Add stream controller
import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
final messageStreamController = BehaviorSubject<RemoteMessage>();

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (kDebugMode) {
        print('Android notification permission status: $status');
      }
    }

    // Request permission
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

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }

    // Register with FCM
    String? token = await messaging.getToken();

    if (kDebugMode) {
      print('Registration Token=$token');
    }

    // Set up foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }

      messageStreamController.sink.add(message);
    });

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    runApp(const MyApp());
  } catch (e) {
    if (kDebugMode) {
      print('Error in main: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: AppRoutes.routes,
    );
  }
}
