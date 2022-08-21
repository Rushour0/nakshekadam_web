import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/tabs/incoming_requests/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({Key? key}) : super(key: key);

  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {
  final TextEditingController _searchController = TextEditingController();
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
      searchController: _searchController,
      page: 'INCOMING REQUESTS',
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.025),
        child: Wrap(
          runSpacing: screenHeight * 0.02,
          spacing: screenWidth * 0.01,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: infoList
              .map(
                (e) => RequestCard(incomingRequestInfo: e),
              )
              .toList(),
        ),
      ),
    );
  }
}

List<IncomingRequestInfo> infoList = [
  IncomingRequestInfo(),
  IncomingRequestInfo(),
  IncomingRequestInfo(),
  IncomingRequestInfo(),
  IncomingRequestInfo(),
  IncomingRequestInfo(),
  IncomingRequestInfo(),
];

class IncomingRequestInfo {
  const IncomingRequestInfo({
    this.photoURL = DEFAULT_PROFILE_PICTURE,
    this.name = 'NaksheKADAM',
    this.age = 17,
    this.clientType = 'Student',
    this.type = 1,
    this.standard = '11th',
    this.testStatus = true,
    this.vidyaBotStatus = false,
  });

  final String photoURL;
  final String clientType;
  final String name;
  final int age;
  final int type;
  final String standard;
  final bool testStatus;
  final bool vidyaBotStatus;
}
