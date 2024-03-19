import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  bool? status;
  String? message;

  RegisterEntity({
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [];
}
