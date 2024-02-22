import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDsjR10UD_qarGxOuZsCcVFLTHluCmaT5E",
            authDomain: "help-anonymous-app.firebaseapp.com",
            projectId: "help-anonymous-app",
            storageBucket: "help-anonymous-app.appspot.com",
            messagingSenderId: "73112639542",
            appId: "1:73112639542:web:2f8ec51a7adee5e81de097",
            measurementId: "G-TNHJ8DRZZZ"));
  } else {
    await Firebase.initializeApp();
  }
}
