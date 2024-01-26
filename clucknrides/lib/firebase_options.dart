// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAAPFarzly5dYchmaoMOlzzR8HKOQWktmE',
    appId: '1:327751575329:web:ea2df0a21c7cfc48760060',
    messagingSenderId: '327751575329',
    projectId: 'cluck-n-rides',
    authDomain: 'cluck-n-rides.firebaseapp.com',
    storageBucket: 'cluck-n-rides.appspot.com',
    measurementId: 'G-D5J0QFPLCP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfCiwMWT-q6BAHmXw7ORycdMkiXz6hknA',
    appId: '1:327751575329:android:d893d397d58c2e96760060',
    messagingSenderId: '327751575329',
    projectId: 'cluck-n-rides',
    storageBucket: 'cluck-n-rides.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzOP5uOO1dpnnPfgaKjxRHY-7ZxYU6Usk',
    appId: '1:327751575329:ios:da8c06ca574bf190760060',
    messagingSenderId: '327751575329',
    projectId: 'cluck-n-rides',
    storageBucket: 'cluck-n-rides.appspot.com',
    iosBundleId: 'com.example.clucknrides',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzOP5uOO1dpnnPfgaKjxRHY-7ZxYU6Usk',
    appId: '1:327751575329:ios:4a4ad64ce6380cbb760060',
    messagingSenderId: '327751575329',
    projectId: 'cluck-n-rides',
    storageBucket: 'cluck-n-rides.appspot.com',
    iosBundleId: 'com.example.clucknrides.RunnerTests',
  );
}
