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
    apiKey: 'AIzaSyA5Y0HdRr_TT5bAT9_Oo5yJAxGXERkiRvk',
    appId: '1:945477544618:web:1c8489f66cd0799bd97ed3',
    messagingSenderId: '945477544618',
    projectId: 'mychatapp-d24d9',
    authDomain: 'mychatapp-d24d9.firebaseapp.com',
    databaseURL: 'https://mychatapp-d24d9-default-rtdb.firebaseio.com',
    storageBucket: 'mychatapp-d24d9.appspot.com',
    measurementId: 'G-76144XZHSQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAznk369a9V65j9T3y5UKVTe1k5a7DwsNM',
    appId: '1:945477544618:android:1ef4279aa7df6e88d97ed3',
    messagingSenderId: '945477544618',
    projectId: 'mychatapp-d24d9',
    databaseURL: 'https://mychatapp-d24d9-default-rtdb.firebaseio.com',
    storageBucket: 'mychatapp-d24d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmDgpB9LhsmHoC5NnqpZyxP2sPeIDwwFk',
    appId: '1:945477544618:ios:3bc7c6e6cecde673d97ed3',
    messagingSenderId: '945477544618',
    projectId: 'mychatapp-d24d9',
    databaseURL: 'https://mychatapp-d24d9-default-rtdb.firebaseio.com',
    storageBucket: 'mychatapp-d24d9.appspot.com',
    iosBundleId: 'com.example.task',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmDgpB9LhsmHoC5NnqpZyxP2sPeIDwwFk',
    appId: '1:945477544618:ios:6c529e7cf661497fd97ed3',
    messagingSenderId: '945477544618',
    projectId: 'mychatapp-d24d9',
    databaseURL: 'https://mychatapp-d24d9-default-rtdb.firebaseio.com',
    storageBucket: 'mychatapp-d24d9.appspot.com',
    iosBundleId: 'com.example.task.RunnerTests',
  );
}
