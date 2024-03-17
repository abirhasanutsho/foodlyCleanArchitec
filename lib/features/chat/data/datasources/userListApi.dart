import 'package:cleanarchitec/features/chat/data/model/userModel.dart';

import '../../../../core/dio/common_response.dart';
import '../../../../core/dio/network_call.dart';

class UserListApi {
  static Future<UserModel?> getUserList() async {
    try {
      CommonResponse response = await networkCallGet("user/users", null);
      return UserModel.fromJson(response.response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
