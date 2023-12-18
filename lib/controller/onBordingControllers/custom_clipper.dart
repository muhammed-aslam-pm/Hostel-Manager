import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.2); // Start from top-left
    path.lineTo(0, size.height); // Bottom-left
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(size.width, size.height * 0.2); // Right top corner

    // Create a curved top using quadraticBezierTo to curve outside
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.05, 0, size.height * 0.2);

    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
