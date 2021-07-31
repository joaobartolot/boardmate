import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    Key? key,
    this.hasBackButton = true,
    this.title = '',
  }) : super(key: key);

  final bool hasBackButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: this.hasBackButton
                      ? ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(2.5)),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(
                                side: BorderSide(color: Colors.black12),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 30.0,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99.0),
                  child: Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL!),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
