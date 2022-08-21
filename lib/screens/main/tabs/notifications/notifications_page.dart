import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/screens/main/tabs/notifications/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
        page: 'NOTIFICATIONS',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NotificationCard(
              notification: notification,
            ),
            NotificationCard(
              notification: notification,
            ),
            NotificationCard(
              notification: notification,
            ),
            NotificationCard(
              notification: notification,
            ),
            NotificationCard(
              notification: notification,
            ),
          ],
        ));
  }
}

NotificationInfo notification = NotificationInfo(
  title: 'NaksheKADAM',
  description:
      'NaksheKADAM is a platform for students to get access to the best resources available in the field of engineering.',
  date: 'Today',
  subject: 'NaksheKADAM',
  read: false,
);
