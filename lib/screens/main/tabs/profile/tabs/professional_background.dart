import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessionalBackground extends StatefulWidget {
  const ProfessionalBackground({Key? key}) : super(key: key);

  @override
  State<ProfessionalBackground> createState() => _ProfessionalBackgroundState();
}

class _ProfessionalBackgroundState extends State<ProfessionalBackground> {
  Map<String, dynamic>? data = {};
  List<String>? age;

  void getData() async {
    data = (await userDocumentReference().get()).data();
    setState(() {
      age = data!['dateOfBirth'].split('-');
      // print(age);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    TextStyle headingStyle = TextStyle(
      fontSize: screenWidth * 0.01,
      fontWeight: FontWeight.bold,
      color: COLOR_THEME['secondary'],
    );

    TextStyle dataHeadingStyle = TextStyle(
      color: Colors.black,
      fontSize: screenWidth * 0.014,
    );

    TextStyle dataStyle = TextStyle(
      color: Colors.black,
      fontSize: screenWidth * 0.014,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingRow('Professional Information', headingStyle),
        detailsRow(
          'University Name : ',
          data != null
              ? data!['universityName'] ?? "Not Provided"
              : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Qualification : ',
          data != null
              ? data!['qualification'] ?? "Not Provided"
              : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Specialisations : ',
          data != null
              ? data!['specialisation'] ?? "Not Provided"
              : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Experience : ',
          data != null ? data!['experience'] ?? "Not Provided" : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        ),
        headingRow('Uploaded Documents', headingStyle),
        // downloaderButton(data != null
        //     ? data!['xml'] != null
        //         ? data!['xml']['fileUrl']
        //         : null
        //     : null),
        Row(
          children: [
            Column(
              children: [
                Text(
                  'Experience file :',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.01,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                downloaderButton(data != null ? data!['experienceFile'] : null),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Column(
                children: [
                  Text(
                    'Qualification file :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  downloaderButton(
                      data != null ? data!['educationFile'] : null),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text headingRow(String heading, TextStyle headingStyle) =>
      Text(heading, style: headingStyle);

  Row detailsRow(String title, String details, TextStyle dataHeadingStyle,
      TextStyle dataStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: dataHeadingStyle),
        Text(details, style: dataStyle)
      ],
    );
  }

  Widget downloaderButton(link) {
    return ElevatedButton(
      onPressed: link != null
          ? () {
              launchUrl(Uri.parse(link));
            }
          : null,
      child: Text('Download'),
    );
  }
}
