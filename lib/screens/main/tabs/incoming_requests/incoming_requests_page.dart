import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/tabs/incoming_requests/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';

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
      // searchController: _searchController,
      page: 'INCOMING REQUESTS',
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.025),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('all_requests')
              .doc(getCurrentUserId())
              .collection('requests')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return Wrap(
                      runSpacing: screenHeight * 0.02,
                      spacing: screenWidth * 0.01,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: snapshot.data!.docs
                          .where((element) =>
                              element.data()['requestStatus'] == 'pending')
                          .map((e) {
                        final Map<String, dynamic> requestStatus = e.data();
                        // print(e.data());
                        return RequestCard(
                            incomingRequestInfo:
                                IncomingRequestInfo.fromJson(requestStatus));
                      }).toList());
                } else {
                  return Center(
                    child: Text('No Requests'),
                  );
                }
              } else {
                return Center(
                  child: Text('No Requests'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },

          // infoList
          //     .map(
          //       (e) => RequestCard(incomingRequestInfo: e),
          //     )
          //     .toList(),
        ),
      ),
    );
  }
}

// List<IncomingRequestInfo> infoList = [
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
//   IncomingRequestInfo(),
// ];

class IncomingRequestInfo {
  const IncomingRequestInfo({
    this.photoURL = DEFAULT_PROFILE_PICTURE,
    this.name = 'NaksheKADAM',
    this.clientType = 'Student',
    this.type = 1,
    this.standard = '11th',
    this.testStatus = true,
    this.vidyaBotStatus = false,
    this.uid = '',
  });

  IncomingRequestInfo.fromJson(Map<String, dynamic> json)
      : photoURL = json['photoURL'] as String,
        name = json['name'] as String,
        clientType = json['clientType'] as String,
        type = json['type'] as int,
        uid = json['uid'] as String,
        // type = 1,
        standard = json['standard'] as String,
        testStatus = (json['testStatus'] as List).contains(1),
        vidyaBotStatus = false;

  final String photoURL;
  final String clientType;
  final String name;
  final String uid;

  final int type;
  final String standard;
  final bool testStatus;
  final bool vidyaBotStatus;
}
