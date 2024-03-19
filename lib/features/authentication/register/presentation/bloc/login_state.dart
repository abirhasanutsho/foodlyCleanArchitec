import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginScreenInitial extends RegisterState {}

class LoginScreenLoading extends RegisterState {}

class LoginDataSuccess extends RegisterState {
  LoginModel? loginModel;
  LoginDataSuccess(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class LoginDataFailed extends RegisterState {
  String? message;
  LoginDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}
