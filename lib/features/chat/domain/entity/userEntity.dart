
import 'package:equatable/equatable.dart';

class UserListEntity  extends Equatable{
  bool? status;
  List<Datum>? data;

  UserListEntity({
    this.status,
    this.data,
  });


  @override
  List<Object?> get props => [
    status,
    data,
  ];
}

class Datum {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  double? lattitude;
  double? longitude;
  String? image;
  String? password;
  String? isOnline;
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
    this.lattitude,
    this.longitude,
    this.image,
    this.password,
    this.isOnline,
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
    lattitude: json["lattitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    image: json["image"],
    password: json["password"],
    isOnline: json["is_online"],
    fcmToken: json["fcmToken"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "address": address,
    "lattitude": lattitude,
    "longitude": longitude,
    "image": image,
    "password": password,
    "is_online": isOnline,
    "fcmToken": fcmToken,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
