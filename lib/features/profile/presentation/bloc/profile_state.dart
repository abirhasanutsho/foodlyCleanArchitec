import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileScreenInitial extends ProfileState {}

class ProfileScreenLoading extends ProfileState {}

class ProfileDataSuccess extends ProfileState {
  final ProfileModel profileModel;
  ProfileDataSuccess(this.profileModel);

  @override
  List<Object?> get props => [profileModel];
}

class ProfileDataFailed extends ProfileState {
  final String message;
  ProfileDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}
