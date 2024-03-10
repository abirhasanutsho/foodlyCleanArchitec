import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/profile/data/datasources/profile_datasources.dart';
import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import 'package:cleanarchitec/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<DataState<ProfileModel>> getProfile() async {
    try {
      ProfileModel? profileModel = await ProfileApiServices.profileServices();
      return DataSuccess(profileModel!);
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
