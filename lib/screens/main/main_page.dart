import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/components.dart';
import 'package:nakshekadam_web/screens/main/tabs/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final VerticalTabController _controller = VerticalTabController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return mainBackground(
      height: screenHeight,
      width: screenWidth,
      sideBar: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              width: screenWidth * 0.2,
              height: screenWidth * 0.15,
            ),
            VerticalTabBar(
              initialIndex: 0,
              controller: _controller,
              labelStyle: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: screenWidth * 0.0125,
              ),
              tabs: [
                VerticalTabBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                VerticalTabBarItem(
                    icon: Icon(Icons.info_outline), label: 'Student Types'),
                VerticalTabBarItem(
                    icon: Icon(Icons.move_to_inbox_outlined),
                    label: 'Incoming requests'),
                VerticalTabBarItem(
                    icon: Icon(Icons.message_outlined), label: 'Messages'),
                VerticalTabBarItem(
                    icon: Icon(Icons.notifications_active_outlined),
                    label: 'Notifications'),
              ],
            ),
          ],
        ),
      ),
      mainView: VerticalTabBarView(
        controller: _controller,
        children: [
          // Container(child: Center(child: Text('1'))),
          HomePage(),
          Container(child: Center(child: Text('1'))),
          Container(child: Center(child: Text('2'))),
          Container(child: Center(child: Text('3'))),
          Container(child: Center(child: Text('4'))),
        ],
      ),
    );
  }
}
