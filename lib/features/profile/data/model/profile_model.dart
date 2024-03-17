import 'package:cleanarchitec/features/profile/domain/entity/profileEntity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.success,
    required super.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}
