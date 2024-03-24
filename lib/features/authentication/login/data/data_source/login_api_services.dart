import 'dart:convert';
import 'dart:developer';
import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:http/http.dart' as http;

class LoginApiServices {
  Future<LoginModel?> loginUser(String email, String password) async {
    var response = await http.post(
      Uri.parse("http://192.168.0.102:3000/api/user/login"),
      body: {"email": email, "password": password},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log("RES__${response.body}");
      return LoginModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
