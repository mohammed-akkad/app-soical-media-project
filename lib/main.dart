import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soprise/Provider/UsersProvider.dart';
import 'package:soprise/screen/Login.dart';
import 'package:soprise/screen/home.dart';
import 'package:soprise/service/firebaseAuthHelp.dart';
import 'package:soprise/service/storage.dart';

import 'firebase_options.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [  ChangeNotifierProvider<UsersProvider>(create: (context) {
        return UsersProvider();
      })],
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('error'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Splash();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

String? finalEmail, finalUserName;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final Storage storage = Storage();
  // var currentUser = FirebaseAuth.instance.currentUser;

  var currentUser = FirebaseAuthHelper.auth.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(Duration(seconds: 5)).then((value) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => currentUser != null ? Home() : Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("asstst/image/logo.png"),
      ),
    );
  }
}
