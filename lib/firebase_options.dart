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
    apiKey: 'AIzaSyAo91lulnAKIjlNd7IzrB33TWKEClY3w1E',
    appId: '1:130620278383:web:6555ef31223ca8ce822f9a',
    messagingSenderId: '130620278383',
    projectId: 'coba-77507',
    authDomain: 'coba-77507.firebaseapp.com',
    storageBucket: 'coba-77507.appspot.com',
    measurementId: 'G-RFR3RKNTVE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApXsa3Srohx24QFeGA2Q8ojmJ8lpo4VX0',
    appId: '1:130620278383:android:15b33be6e2980d1c822f9a',
    messagingSenderId: '130620278383',
    projectId: 'coba-77507',
    storageBucket: 'coba-77507.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBejF4qyM0wedaV0H8wpR1iusRZYQ1BNPw',
    appId: '1:130620278383:ios:e0a1034f7d38ae17822f9a',
    messagingSenderId: '130620278383',
    projectId: 'coba-77507',
    storageBucket: 'coba-77507.appspot.com',
    iosClientId: '130620278383-sae4a0bsc9amatftilin7ofdm824cl4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.eSurat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBejF4qyM0wedaV0H8wpR1iusRZYQ1BNPw',
    appId: '1:130620278383:ios:e0a1034f7d38ae17822f9a',
    messagingSenderId: '130620278383',
    projectId: 'coba-77507',
    storageBucket: 'coba-77507.appspot.com',
    iosClientId: '130620278383-sae4a0bsc9amatftilin7ofdm824cl4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.eSurat',
  );
}
