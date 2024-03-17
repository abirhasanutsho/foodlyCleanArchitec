import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import 'package:cleanarchitec/features/profile/data/repository/profile_repository_impl.dart';
import 'package:cleanarchitec/features/profile/domain/repository/profile_repository.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_event.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository = ProfileRepositoryImpl();

  ProfileBloc() : super(ProfileScreenInitial()) {
    on<ProfileDataFetchEvent>(fetchData);
  }

  void fetchData(
      ProfileDataFetchEvent event, Emitter<ProfileState> emit) async {
        emit(ProfileScreenLoading());

    try {
      DataState<ProfileModel> profileModel =
          await profileRepository.getProfile();
      if (profileModel is DataSuccess) {

        emit(ProfileDataSuccess(profileModel.data!));
      } else {
        emit(ProfileDataFailed(profileModel.error.toString()));
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
