import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/globals.dart';

Widget baseBackground({
  required child,
  required width,
  required height,
}) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    body: Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        child
      ],
    ),
  );
}

Widget detailsBackground({
  required child,
  required width,
  required height,
}) {
  return baseBackground(
    height: height,
    width: width,
    child: Center(
      child: Container(
        height: height,
        width: width * 0.75,
        color: COLOR_THEME['secondary'],
        child: child,
      ),
    ),
  );
}
