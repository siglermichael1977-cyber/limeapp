import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLxGp1F2H3I4J5K6L7M8N9O0P1Q2R3S4T',
    appId: '1:123456789:ios:abcdef1234567890',
    messagingSenderId: '123456789',
    projectId: 'lime-app-test',
    storageBucket: 'lime-app-test.appspot.com',
    iosBundleId: 'com.mykkesigler.lime',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLxGp1F2H3I4J5K6L7M8N9O0P1Q2R3S4T',
    appId: '1:123456789:android:abcdef1234567890',
    messagingSenderId: '123456789',
    projectId: 'lime-app-test',
    storageBucket: 'lime-app-test.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBLxGp1F2H3I4J5K6L7M8N9O0P1Q2R3S4T',
    appId: '1:123456789:web:abcdef1234567890',
    messagingSenderId: '123456789',
    projectId: 'lime-app-test',
    storageBucket: 'lime-app-test.appspot.com',
  );
}
