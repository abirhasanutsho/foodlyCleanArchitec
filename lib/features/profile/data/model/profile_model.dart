import 'package:cleanarchitec/features/profile/domain/entity/profileEntity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}
