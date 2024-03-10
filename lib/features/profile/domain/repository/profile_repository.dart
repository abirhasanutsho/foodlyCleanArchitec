import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<DataState<ProfileModel>> getProfile();
}
