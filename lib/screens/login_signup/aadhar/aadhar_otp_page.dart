import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/classes/aadhar.dart';
import 'package:nakshekadam_web/classes/role_storage.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/AadharOTP/otp_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AadharWebViewPage extends StatefulWidget {
  const AadharWebViewPage({Key? key}) : super(key: key);

  @override
  State<AadharWebViewPage> createState() => _AadharWebViewPageState();
}

class _AadharWebViewPageState extends State<AadharWebViewPage> {
  int countdown = 120;
  final Aadhar aadhar = Aadhar();
  final AadharAuthenticationNotifier authenticationNotifier =
      AadharAuthenticationNotifier();
  final RoleStorage role = RoleStorage();
  bool done = false;

  String requestID = "", link = "", number = "", otp = "";
  SnackBar aadharLoginStatus(bool isSuccess) => SnackBar(
        content: Text(
          "Aadhar Login ${isSuccess ? 'Success' : 'Failed'}",
          style: TextStyle(
            fontFamily: 'Cabin',
            fontSize: MediaQuery.of(context).size.width * 0.02,
            color: COLOR_THEME['buttonText'],
          ),
        ),
        backgroundColor: COLOR_THEME['buttonBackground'],
      );

  aadharListener() async {
    if (authenticationNotifier.isAuthenticated && !done) {
      done = true;
      print("Aadhar is authenticated");
      if (await checkAadhar()) {
        return VxNavigator.of(context).push(Uri.parse('/main'));
      }
      await userDocumentReference().update({'aadharFilled': true});

      countdown = authenticationNotifier.secondsRemaining;
      setState(() {});

      // Show authenticated snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          aadharLoginStatus(authenticationNotifier.isAuthenticated));
      Map<String, dynamic> temp = (await userDocumentReference().get()).data()!;
      User user = getCurrentUser()!;
      Map<String, dynamic> data = {
        getCurrentUserId(): {
          'name': user.displayName ??
              "${(temp['firstName'] as String).capitalized} ${(temp['lastName'] as String).capitalized}",
          'educationFile': temp['educationFile'],
          'experienceFile': temp['experienceFile'],
          'experience': temp['experience'],
          'imageUrl': temp['imageUrl'],
          'qualification': temp['qualification'],
          'specialisation': temp['specialisation'],
          'universityName': temp['universityName'],
        }
      };
      // print(data);

      await setPublicData(
          data: data,
          role: (temp['role'] == 'expert')
              ? types.Role.expert
              : types.Role.student);
      VxNavigator.of(context).clearAndPush(Uri.parse('/setup_complete'));
    } else if (!authenticationNotifier.isAuthenticated &&
        authenticationNotifier.secondsRemaining == 0 &&
        !done) {
      print("Aadhar was not authenticated");
      done = true;
      ScaffoldMessenger.of(context).showSnackBar(
          aadharLoginStatus(authenticationNotifier.isAuthenticated));

      await VxNavigator.of(context).clearAndPush(Uri.parse('/aadhar'));
    }
  }

  void notifyOnAuthenticated() {
    authenticationNotifier.addListener(aadharListener);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    requestID = aadhar.id;
    number = aadhar.number;
    link = aadhar.link;
    notifyOnAuthenticated();
    _launchUrl();

    super.initState();
  }

  @override
  void dispose() {
    authenticationNotifier.removeListener(aadharListener);
    authenticationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return detailsBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authenticating your Aadhar Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenWidth * 0.03,
                color: COLOR_THEME['buttonText'],
              ),
            ),
            Text(
              'Valid for $countdown seconds',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenWidth * 0.02,
                color: COLOR_THEME['buttonText'],
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
