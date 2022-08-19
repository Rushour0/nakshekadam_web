import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';
import 'package:velocity_x/velocity_x.dart';

class SetupCompletePage extends StatelessWidget {
  const SetupCompletePage({Key? key}) : super(key: key);

  Future<void> goToMainPage(context) async {
    await VxNavigator.of(context).clearAndPush(Uri.parse('/main'));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/setup-complete.png',
              width: screenWidth * 0.4,
              height: screenWidth * 0.25,
            ),
            Text(
              'Successful set-up completion!',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: screenHeight * 0.05,
                fontStyle: FontStyle.italic,
                color: COLOR_THEME['secondary'],
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.04,
              ),
              child: Container(
                width: screenWidth * 0.5,
                child: Text(
                    "You are now a certified counsellor with us. You can accept and deny requests from different students and parents and begin. Self-attested types (student types 1,2,3 and 4) of each student and reports of each of the users’ tests and bot conversations will be provided to you for better understanding of your potential clients",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: screenHeight * 0.025,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.04,
              ),
              child: continueCard(
                screenWidth,
                screenHeight,
                onClickFunction: goToMainPage,
                context: context,
              ),
            ),
          ],
        ),
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}
