// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhBwhwi8Fk0B-YVG5yEKaO07M5y555ACk',
    appId: '1:737814846116:web:2fda3e26963745de222431',
    messagingSenderId: '737814846116',
    projectId: 'oncard-34afb',
    authDomain: 'oncard-34afb.firebaseapp.com',
    storageBucket: 'oncard-34afb.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2tASYFuK1miVt_53Qcq989WloyQphDhQ',
    appId: '1:737814846116:android:7a14e4c43be597b4222431',
    messagingSenderId: '737814846116',
    projectId: 'oncard-34afb',
    storageBucket: 'oncard-34afb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXwWqIBUHfsxLkIXxFeGl9AmU4RhDkRJk',
    appId: '1:737814846116:ios:8cafc8dfdcf7e070222431',
    messagingSenderId: '737814846116',
    projectId: 'oncard-34afb',
    storageBucket: 'oncard-34afb.firebasestorage.app',
    iosBundleId: 'com.example.saku',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXwWqIBUHfsxLkIXxFeGl9AmU4RhDkRJk',
    appId: '1:737814846116:ios:8cafc8dfdcf7e070222431',
    messagingSenderId: '737814846116',
    projectId: 'oncard-34afb',
    storageBucket: 'oncard-34afb.firebasestorage.app',
    iosBundleId: 'com.example.saku',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDhBwhwi8Fk0B-YVG5yEKaO07M5y555ACk',
    appId: '1:737814846116:web:b8deefa6c5474c96222431',
    messagingSenderId: '737814846116',
    projectId: 'oncard-34afb',
    authDomain: 'oncard-34afb.firebaseapp.com',
    storageBucket: 'oncard-34afb.firebasestorage.app',
  );

}