import 'package:cleanarchitec/features/authentication/login/domain/entity/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.message,
    required super.status,
    required super.user,
    required super.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
