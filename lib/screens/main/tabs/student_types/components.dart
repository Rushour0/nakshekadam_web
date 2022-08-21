import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/globals.dart';

Widget studentTypeFlipCard({
  required String title,
  required String description,
  required String content,
  required double screenHeight,
  required double screenWidth,
  required int colorIndex,
  FlipCardController? controller,
}) {
  return FlipCard(
    controller: controller,
    front: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          screenHeight / 100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
        color: [1, 2].contains(colorIndex)
            ? COLOR_THEME['studentType2']
            : COLOR_THEME['studentType1'],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.ads_click_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.015,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.0075,
              ),
              color: COLOR_THEME['secondary'],
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.01,
              vertical: screenHeight * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/${title.toLowerCase().replaceAll(' ', '')}.png",
                  // width: screenWidth * 0.125,
                  height: screenHeight * 0.225,
                  fit: BoxFit.fitHeight,
                ),
                Text(
                  description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.01,
                    fontFamily: "DM Sans",
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fill: Fill.fillBack,
    back: Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.01,
        vertical: screenHeight * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          screenHeight / 100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
        color: colorIndex == 1 || colorIndex == 2
            ? COLOR_THEME['studentType2']
            : COLOR_THEME['studentType1'],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          content,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: screenWidth * 0.012,
            fontFamily: "DM Sans",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
