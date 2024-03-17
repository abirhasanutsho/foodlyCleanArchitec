import 'package:cleanarchitec/core/baseusecase/base_usecase.dart';
import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import 'package:cleanarchitec/features/profile/data/repository/profile_repository_impl.dart';
import 'package:cleanarchitec/features/profile/domain/repository/profile_repository.dart';

class ProfileUseCase extends BaseUseCase {
  @override
  Future<DataState<ProfileModel>> call( ) {
    ProfileRepository profileRepository = ProfileRepositoryImpl();
    return profileRepository.getProfile();
 }
}
