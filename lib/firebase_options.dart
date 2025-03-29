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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBcMvbFZJ60z2qXBuWTWBOB4UYxeAmfgZE',
    appId: '1:922055344761:web:7deeb64704f54e5f548aa8',
    messagingSenderId: '922055344761',
    projectId: 'server-driven-ui-65ef2',
    authDomain: 'server-driven-ui-65ef2.firebaseapp.com',
    storageBucket: 'server-driven-ui-65ef2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9W00jcV3p6Q4aRRztgeUHOotLk6nIdeI',
    appId: '1:922055344761:android:7bfc19bd95b1d40a548aa8',
    messagingSenderId: '922055344761',
    projectId: 'server-driven-ui-65ef2',
    storageBucket: 'server-driven-ui-65ef2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyFQBN1W4mU6IZyK0yszFCBppdKV1N5Ho',
    appId: '1:922055344761:ios:75fd7b41e027ccd1548aa8',
    messagingSenderId: '922055344761',
    projectId: 'server-driven-ui-65ef2',
    storageBucket: 'server-driven-ui-65ef2.firebasestorage.app',
    iosBundleId: 'in.vishwakarthik.serverDrivenUi',
  );
}
