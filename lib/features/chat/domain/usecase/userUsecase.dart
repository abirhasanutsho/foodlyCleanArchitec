import 'package:cleanarchitec/core/baseusecase/base_usecase.dart';
import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/chat/data/model/userModel.dart';
import 'package:cleanarchitec/features/chat/data/repository/user_list_impl.dart';
import 'package:cleanarchitec/features/chat/domain/repository/user_list.dart';

class UserListUseCase extends BaseUseCase {
  @override
  Future<DataState<UserModel>> call() {
    UserRepository userRepository = UserRepositoryImpl();
    return userRepository.getUserList();
  }
}
