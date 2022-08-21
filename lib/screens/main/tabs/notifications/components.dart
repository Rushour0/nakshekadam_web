import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nakshekadam_web/globals.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notification})
      : super(key: key);
  final NotificationInfo notification;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 3,
      color: COLOR_THEME['studentType1'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth / 80),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.0075,
          vertical: screenHeight * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: screenWidth * 0.0125,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.01,
                      ),
                      child: Text(
                        notification.date,
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: screenWidth * 0.0075,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Row(
                children: [
                  Text(
                    'Subject : ',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: screenWidth * 0.01,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    notification.subject,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: screenWidth * 0.01,
                      fontWeight: FontWeight.bold,
                      color: COLOR_THEME['secondary'],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                notification.description,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: screenWidth * 0.0095,
                  // fontWeight: FontWeight.bold,
                  color: COLOR_THEME['primary'],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.0075,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                child: Text(
                  notification.read ? 'Read' : 'Mark as Read',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: screenWidth * 0.0095,
                    color: Colors.white,
                  ),
                ),
                onPressed: notification.read ? null : () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationInfo {
  NotificationInfo({
    required this.title,
    required this.description,
    required this.date,
    required this.subject,
    required this.read,
  });
  final String title;
  final String description;
  final String date;
  final String subject;
  final bool read;
}
