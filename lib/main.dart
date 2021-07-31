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
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      // TODO: Ajust the colors of the dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff003566),
        scaffoldBackgroundColor: Color(0xff000814),
        backgroundColor: Color(0xff000814),
        cardColor: Color(0xff001329),
        appBarTheme: AppBarTheme(
          color: Color(0xff000814),
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.light,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/signin' : '/',
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SigninPage(),
        '/create_match': (context) => CreateMatchPage(),
      },
    );
  }
}
