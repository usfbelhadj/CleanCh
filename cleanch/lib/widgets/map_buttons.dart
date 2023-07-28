import 'package:flutter/material.dart';

import 'my_button.dart';

class MapButtons extends StatelessWidget {
  final Function() onButton1Pressed;
  final Function() onButton2Pressed;
  final Function() onButton3Pressed;

  MapButtons({
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.onButton3Pressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 62, 221, 97),
      foregroundColor: Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 12.0), // Adjust the button padding
      textStyle: TextStyle(fontSize: 18.0), // Adjust the button text size
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onButton1Pressed,
          style: buttonStyle,
          child: Text('Events'),
        ),
        ElevatedButton(
          onPressed: onButton2Pressed,
          style: buttonStyle,
          child: Text('Map'),
        ),
        ElevatedButton(
          onPressed: onButton3Pressed,
          style: buttonStyle,
          child: Text('Profile'),
        ),
      ],
    );
  }
}
