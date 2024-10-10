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
    apiKey: 'AIzaSyBcTnKpYk897T44k4m7Xi61y-o4dYkmO6w',
    appId: '1:558775650979:web:ea8e249c0a8e8922c20d16',
    messagingSenderId: '558775650979',
    projectId: 'freasetutorial',
    authDomain: 'freasetutorial.firebaseapp.com',
    storageBucket: 'freasetutorial.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAD0CKDv-D1NgwHwyueEGiEEV-QsWom-sw',
    appId: '1:558775650979:android:77ad43a0b5e22da9c20d16',
    messagingSenderId: '558775650979',
    projectId: 'freasetutorial',
    storageBucket: 'freasetutorial.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbmNOfjJg9nfJSr3zYLXeQKUVjwadpAXo',
    appId: '1:558775650979:ios:3fb7a2908079cb09c20d16',
    messagingSenderId: '558775650979',
    projectId: 'freasetutorial',
    storageBucket: 'freasetutorial.appspot.com',
    iosBundleId: 'com.lwmsoftltd.firebaseTutorial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbmNOfjJg9nfJSr3zYLXeQKUVjwadpAXo',
    appId: '1:558775650979:ios:3fb7a2908079cb09c20d16',
    messagingSenderId: '558775650979',
    projectId: 'freasetutorial',
    storageBucket: 'freasetutorial.appspot.com',
    iosBundleId: 'com.lwmsoftltd.firebaseTutorial',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcTnKpYk897T44k4m7Xi61y-o4dYkmO6w',
    appId: '1:558775650979:web:9e49832e3f03763cc20d16',
    messagingSenderId: '558775650979',
    projectId: 'freasetutorial',
    authDomain: 'freasetutorial.firebaseapp.com',
    storageBucket: 'freasetutorial.appspot.com',
  );

}