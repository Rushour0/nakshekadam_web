import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';

import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;
  String errorTextEmail = '', errorTextPassword = '';

  Future<void> login(screenHeight) async {
    List<dynamic> result = await signInUser(
        email: emailController.text, password: passwordController.text);

    // print(result);
    if (result[0] == 0) {
      // if ((await checkAdmin())!) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/admin_main_page', (route) => false);
      // }
      // if (await checkFormFilled()) {
      //   print("WHATS UP !");
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/main_page', (route) => false);
      // } else {
      // User _user = FirebaseAuth.instance.currentUser!;
      // if (_user.phoneNumber != null) {
      //   Navigator.of(context).push(CustomPageRouter(child: const NameSex()));
      // } else {

      VxNavigator.of(context).clearAndPush(Uri.parse('/main'));
      // }}
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result[1].toString().capitalized,
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenHeight * 0.035,
              color: COLOR_THEME['buttonText'],
            ),
          ),
          backgroundColor: COLOR_THEME['buttonBackground'],
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseBackground(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              repeat: ImageRepeat.repeatX,
              image: const AssetImage(
                'assets/images/design_pattern.png',
              ),
            ),
            borderRadius: BorderRadius.circular(screenHeight / 20),
            color: COLOR_THEME['secondary'],
          ),
          height: screenHeight * 0.7,
          width: screenWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/woman.png',
                width: screenHeight * 0.3,
                height: screenHeight * 0.3,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                ),
                child: Column(
                  children: [
                    headingCard(
                      screenWidth: screenWidth,
                      title: 'LOG IN TO YOUR ACCOUNT',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.04,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: emailformfield(emailController, screenHeight,
                            setState, errorTextEmail),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: PasswordFormField(
                          passwordController: passwordController,
                          errorTextPassword: errorTextPassword,
                          hintText: 'Enter password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: ORWidget(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: googleSignInCard(
                        context,
                        screenHeight,
                        screenWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: continueCard(
                        screenWidth,
                        screenHeight,
                        onClickFunction: login,
                        setState: setState,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: continueCard(
                        screenWidth,
                        screenHeight,
                        onClickFunction: (value) async {
                          await VxNavigator.of(context)
                              .clearAndPush(Uri.parse('/signup'));
                        },
                        setState: setState,
                        title: "Don't have an acconut?\nCreate account",
                        widthPercent: 0.15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}
