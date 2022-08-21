import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/classes/aadhar.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';
import 'package:nakshekadam_web/services/AadharOTP/otp_auth.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:velocity_x/velocity_x.dart';

class AadharPage extends StatefulWidget {
  const AadharPage({Key? key}) : super(key: key);

  @override
  State<AadharPage> createState() => _AadharPageState();
}

extension AadharNumberValidator on String {
  bool isValidAadharNumber() {
    return RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(this);
  }
}

bool isValidAadhar(number) {
  return RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(number);
}

class _AadharPageState extends State<AadharPage> {
  final TextEditingController aadharController =
      TextEditingController(text: '483320406191');
  Aadhar aadhar = Aadhar();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendOTP(screenHeight) async {
    if (aadharController.text.isValidAadharNumber()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Aadhar number is Invalid",
          style: TextStyle(
            fontFamily: 'Cabin',
            fontSize: screenHeight * 0.035,
            color: COLOR_THEME['buttonText'],
          ),
        ),
        backgroundColor: COLOR_THEME['buttonBackground'],
      ));
      return;
    }
    setState(() {});
    String userId = getCurrentUserId();
    print(userId);
    Map<String, dynamic> results = await aadharSignIn(userId);
    print(results);
    aadhar.setId = results['id'];
    aadhar.setLink = results['url'];
    aadhar.setNumber = aadharController.text;

    await VxNavigator.of(context).clearAndPush(Uri.parse('/aadhar_otp'));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return detailsBackground(
      child: Wrap(
        runSpacing: screenHeight * 0.05,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.5,
            child: headingCard(
              screenWidth: screenWidth,
              title: 'Aadhar Authentication',
            ),
          ),
          SizedBox(
            width: screenWidth * 0.65,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: screenHeight * 0.055,
              children: [
                Image.asset(
                  'assets/images/aadhar-page.png',
                  fit: BoxFit.contain,
                  width: screenWidth * 0.3,
                  // height: screenWidth * 0.3,
                ),
                SizedBox(
                  width: screenWidth * 0.45,
                  child: headingCard(
                      screenWidth: screenWidth * 0.8,
                      title:
                          'Please verify your aadhar to be able to send in your profile request.'),
                ),
                SizedBox(
                  width: screenWidth * 0.45,
                  child: normalformfield(
                    aadharController,
                    screenHeight,
                    setState,
                    'Enter Aadhar Number',
                    TextInputType.number,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: continueCard(
                    screenWidth,
                    screenHeight,
                    onClickFunction: sendOTP,
                    title: 'Send OTP',
                    setState: setState,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}
