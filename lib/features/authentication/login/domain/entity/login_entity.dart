
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  bool? status;
  String? message;
  User? user;
  String? token;

  LoginEntity({
    this.status,
    this.message,
    this.user,
    this.token,
  });



  @override

  List<Object?> get props => [
    status,
    message,
    user,
    token
  ];
}

class User {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  double? lattitude;
  double? longitude;
  String? image;
  String? isOnline;
  String? fcmToken;

  User({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.address,
    this.lattitude,
    this.longitude,
    this.image,
    this.isOnline,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    lattitude: json["lattitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    image: json["image"],
    isOnline: json["is_online"],
    fcmToken: json["fcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "address": address,
    "lattitude": lattitude,
    "longitude": longitude,
    "image": image,
    "is_online": isOnline,
    "fcmToken": fcmToken,
  };
}
