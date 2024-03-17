import 'package:equatable/equatable.dart';

class UserListEntity extends Equatable {
  bool? status;
  List<Datum>? data;

  UserListEntity({
    this.status,
    this.data,
  });

  @override
  List<Object?> get props => [status, data];
}

class Datum {
  String? id;
  String? username;
  String? email;
  String? image;
  String? password;
  String? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.username,
    this.email,
    this.image,
    this.password,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
        isOnline: json["is_online"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "image": image,
        "password": password,
        "is_online": isOnline,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
