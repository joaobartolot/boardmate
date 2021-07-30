import 'package:boardmate/home.dart';
import 'package:boardmate/create_match.dart';
import 'package:boardmate/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/signin' : '/',
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SigninPage(),
        '/create_match': (context) => CreateMatchPage(),
      },
    );
  }
}
