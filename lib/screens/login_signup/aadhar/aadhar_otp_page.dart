import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/classes/aadhar.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/AadharOTP/otp_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';

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

  void notifyOnAuthenticated() {
    authenticationNotifier.addListener(() async {
      countdown = authenticationNotifier.secondsRemaining;
      setState(() {});
      if (authenticationNotifier.isAuthenticated && !done) {
        done = true;
        print("Aadhar is authenticated");
        done = true;
        ScaffoldMessenger.of(context).showSnackBar(
            aadharLoginStatus(authenticationNotifier.isAuthenticated));

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
    });
  }

  @override
  void initState() {
    requestID = aadhar.id;
    number = aadhar.number;
    link = aadhar.link;
    notifyOnAuthenticated();
    super.initState();
  }

  @override
  void dispose() {
    authenticationNotifier.removeListener(() {
      countdown = authenticationNotifier.secondsRemaining;
      setState(() {});
      if (authenticationNotifier.isAuthenticated) {
        print("Aadhar is authenticated");

        ScaffoldMessenger.of(context).showSnackBar(
            aadharLoginStatus(authenticationNotifier.isAuthenticated));

        VxNavigator.of(context).clearAndPush(Uri.parse('/main'));
      } else if (!authenticationNotifier.isAuthenticated &&
          authenticationNotifier.secondsRemaining == 0) {
        print("Aadhar was not authenticated");
        ScaffoldMessenger.of(context).showSnackBar(
            aadharLoginStatus(authenticationNotifier.isAuthenticated));

        VxNavigator.of(context).clearAndPush(Uri.parse('/aadhar'));
      }
    });
    authenticationNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    Future<void> _launchUrl() async {
      if (!await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.inAppWebView,
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: true),
      )) {
        throw 'Could not launch $link';
      }
    }

    _launchUrl();

    return detailsBackground(
      child: Center(
        child: Column(
          children: [
            Text(
              'Authenticating your Aadhar Number',
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenWidth * 0.03,
                color: COLOR_THEME['buttonText'],
              ),
            ),
            Text(
              'Valid for $countdown seconds',
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
