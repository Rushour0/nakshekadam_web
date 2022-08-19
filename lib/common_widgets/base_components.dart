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

Widget mainBackground({
  required sideBar,
  required width,
  required mainView,
  required height,
}) {
  return baseBackground(
    height: height,
    width: width,
    child: Row(
      children: [
        Container(
          height: height,
          width: width * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              // repeat: ImageRepeat.repeat,
              fit: BoxFit.cover,
              image: const AssetImage(
                'assets/images/design_pattern.png',
              ),
            ),
            // borderRadius: BorderRadius.circular(height / 20),
            color: COLOR_THEME['secondary'],
          ),
          child: sideBar,
        ),
        Container(
          height: height,
          width: width * 0.8,
          child: mainView,
        ),
      ],
    ),
  );
}

Widget mainViewAppBar({
  required child,
  required width,
  required height,
  required page,
  name,
  photoURL,
}) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Hello ${name ?? 'Guest'}',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.bold,
          fontSize: width * 0.0175,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.01),
          child: Container(
            width: height / 20,
            height: height / 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  photoURL ?? DEFAULT_PROFILE_PICTURE,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ),
    body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: EdgeInsets.only(
          top: height * 0.025,
          left: width * 0.025,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            page,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: width * 0.02,
              fontWeight: FontWeight.bold,
              color: COLOR_THEME['secondary'],
            ),
          ),
        ),
      ),
      SizedBox(
        width: width * 0.75,
        height: height * 0.825,
        child: SingleChildScrollView(child: child),
      ),
    ]),
  );
}
