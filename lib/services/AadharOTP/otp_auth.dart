import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> aadharSignIn() async {
  Uri url = Uri.parse("https://aadharotp.rushour0.repl.co/digilocker/initiate");

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
