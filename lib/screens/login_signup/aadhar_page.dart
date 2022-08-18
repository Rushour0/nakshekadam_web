import 'package:flutter/cupertino.dart';
import 'package:nakshekadam_web/common_widgets/base_background.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';

class AadharPage extends StatefulWidget {
  const AadharPage({Key? key}) : super(key: key);

  @override
  State<AadharPage> createState() => _AadharPageState();
}

class _AadharPageState extends State<AadharPage> {
  final TextEditingController aadharController = TextEditingController();

  Future<void> sendOTP(screenWidth) async {}

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
