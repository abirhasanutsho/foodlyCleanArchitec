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
  List<Object?> get props => [status, message, user, token];
}

class User {
  String? id;
  String? username;
  String? email;
  String? isOnline;

  User({
    this.id,
    this.username,
    this.email,
    this.isOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        isOnline: json["is_online"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "is_online": isOnline,
      };
}