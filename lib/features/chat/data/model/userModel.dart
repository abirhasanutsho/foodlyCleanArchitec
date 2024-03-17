import 'package:cleanarchitec/features/chat/domain/entity/userEntity.dart';

class UserModel extends UserListEntity {
  UserModel({
    required super.status,
    required super.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      data: json["data"] != null
          ? (json["data"] as List).map((item) => Datum.fromJson(item)).toList()
          : null,
    );
  }
}
