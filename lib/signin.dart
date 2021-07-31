import 'package:boardmate/service/authentication.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => AuthService().signInWithGoogle().then(
                          (value) =>
                              Navigator.of(context).pushReplacementNamed('/'),
                        ),
                    child: Text('Sign in with Google'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
