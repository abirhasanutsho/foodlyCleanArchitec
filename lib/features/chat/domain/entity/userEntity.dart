import 'package:equatable/equatable.dart';

class UserListEntity extends Equatable {
  List<Datum>? data;

  UserListEntity({
    this.data,
  });



  @override
  List<Object?> get props => [data];
}

class Datum {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? password;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.password,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        password: json["password"],
        fcmToken: json["fcmToken"],
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
        "phone": phone,
        "address": address,
        "image": image,
        "password": password,
        "fcmToken": fcmToken,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
