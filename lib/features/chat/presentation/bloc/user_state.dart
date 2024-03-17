import 'package:cleanarchitec/features/chat/data/model/userModel.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserDataSuccess extends UserState {
  final UserModel userModel;
  UserDataSuccess(this.userModel);
  @override
  List<Object?> get props => [userModel];
}

class UserDataFailed extends UserState {
  final String message;
  UserDataFailed(this.message);
  @override
  List<Object?> get props => [message];
}
