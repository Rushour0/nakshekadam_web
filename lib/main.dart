import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:nakshekadam_web/firebase_options.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/aadhar/aadhar_otp_page.dart';
import 'package:nakshekadam_web/screens/login_signup/aadhar/aadhar_page.dart';
import 'package:nakshekadam_web/screens/login_signup/choose_role.dart';
import 'package:nakshekadam_web/screens/login_signup/details_page.dart';
import 'package:nakshekadam_web/screens/login_signup/intro_page.dart';
import 'package:nakshekadam_web/screens/login_signup/login_page.dart';
import 'package:nakshekadam_web/screens/login_signup/setup_complete_page.dart';
import 'package:nakshekadam_web/screens/login_signup/signup_page.dart';
import 'package:nakshekadam_web/screens/main/main_page.dart';
import 'package:nakshekadam_web/screens/splash.dart';
import 'package:nakshekadam_web/services/Firebase/push_notification/push_notification_service.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await PushNotificationService().setupInteractedMessage();
  // print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');

  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(
        routes: {
          '/': (uri, params) => const MaterialPage(child: SplashPage()),
          '/intro': (uri, params) => const MaterialPage(child: IntroPage()),
          '/login': (uri, params) => const MaterialPage(child: LoginPage()),
          '/signup': (uri, params) => const MaterialPage(child: SignUpPage()),
          '/choose_role': (uri, params) =>
              const MaterialPage(child: ChooseRolePage()),
          '/details': (uri, params) => const MaterialPage(child: DetailsPage()),
          '/aadhar': (uri, params) => const MaterialPage(child: AadharPage()),

          // '/wt': (uri,params) => const WalkThrough(),
          '/main': (uri, params) => const MaterialPage(child: MainPage()),
          '/aadhar_otp': (uri, params) =>
              const MaterialPage(child: AadharWebViewPage()),
          '/setup_complete': (uri, params) =>
              const MaterialPage(child: SetupCompletePage()),

          // '/': (context) => const Splash(),
        },
      ),
      title: APP_TITLE,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: DEFAULT_TEXT_THEME,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: COLOR_THEME['primary'],
              secondary: COLOR_THEME['secondary'],
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              buttonColor: const Color(0xff615793),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: DEFAULT_TEXT_THEME,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: true,
      builder: (context, child) => ResponsiveWrapper.builder(child,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
    );
  }
}
