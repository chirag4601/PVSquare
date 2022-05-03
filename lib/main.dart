import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pvsquare/screens/homeScreen.dart';
import 'package:pvsquare/screens/loginScreen.dart';

var firebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase = await ;
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const GetMaterialApp(home: LoginScreen());
          } else {
            return const GetMaterialApp(home: HomeScreen());
          }
        });
  }
}
