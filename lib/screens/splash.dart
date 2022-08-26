import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    value: 1,
  )..forward(from: 0);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  Future<void> check() async {
    // print('asdas');
    if (checkLoggedIn()) {
      // if (!(await checkAdmin())) {
      //   await signOut();
      //   await signOutGoogle();
      //   await VxNavigator.of(context).clearAndPush(Uri.parse('/login'));
      // } else
      if ((await checkAdmin())) {
        print("Check Admin");
        await VxNavigator.of(context).clearAndPush(Uri.parse('/admin_main'));
      }
      if (await checkFormFilled()) {
        print("Check Form Filled");
        await VxNavigator.of(context).clearAndPush(Uri.parse('/main'));
      } else {
        print('Form not filled');
        User _user = getCurrentUser()!;
        if (_user.phoneNumber != null) {
          await VxNavigator.of(context).push(Uri.parse('/main'));
        } else {
          print("phone number : ${_user.phoneNumber}");
          await VxNavigator.of(context).clearAndPush(Uri.parse('/phone_auth'));
        }
      }
    } else {
      await VxNavigator.of(context).clearAndPush(Uri.parse('/login'));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await check();
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(APP_ICON), context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: COLOR_THEME['background'],
      body: ScaleTransition(
        scale: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset(
                  APP_ICON,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
