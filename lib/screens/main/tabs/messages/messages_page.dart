import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/components.dart';
import 'package:nakshekadam_web/screens/main/tabs/messages/chatInterface.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final VerticalTabController _controller = VerticalTabController();
  Widget? _chatView = Container();

  void initializeChatView() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    _chatView = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight / 20),
          color: Colors.transparent,
        ),
        child: Text(
          'Open a chat to start messaging',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: COLOR_THEME['primary'],
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.025,
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      initializeChatView,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    User? user = getCurrentUser();
    return mainViewAppBar(
      page: 'MESSAGES',
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user.displayName ?? user.email : '',
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.025),
        child: Container(
          width: screenWidth * 0.75,
          height: screenHeight * 0.75,
          decoration: BoxDecoration(
            color: COLOR_THEME['secondary'],
            borderRadius: BorderRadius.circular(screenHeight / 20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: chatBar(screenWidth, user, screenHeight),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight / 20),
                  bottomRight: Radius.circular(screenHeight / 20),
                ),
              ),
              height: screenHeight * 0.05,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline_rounded),
                  Text(
                    'For any queries contact the admin!',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      color: COLOR_THEME['background'],
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.0125,
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              width: screenWidth * 0.75,
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   bottomRight: Radius.circular(screenWidth / 20),
                //   bottomLeft: Radius.circular(screenWidth / 20),
                // ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight / 20),
                  topRight: Radius.circular(screenHeight / 20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.75,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(screenHeight / 20),
                      // ),
                      color: Colors.transparent,
                    ),
                    child: _chatView ??
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenHeight / 20),
                              color: Colors.transparent,
                            ),
                            child: Text(
                              'Open a chat to start messaging',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: COLOR_THEME['primary'],
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                          ),
                        ),
                  ),
                  Container(
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight / 20),
                      color: COLOR_THEME['tertiary'],
                    ),
                    child: StreamBuilder<List<types.Room>>(
                      stream: FirebaseChatCore.instance.rooms(),
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              bottom: 200,
                            ),
                            child: const Text('No rooms'),
                          );
                        }

                        return Column(
                          children: snapshot.data!
                              //     .where(
                              //   (element) =>
                              //       element.users.first.role ==
                              //           types.Role.student ||
                              //       element.users.first.role == types.Role.parent,
                              // )
                              .map((room) {
                            // print(room.users);s
                            types.User meUser = room.users
                                .where((element) =>
                                    element.id != getCurrentUserId())
                                .toList()[0];

                            return GestureDetector(
                              onTap: () {
                                _chatView = Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      screenHeight / 20,
                                    ),
                                  ),
                                  foregroundDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      screenHeight / 20,
                                    ),
                                  ),
                                  child: ChatPage(
                                    room: room,
                                  ),
                                );
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.025,
                                ),
                                child: ListTile(
                                  leading: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.005),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        room.imageUrl ??
                                            DEFAULT_PROFILE_PICTURE,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    room.name ?? '',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: COLOR_THEME['primary'],
                                      // fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.01,
                                    ),
                                  ),
                                  subtitle: Text(
                                    meUser.role!.toShortString(),
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: COLOR_THEME['primary'],
                                      // fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //   ) Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         VerticalTabBar(
            //           initialIndex: 0,
            //           controller: _controller,
            //           labelStyle: TextStyle(
            //             fontFamily: 'DM Sans',
            //             fontSize: screenWidth * 0.0125,
            //           ),
            //           tabs: [
            //             VerticalTabBarItem(
            //                 icon: Icon(Icons.home_outlined), label: 'Home'),
            //             VerticalTabBarItem(
            //                 icon: Icon(Icons.info_outline),
            //                 label: 'Student Types'),
            //             VerticalTabBarItem(
            //                 icon: Icon(Icons.move_to_inbox_outlined),
            //                 label: 'Incoming requests'),
            //             VerticalTabBarItem(
            //                 icon: Icon(Icons.message_outlined),
            //                 label: 'Messages'),
            //             VerticalTabBarItem(
            //                 icon: Icon(Icons.notifications_active_outlined),
            //                 label: 'Notifications'),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
