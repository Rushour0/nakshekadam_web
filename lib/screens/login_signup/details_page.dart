import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam_web/common_widgets/base_components.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/login_signup/components.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController universityNameController =
      TextEditingController();
  final TextEditingController specialisationController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  FileStorage _educationFile = FileStorage(), _experienceFile = FileStorage();
  bool _declaration = false;
  bool _experience = false;

  void showSnackBar(String message) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'Cabin',
          fontSize: screenHeight * 0.035,
          color: COLOR_THEME['buttonText'],
        ),
      ),
      backgroundColor: COLOR_THEME['buttonBackground'],
    ));
  }

  bool validateAccept(screenHeight) {
    if (qualificationController.text == '') {
      showSnackBar('Please enter your qualification');
      return false;
    }
    if (_educationFile.url == null) {
      showSnackBar('Please upload your education certificate');
      return false;
    }
    if (universityNameController.text == '') {
      showSnackBar('Please enter your university name');
      return false;
    }

    if (_experience) {
      if (specialisationController.text == '') {
        showSnackBar('Please enter your specialisation');
        return false;
      }
      if (_experienceFile.url == null) {
        showSnackBar('Please upload your experience certificate');
        return false;
      }
      if (experienceController.text == '') {
        showSnackBar('Please enter your experience');
        return false;
      }
    }
    if (!_declaration) {
      showSnackBar('Please accept the declaration');
      return false;
    }
    userDocumentReference().set({
      'qualification': qualificationController.text,
      'universityName': universityNameController.text,
      'specialisation': specialisationController.text,
      'experience': experienceController.text,
      'experienceFile': _experienceFile.url,
      'educationFile': _educationFile.url,
      'declaration': _declaration,
      'detailsFilled': true,
    }, SetOptions(merge: true));
    VxNavigator.of(context).push(Uri.parse('/aadhar'));
    // VxNavigator.of(context).push(Uri.parse('/aadhar_auth'));
    return false;
  }

  Future<String> pickAFile(screenHeight) async {
    Reference? fileReference;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    TaskSnapshot? snapshot;

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      setState(() {});
      String fileName = getCurrentUserId() + result.files.first.name;
      // Upload file
      try {
        fileReference = FirebaseStorage.instance.ref('uploads/$fileName');

        snapshot = await fileReference
            .putData(fileBytes!)
            .whenComplete(() => showSnackBar('File Uploaded'));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenHeight * 0.035,
                color: COLOR_THEME['buttonText'],
              ),
            ),
            backgroundColor: COLOR_THEME['buttonBackground'],
          ),
        );
      }
    }
    return snapshot!.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return detailsBackground(
      child: Wrap(
        runSpacing: screenHeight * 0.05,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.5,
            child: headingCard(
              screenWidth: screenWidth * 0.9,
              title:
                  'Fill in your further details carefully to build your counsellor profile with us',
            ),
          ),
          SizedBox(
            width: screenWidth * 0.65,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: screenHeight * 0.025,
              children: [
                formfieldTitle(
                  screenWidth: screenWidth,
                  title:
                      'Educational qualification description (eg. MBA in economics with a PhD in Marketing):',
                ),
                normalformfield(
                  qualificationController,
                  screenHeight,
                  setState,
                  'Enter Text',
                  TextInputType.multiline,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    formfieldTitle(
                      screenWidth: screenWidth,
                      title: 'Upload proof of Educational Qualification:',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: uploadButton(
                        screenWidth,
                        screenHeight,
                        onClickFunction: pickAFile,
                        setState: setState,
                        setFileUrl: _educationFile.setFileUrl,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: screenHeight * 0.015,
                        children: [
                          formfieldTitle(
                            screenWidth: screenWidth,
                            title: 'University Name:',
                          ),
                          normalformfield(
                            universityNameController,
                            screenHeight,
                            setState,
                            'Enter Text',
                            TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: screenHeight * 0.015,
                        children: [
                          formfieldTitle(
                            screenWidth: screenWidth,
                            title: 'Specialisation :',
                          ),
                          normalformfield(
                            specialisationController,
                            screenHeight,
                            setState,
                            'Enter Text',
                            TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.6,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: screenHeight * 0.015,
                    children: [
                      formfieldTitle(
                        screenWidth: screenWidth,
                        title: 'Any prior experience in counselling?',
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                              value: true,
                              groupValue: _experience,
                              onChanged: (value) {
                                _experience = value!;
                                setState(() {});
                              }),
                          formfieldTitle(
                            screenWidth: screenWidth,
                            title: 'Yes',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                              value: false,
                              groupValue: _experience,
                              onChanged: (value) {
                                _experience = value!;
                                setState(() {});
                              }),
                          formfieldTitle(
                            screenWidth: screenWidth,
                            title: 'No',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: screenHeight * 0.015,
                    children: [
                      formfieldTitle(
                        screenWidth: screenWidth,
                        title: 'Experience (in yrs) *if yes:',
                      ),
                      normalformfield(
                        experienceController,
                        screenHeight,
                        setState,
                        'Enter Text',
                        TextInputType.number,
                        enabled: _experience,
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    formfieldTitle(
                      screenWidth: screenWidth,
                      title: 'Upload proof of Counselling Experience:',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: uploadButton(
                        screenWidth,
                        screenHeight,
                        setFileUrl: _experienceFile.setFileUrl,
                        onClickFunction: pickAFile,
                        setState: setState,
                        enabled: _experience,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        checkColor: COLOR_THEME['tertiary'],
                        activeColor: COLOR_THEME['primary'],
                        value: _declaration,
                        onChanged: (value) {
                          _declaration = value!;
                          setState(() {});
                        }),
                    formfieldTitle(
                        screenWidth: screenWidth,
                        title:
                            'I hereby declare that the information provided is true and correct'),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: continueCard(
                    screenWidth,
                    screenHeight,
                    onClickFunction: validateAccept,
                    setState: setState,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}

class FileStorage {
  Reference? _reference;
  String? _fileName;
  String? _url;

  Reference? get reference => _reference;
  String? get url => _url;
  String? get fileName => _fileName;
  setFileUrl(url) {
    _url = url;
  }
}
