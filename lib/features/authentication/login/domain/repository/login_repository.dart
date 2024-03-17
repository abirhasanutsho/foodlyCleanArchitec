import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';

abstract class LoginRepository {
  Future<DataState<LoginModel>> userLogin(String email, String password);
}
