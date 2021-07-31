import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({Key? key, required this.child, required this.header})
      : super(key: key);

  final Widget header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this.header,
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: this.child,
        ),
      ],
    );
  }
}
