import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:nakshekadam_web/classes/role_storage.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({Key? key}) : super(key: key);

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

extension RoleToShortString on types.Role {
  /// Converts enum to the string equal to enum's name.
  String toShortString() => toString().split('.').last;
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  final RoleStorage role = RoleStorage();
  List<types.Role> roles = [types.Role.counsellor, types.Role.expert];

  updateDetails(types.Role role) async {
    setState(() {});
    await userDocumentReference().update({
      'role': role.toShortString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return detailsBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headingCard(screenWidth: screenWidth, title: "Choose a Role"),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: roles
                    .map((role) => GestureDetector(
                          onTap: () async {
                            RoleStorage.setRole = role;
                            await updateDetails(role);

                            VxNavigator.of(context).push(Uri.parse('/details'));
                          },
                          child: roleCard(screenHeight, screenWidth, role),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
        width: screenWidth,
        height: screenHeight);
  }
}

roleCard(screenHeight, screenWidth, types.Role role) {
  return SizedBox(
    height: screenHeight * 0.4,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.01,
        ),
      ),
      color: (role == types.Role.counsellor)
          ? const Color(0xFFFED7D7)
          : const Color(0xFFC1EFFF),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "$LOGIN_TYPES_IMAGE_DIRECTORY/${role.toShortString().toLowerCase()}.png",
              width: screenHeight * 0.3,
              height: screenHeight * 0.3,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Text(
                role.toShortString().capitalized,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4D4288),
                  fontSize: screenWidth * 0.015,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
