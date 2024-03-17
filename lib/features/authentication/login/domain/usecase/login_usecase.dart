import 'package:cleanarchitec/core/baseusecase/base_usecase.dart';
import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:cleanarchitec/features/authentication/login/data/repository/login_repository_impl.dart';
import 'package:cleanarchitec/features/authentication/login/domain/repository/login_repository.dart';

class LoginUsecase extends BaseUseCase {
  @override
  Future<DataState<LoginModel>> call() {
    String? email;
    String? password;
    LoginRepository loginRepository = LoginRepositoryImpl();

    return loginRepository.userLogin(email!, password!);
  }
}
