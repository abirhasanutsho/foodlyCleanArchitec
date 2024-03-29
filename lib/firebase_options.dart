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
    apiKey: 'AIzaSyDzU7FHpcQGPYsWKseCOvnVayxiZO41cwQ',
    appId: '1:506247143228:web:b69714f4b49baadf378839',
    messagingSenderId: '506247143228',
    projectId: 'fir-nodejs-98ca4',
    authDomain: 'fir-nodejs-98ca4.firebaseapp.com',
    storageBucket: 'fir-nodejs-98ca4.appspot.com',
    measurementId: 'G-Y85B5TZHSQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPwCG86nWzInBRG4tab3LlRpYiCWugNQ8',
    appId: '1:506247143228:android:ace104e42272489e378839',
    messagingSenderId: '506247143228',
    projectId: 'fir-nodejs-98ca4',
    storageBucket: 'fir-nodejs-98ca4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACTj2-20UJP0Of0dgySBl5MIdIE6r3cPA',
    appId: '1:506247143228:ios:9fc2c98f412ef44e378839',
    messagingSenderId: '506247143228',
    projectId: 'fir-nodejs-98ca4',
    storageBucket: 'fir-nodejs-98ca4.appspot.com',
    iosBundleId: 'com.example.cleanarchitec',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACTj2-20UJP0Of0dgySBl5MIdIE6r3cPA',
    appId: '1:506247143228:ios:2fb3f8b116540183378839',
    messagingSenderId: '506247143228',
    projectId: 'fir-nodejs-98ca4',
    storageBucket: 'fir-nodejs-98ca4.appspot.com',
    iosBundleId: 'com.example.cleanarchitec.RunnerTests',
  );
}
