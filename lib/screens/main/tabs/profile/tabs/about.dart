import 'package:age_calculator/age_calculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
        headingRow('Contact Information', headingStyle),
        detailsRow(
          'Aadhar Number : ',
          data != null ? data!['maskedNumber'] ?? "Loading" : "xxxx-xxxx-meow",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Mobile Number : ',
          data != null
              ? data!['phone'] == ""
                  ? "Not provided"
                  : data!['phone'] ??
                      FirebaseAuth.instance.currentUser!.phoneNumber ??
                      "Not Provided"
              : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Email-ID : ',
          FirebaseAuth.instance.currentUser!.email ?? "xxxxx@xxxx.com",
          dataHeadingStyle,
          dataStyle,
        ),
        headingRow('Basic Information', headingStyle),
        detailsRow(
          'Age : ',
          age != null
              ? AgeCalculator.age(DateTime(int.parse(age![2]),
                      int.parse(age![1]), int.parse(age![0])))
                  .years
                  .toString()
              : "Loading",
          dataHeadingStyle,
          dataStyle,
        ),
        detailsRow(
          'Gender : ',
          data != null ? data!['gender'] ?? "Not Provided" : "Not Provided",
          dataHeadingStyle,
          dataStyle,
        )
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
}
