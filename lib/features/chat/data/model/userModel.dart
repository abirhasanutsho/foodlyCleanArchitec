import '../../domain/entity/userEntity.dart';

class UserModel extends UserListEntity {
  UserModel({
    required super.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      data: json["data"] != null
          ? (json["data"] as List).map((item) => Datum.fromJson(item)).toList()
          : null,
    );
  }
}
