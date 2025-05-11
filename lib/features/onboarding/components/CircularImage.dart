
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String background;
  final String icon;

  const CircularImage({required this.background, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          background,
          width: 188,
          height: 188,
        ),
        Image.asset(
          icon,
          width: 188,
          height: 188,
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextSection({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Color(0xFF575B61),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


