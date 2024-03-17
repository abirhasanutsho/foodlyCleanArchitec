import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginScreenInitial extends LoginState {}

class LoginScreenLoading extends LoginState {}

class LoginDataSuccess extends LoginState {
  LoginModel? loginModel;
  LoginDataSuccess(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class LoginDataFailed extends LoginState {
  String? message;
  LoginDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}
