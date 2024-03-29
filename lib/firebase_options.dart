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
    apiKey: 'AIzaSyCOrg0bL2azDWrAPbA_W24J8wBnGSWW9tQ',
    appId: '1:927114247467:web:d37f060e591ba98702596e',
    messagingSenderId: '927114247467',
    projectId: 'operation-red-1a03d',
    authDomain: 'operation-red-1a03d.firebaseapp.com',
    storageBucket: 'operation-red-1a03d.appspot.com',
    measurementId: 'G-DQJH3RQFQB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0bdYYa14ax78BCFUJcVtzYl3xJuW41V0',
    appId: '1:927114247467:android:6f8a00acde7761ca02596e',
    messagingSenderId: '927114247467',
    projectId: 'operation-red-1a03d',
    storageBucket: 'operation-red-1a03d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6h8_mYRqzRP5xap9vDszTaPXMoIRDNNQ',
    appId: '1:927114247467:ios:723cb7f076c9535702596e',
    messagingSenderId: '927114247467',
    projectId: 'operation-red-1a03d',
    storageBucket: 'operation-red-1a03d.appspot.com',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6h8_mYRqzRP5xap9vDszTaPXMoIRDNNQ',
    appId: '1:927114247467:ios:9b11c32cc217ae6702596e',
    messagingSenderId: '927114247467',
    projectId: 'operation-red-1a03d',
    storageBucket: 'operation-red-1a03d.appspot.com',
    iosBundleId: 'com.example.crud.RunnerTests',
  );
}
