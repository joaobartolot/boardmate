import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.child,
    required this.header,
    required this.validationError,
    required this.errorText,
  }) : super(key: key);

  final Widget header;
  final Widget child;
  final bool validationError;
  final String errorText;

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
        Visibility(
          visible: this.validationError,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.info,
                    size: 18.0,
                    color: Colors.red,
                  ),
                ),
                Text(
                  this.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
