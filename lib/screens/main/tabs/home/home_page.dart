import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/tabs/home/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? user;

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return mainViewAppBar(
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user!.displayName ?? user!.email : '',
      // name: 'NaksheKADAM',
      // photoURL: user.photoURL ?? '',
      page: 'DASHBOARD',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.025),
            child: Container(
              height: screenHeight * 0.3,
              // width: screenWidth * 0.6,
              decoration: BoxDecoration(
                color: COLOR_THEME['dashboard'],
                borderRadius: BorderRadius.circular(screenHeight / 50),
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/dashboard.png',
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.225,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Successful set-up completion!',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: screenHeight * 0.035,
                            color: COLOR_THEME['secondary'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: Text(
                            'You are now a certified counsellor with us. You can accept and deny requests from different students and parents and begin. Self-attested types (student types 1,2,3 and 4) of each student and reports of each of the users’ tests and bot conversations will be provided to you for better understanding of your potential clients',
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: screenHeight * 0.0275,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.025),
            child: ClientCard(),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.025),
            child: Graph(),
          ),
        ],
      ),
    );
  }
}
