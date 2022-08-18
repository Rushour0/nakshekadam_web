import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_background.dart';
import 'package:nakshekadam_web/globals.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseBackground(
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A one-stop personalized guide to navigate all your career related confusions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontFamily: 'DM Sans',
              ),
            ),
            Image.asset(
              'assets/images/app_icon.png',
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: COLOR_THEME['secondary'],
                fixedSize: Size(screenWidth * 0.35, screenHeight * 0.055),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    screenHeight * 0.01,
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'SIGN UP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.035,
                  fontFamily: 'DM Sans',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.045,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.01,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,

                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: screenWidth * 0.01,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
