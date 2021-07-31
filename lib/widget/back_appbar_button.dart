import 'package:flutter/material.dart';

class BackAppBarButton extends StatelessWidget {
  const BackAppBarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<CircleBorder>(
            CircleBorder(
              side: BorderSide(color: Colors.black12),
            ),
          ),
        ),
        child: Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Theme.of(context).primaryColor,
          size: 30.0,
        ),
      ),
    );
  }
}
