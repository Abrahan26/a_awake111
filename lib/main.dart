import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:newtotolist/main base.dart';

import 'Onboarding.dart';
import 'package:flutter/material.dart';

const firebaseOptions = FirebaseOptions(
  appId: '1:596776435344:android:a39bca37d7102d8bae6215',
  apiKey: 'AIzaSyDHFtkFkY3-tIPdFa2hSVkrIpJ76My0GYk',
  projectId: 'testfirebase-bbf06',
  messagingSenderId: '596776435344',
  authDomain: 'FIREBASE_AUTH_DOMAIN',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('asset/image/aawake.png'),
          )),
        ),
      ),
    );
  }

  void openOnBoard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
  }
}



//flutter run --no-sound-null-safety


