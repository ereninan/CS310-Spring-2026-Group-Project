import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBrzxwHWBqCuwMwa2d8HpuOPksPPEYdxuk',
    appId: '1:453856742096:web:b5c09d793c05a0bde0ecd5',
    messagingSenderId: '453856742096',
    projectId: 'kampusunden-84018',
    authDomain: 'kampusunden-84018.firebaseapp.com',
    storageBucket: 'kampusunden-84018.firebasestorage.app',
    measurementId: 'G-8N6PGRD4CN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYnesUsWy2Ib9JaRL1Qw4QwuZU1kXHHiY',
    appId: '1:453856742096:android:8d300c93fd87d385e0ecd5',
    messagingSenderId: '453856742096',
    projectId: 'kampusunden-84018',
    storageBucket: 'kampusunden-84018.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCIx8YgyBOAKa2aVgO3tgn0Jj3zqKa9eo',
    appId: '1:453856742096:ios:0e477bdd7665b21be0ecd5',
    messagingSenderId: '453856742096',
    projectId: 'kampusunden-84018',
    storageBucket: 'kampusunden-84018.firebasestorage.app',
    iosBundleId: 'com.example.kampusunden',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCIx8YgyBOAKa2aVgO3tgn0Jj3zqKa9eo',
    appId: '1:453856742096:ios:0e477bdd7665b21be0ecd5',
    messagingSenderId: '453856742096',
    projectId: 'kampusunden-84018',
    storageBucket: 'kampusunden-84018.firebasestorage.app',
    iosBundleId: 'com.example.kampusunden',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBrzxwHWBqCuwMwa2d8HpuOPksPPEYdxuk',
    appId: '1:453856742096:web:b09dc1d9af7bf012e0ecd5',
    messagingSenderId: '453856742096',
    projectId: 'kampusunden-84018',
    authDomain: 'kampusunden-84018.firebaseapp.com',
    storageBucket: 'kampusunden-84018.firebasestorage.app',
    measurementId: 'G-WNX50K7607',
  );

}