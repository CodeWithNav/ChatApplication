import 'package:chat/global/Locator.dart';
import 'package:chat/screens/HomeScreen.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/authScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = getIt<AuthServices>().auth.currentUser;
  @override
  void initState() {
    getIt<AuthServices>().auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      home: user == null ? AuthScreen() : HomeScreen(),
    );
  }
}
