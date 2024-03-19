import 'dart:io';
import 'package:cleanarchitec/features/authentication/register/data/model/login_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/utils/utils.dart';

class RegisterApiServices {
  Future<RegisterModel?> registerUser(
      String userName, String email, String password, File imageFile) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:4000/api/user/register'));
    request.fields.addAll({
      'username': '$userName',
      'email': '$email',
      'password': '$password',
      'fcmToken': '$fcmToken',
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', '${imageFile.path}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
