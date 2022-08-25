import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';

Future<Map<String, dynamic>> aadharSignIn(String userId) async {
  Uri url = Uri.parse(
      "https://aadharotp.rushour0.repl.co/digilocker/initiate?userId=$userId");

  http.Response response =
      await http.get(url, headers: {"Access-Control_Allow_Origin": "*"});

  Map<String, dynamic> data = jsonDecode(response.body);

  return data;
}

Future<Map<String, dynamic>> getAadharDocument(String requestId) async {
  Uri url = Uri.parse(
      "https://aadharotp.rushour0.repl.co/digilocker/aadhar?request_id=$requestId");
  http.Response response =
      await http.post(url, headers: {"Access-Control_Allow_Origin": "*"});

  Map<String, dynamic> data = jsonDecode(response.body);

  return data;
}

class AadharAuthenticationNotifier extends ChangeNotifier {
  static Timer _timer = Timer(Duration(seconds: 0), () {});
  static int _secondsRemaining = 0;

  AadharAuthenticationNotifier() {
    _secondsRemaining = 120;
    checkingIfAuthenticated();
    notifyListeners();
  }
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  int get secondsRemaining => _secondsRemaining;

  set setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void checkingIfAuthenticated() async {
    try {
      DocumentReference userDocument = userDocumentReference();
      Map<String, dynamic> data = {};
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining == 0) {
          _timer.cancel();
          return;
        }
        _secondsRemaining--;
        _timer = timer;
        userDocument.get().then((value) async {
          data = value.data() as Map<String, dynamic>;

          // data!.putIfAbsent('deviceIDs', () => []);
          if (data['maskedNumber'] != null) {
            setAuthenticated = true;
          }
        });
      });
    } catch (e) {
      print('No user logged in');
    }
  }
}
