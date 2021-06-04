import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String url =
    'http://ec2-3-13-224-176.us-east-2.compute.amazonaws.com:3002';

final storage = FlutterSecureStorage();

class UserRepository {
  Future<String> authenticateUser({
    required String email,
    required String password,
  }) async {
    Map data = {'email': email, 'password': password};

    Map<String, dynamic> jsonData = {};

    var response =
        await http.post(Uri.parse(url + "/authentication/login"), body: data);

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(jsonData["token"]);
      storage.write(key: "jwt", value: jsonData["token"]);
      print("jwt print ho rha hai");
      var jwt = await storage.read(key: "jwt");
      print(jwt);
    } else {
      print(response.body);
    }
    return jsonData['token'];
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
