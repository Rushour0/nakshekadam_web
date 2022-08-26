import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/details_page.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:velocity_x/velocity_x.dart';

TextFormField normalformfield(
  TextEditingController controller,
  double screenHeight,
  Function setState,
  String hintText,
  TextInputType keyboardType, {
  bool enabled = true,
}) {
  return TextFormField(
    enabled: enabled,
    style: TextStyle(
      fontSize: screenHeight * 0.02,
      fontFamily: 'DM Sans',
      color: Colors.black,
    ),
    controller: controller,
    onChanged: (value) {
      setState(() {});
    },
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter your $hintText";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
    ),
  );
}

TextFormField phoneformfield(
  TextEditingController phoneController,
  double screenHeight,
  Function setState,
) {
  return TextFormField(
    style: TextStyle(
      fontSize: screenHeight * 0.02,
      fontFamily: 'DM Sans',
      color: Colors.black,
    ),
    controller: phoneController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your number";
      } else if (value.length != 10) {
        return "Mobile number is 10 length long";
      } else if (!(value[0] == '5' ||
          value[0] == '6' ||
          value[0] == '7' ||
          value[0] == '8' ||
          value[0] == '9')) {
        return "Invalid mobile number";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: "Phone",
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
    ),
  );
}

bool isValidEmail(String input) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(input);
}

TextFormField emailformfield(
  TextEditingController emailController,
  double screenHeight,
  Function setState,
  String errorTextEmail,
) {
  return TextFormField(
    style: TextStyle(
      fontSize: screenHeight * 0.02,
      fontFamily: 'DM Sans',
      color: Colors.black,
    ),
    controller: emailController,
    onChanged: (value) {
      setState(() {});
    },
    validator: (value) {
      if (!isValidEmail(value as String)) {
        return "Check if mail is valid";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: "Email",
      filled: true,
      fillColor: Colors.white,
      errorText: errorTextEmail == '' ? null : errorTextEmail,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
    ),
  );
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.passwordController,
    required this.errorTextPassword,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController passwordController;
  final String errorTextPassword;
  final String hintText;
  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      style: TextStyle(
        fontSize: screenHeight * 0.02,
        fontFamily: 'DM Sans',
        color: Colors.black,
      ),
      controller: widget.passwordController,
      onChanged: (value) {
        setState(() {});
      },
      validator: (value) {
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        errorText:
            widget.errorTextPassword == '' ? null : widget.errorTextPassword,
        suffixIcon: IconButton(
          padding: EdgeInsets.only(right: screenHeight * 0.04),
          onPressed: () {
            // print("tapped");

            setState(() => hidePassword = !hidePassword);
          },
          icon: Icon(
            hidePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black,
            size: screenHeight * 0.04,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 50),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 50),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 50),
        ),
      ),
      obscureText: hidePassword,
    );
  }
}

Widget googleSignInCard(context, screenHeight, screenWidth, {bool? signIn}) {
  if (signIn == null) {
    signIn = false;
  }

  return GestureDetector(
    onTap: (() async {
      if (await signInWithGoogle()) {
        // bool isAdmin = (await checkAdmin())!;
        // if (isAdmin) {
        //   print("I AM ADMIN");
        //   Navigator.pushNamedAndRemoveUntil(context,
        //       '/admin_main_page', (route) => false);
        // } else if (await checkFormFilled()) {
        //   print("WHATS UP !");
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/main_page', (route) => false);
        // } else {
        if (!(await checkDetails())) {
          await VxNavigator.of(context).clearAndPush(Uri.parse('/choose_role'));
        }
        if (await checkAadhar()) {
          await VxNavigator.of(context).clearAndPush(Uri.parse('/main'));
        } else {
          await VxNavigator.of(context).clearAndPush(Uri.parse('/aadhar'));
        }

        // }
      }
    }),
    child: Card(
      elevation: 5,
      color: const Color(0xffDCDCE4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenHeight / 80),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        width: screenWidth * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.04,
              width: screenHeight * 0.04,
              padding: EdgeInsets.only(
                right: screenWidth * 0.007,
              ),
              child: SvgPicture.asset(
                "assets/images/google.svg",
              ),
            ),
            Text(
              "${signIn ? "SIGN UP" : "LOG IN"}  WITH GOOGLE",
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.0075,
                fontWeight: FontWeight.w900,
                color: const Color(0xff130160),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget headingCard({
  required double screenWidth,
  required String title,
}) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: screenWidth * 0.02,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget formfieldTitle({
  required double screenWidth,
  required String title,
}) {
  return Text(
    title,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: screenWidth * 0.01,
      fontFamily: 'DM Sans',
      // fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget continueCard(
  screenWidth,
  screenHeight, {
  String title = "CONTINUE",
  double widthPercent = 0.09,
  required Function(dynamic) onClickFunction,
  Function(Function())? setState,
  BuildContext? context,
}) {
  return SizedBox(
    width: screenWidth * widthPercent,
    height: screenHeight * 0.06,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff615793),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(screenHeight * 0.01),
        ),
      ),
      onPressed: () async {
        // print('I am pressed');
        if (setState != null) {
          setState(() {});
          await onClickFunction(screenHeight);
        } else {
          await onClickFunction(context);
        }
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Cabin',
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.01,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget ORWidget({required double screenHeight, required double screenWidth}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: screenWidth * 0.04,
        child: const Divider(
          color: Colors.white,
          thickness: 1,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text(
          "OR",
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.01,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        width: screenWidth * 0.04,
        child: const Divider(
          color: Colors.white,
          thickness: 1,
        ),
      ),
    ],
  );
}

Widget uploadButton(
  screenWidth,
  screenHeight, {
  Function? setFileUrl,
  required Function onClickFunction,
  Function(Function())? setState,
  BuildContext? context,
  bool enabled = true,
  String? fileName,
}) {
  return SizedBox(
    width: screenWidth * 0.09,
    height: screenHeight * 0.04,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff615793),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(screenHeight * 0.005),
        ),
      ),
      onPressed: enabled
          ? () async {
              // print('I am pressed');
              if (setState != null) {
                if (setFileUrl != null) {
                  final value = await onClickFunction(screenHeight);
                  setFileUrl(value);
                  // print(value);
                  return;
                }
                setState(() {});
                await onClickFunction(screenHeight);
              } else {
                await onClickFunction(context);
              }
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Upload File",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cabin',
              fontStyle: FontStyle.italic,
              fontSize: screenWidth * 0.01,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.file_upload_outlined,
            size: screenHeight * 0.025,
          )
        ],
      ),
    ),
  );
}
