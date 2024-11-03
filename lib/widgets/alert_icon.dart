import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Icon(
        Icons.warning,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}
