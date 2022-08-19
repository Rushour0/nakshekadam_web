import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/classes/aadhar.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/AadharOTP/otp_auth.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';

class AadharWebViewPage extends StatefulWidget {
  const AadharWebViewPage({Key? key}) : super(key: key);

  @override
  State<AadharWebViewPage> createState() => _AadharWebViewPageState();
}

class _AadharWebViewPageState extends State<AadharWebViewPage> {
  final TextEditingController aadharController = TextEditingController();
  late WebViewXController webViewController;
  late Image image;
  bool imageReady = false;
  bool isLoading = false;
  final Aadhar aadhar = Aadhar();
  bool firstLink = true;

  String requestID = "", link = "", number = "", otp = "";

  void resetWebView() {
    firstLink = true;
    isLoading = false;
  }

  @override
  void initState() {
    requestID = aadhar.id;
    number = aadhar.number;
    link = aadhar.link;
    super.initState();
  }

  void getLinks() async {
    print("MY AADHAR:$number");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    SnackBar aadharLoginStatus(isSuccess) => SnackBar(
          content: Text(
            "Aadhar Login ${isSuccess ? 'Success' : 'Failed'}",
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenWidth * 0.04,
              color: COLOR_THEME['buttonText'],
            ),
          ),
          backgroundColor: COLOR_THEME['buttonBackground'],
        );

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

    return Scaffold(
      body:
          //   SizedBox(
          // height: screenHeight * 0.9,
          // width: screenWidth,
          // child: WebView(
          //   initialUrl: link,
          // zoomEnabled: false,
          // javascriptMode: JavascriptMode.unrestricted,
          // onPageStarted: (url) async {
          //   print(await webViewController.getTitle());
          //   if (firstLink) {
          //     for (int num = 1; num < 4; num++) {
          //       (await webViewController.runJavascriptReturningResult(
          //           "window.document.getElementById('aadhaar_$num').value = ${number.substring((num - 1) * 4, num * 4)};"));
          //     }
          //     await Future.delayed(
          //         Duration(seconds: 1),
          //         () async => await webViewController.runJavascriptReturningResult(
          //             "document.getElementsByName('sendButton')[0].click();"));
          //   }

          //   firstLink = false;
          //   print(url);
          //   if (url ==
          //       "https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=True&id=$requestID") {
          //     String rawJson = (await webViewController.runJavascriptReturningResult(
          //         "window.document.getElementsByTagName('html')[0].outerHTML;"));
          //     setState(() {});
          //     Map<String, dynamic> data = jsonDecode(
          //       rawJson
          //           .substring(
          //             rawJson.indexOf('{'),
          //             rawJson.lastIndexOf('}') + 1,
          //           )
          //           .replaceAll(r'\n', '')
          //           .replaceAll(r'\', ''),
          //     );

          //     print(data);
          //     Uint8List photo = base64Decode(data['aadhaar']['photo']);

          //     imageReady = true;

          //     ScaffoldMessenger.of(context).showSnackBar(aadharLoginStatus(true));
          //     // Loading image from aadhar card
          //     image = Image.memory(photo);
          //     resetWebView();
          //   } else if (url ==
          //       'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
          //     print('failure');
          //     resetWebView();
          //     ScaffoldMessenger.of(context)
          //         .showSnackBar(aadharLoginStatus(false));
          //   }
          // },
          // onWebViewCreated: (controller) {
          //   webViewController = controller;
          // },
          //   ),
          // )
          WebViewX(
        webSpecificParams: WebSpecificParams(
          printDebugInfo: true,
          webAllowFullscreenContent: true,
        ),
        initialContent: '<h1> You are being redirected !</h1>',
        initialSourceType: SourceType.html,
        width: screenWidth,
        height: screenHeight,
        javascriptMode: JavascriptMode.unrestricted,
        jsContent: const {
          EmbeddedJsContent(
            js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
          ),
          EmbeddedJsContent(
            webJs:
                "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
            mobileJs:
                "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
          ),
        },
        onPageStarted: (url) async {
          // print(await webViewController.getContent());
          if (url != link) return;
          if (firstLink) {
            print('hi');
            try {
              for (int num = 1; num < 4; num++) {
                (await webViewController.evalRawJavascript(
                    "window.document.getElementById('aadhaar_$num').value = ${number.substring((num - 1) * 4, num * 4)};"));
              }
              await Future.delayed(
                  Duration(seconds: 1),
                  () async => await webViewController.evalRawJavascript(
                      "document.getElementsByName('sendButton')[0].click();"));
            } catch (e) {
              print(e);
            }
          }
          print(number);
          firstLink = false;
          print(url);
          if (url ==
              "https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=True&id=$requestID") {
            String rawJson = (await webViewController.evalRawJavascript(
                "window.document.getElementsByTagName('html')[0].outerHTML;"));
            setState(() {});
            Map<String, dynamic> data = jsonDecode(
              rawJson
                  .substring(
                    rawJson.indexOf('{'),
                    rawJson.lastIndexOf('}') + 1,
                  )
                  .replaceAll(r'\n', '')
                  .replaceAll(r'\', ''),
            );

            print(data);
            Uint8List photo = base64Decode(data['aadhaar']['photo']);

            imageReady = true;

            ScaffoldMessenger.of(context).showSnackBar(aadharLoginStatus(true));
            // Loading image from aadhar card
            image = Image.memory(photo);
            resetWebView();
          } else if (url ==
              'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
            print('failure');
            resetWebView();
            ScaffoldMessenger.of(context)
                .showSnackBar(aadharLoginStatus(false));
          }
        },
        onWebViewCreated: (controller) async {
          webViewController = controller;
          await webViewController.loadContent(link, SourceType.url);

          print(webViewController);
        },
      ),
    );
  }
}
