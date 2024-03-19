import 'package:cleanarchitec/features/authentication/register/domain/entity/login_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    required super.message,
    required super.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
