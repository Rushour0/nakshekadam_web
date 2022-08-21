import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/tabs/profile/components.dart';
import 'package:nakshekadam_web/screens/main/tabs/profile/tabs/about.dart';
import 'package:nakshekadam_web/screens/main/tabs/profile/tabs/professional_background.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    User? user = getCurrentUser();

    return mainViewAppBar(
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user.displayName ?? user.email : '',
      // name: 'NaksheKADAM',
      // photoURL: user.photoURL ?? '',
      page: 'YOUR PROFILE',
      child: SizedBox(
        width: screenWidth * 0.75,
        height: screenHeight * 0.75,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: screenWidth / 8,
                height: screenWidth / 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user != null
                        ? user.photoURL ?? DEFAULT_PROFILE_PICTURE
                        : DEFAULT_PROFILE_PICTURE),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null
                          ? user.displayName ?? user.email as String
                          : '',
                      style: TextStyle(
                        fontSize: screenWidth * 0.025,
                        fontFamily: 'DM Sans',
                        // fontWeight: FontWeight.bold,
                        color: COLOR_THEME['secondary'],
                      ),
                    ),
                    FutureBuilder<String>(
                      initialData: 'Getting data...',
                      future: getUserRole(),
                      builder: (builder, snapshot) => Text(
                        snapshot.data!.capitalize(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.0175,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.011,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                          ),
                          labelColor: COLOR_THEME['primary'],
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: TextStyle(
                            fontSize: screenWidth * 0.01,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: [
                            Tab(
                              text: 'About',
                              icon: Icon(Icons.info_outline_rounded),
                            ),
                            Tab(
                              text: 'Professional Background',
                              icon: Icon(Icons.work_outline_rounded),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.5,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          About(),
                          ProfessionalBackground(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getUserRole() async {
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await userDocumentReference().get();
  return snapshot.data()!['role'];
}
