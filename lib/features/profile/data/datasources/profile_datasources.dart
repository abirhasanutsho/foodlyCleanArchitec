import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import '../../../../core/dio/common_response.dart';
import '../../../../core/dio/network_call.dart';

class ProfileApiServices {
  static Future<ProfileModel?> profileServices() async {
    try {
      CommonResponse response = await networkCallGet("user/single-user", null);
      return ProfileModel.fromJson(response.response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
