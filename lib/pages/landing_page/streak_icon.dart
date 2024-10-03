import 'package:flutter/material.dart';

class StreakIcon extends StatelessWidget {
  const StreakIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.flash_on, color: Colors.yellow, size: 24),
        SizedBox(width: 4),
        Text(
          '5',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 36), // Adjust spacing here
      ],
    );
  }
}
