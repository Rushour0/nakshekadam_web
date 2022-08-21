import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/classes/student_type_info.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/screens/main/tabs/student_types/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

class StudentTypesPage extends StatefulWidget {
  const StudentTypesPage({Key? key}) : super(key: key);

  @override
  State<StudentTypesPage> createState() => _StudentTypesPageState();
}

class _StudentTypesPageState extends State<StudentTypesPage> {
  late User? user;
  late List<FlipCardController> controllers;

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
    controllers =
        StudentTypeInfoData.data.map((_) => FlipCardController()).toList();
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
      page: 'STUDENT TYPES',
      child: Wrap(
        runSpacing: screenHeight * 0.02,
        spacing: screenWidth * 0.02,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: StudentTypeInfoData.data.map((data) {
          int index = StudentTypeInfoData.data.indexOf(data);
          return SizedBox(
            width: screenWidth * 0.35,
            height: screenHeight * 0.4,
            child: studentTypeFlipCard(
              colorIndex: index,
              controller: controllers[index],
              title: data.title,
              description: data.description,
              content: data.content,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          );
        }).toList(),
      ),
    );
  }
}
