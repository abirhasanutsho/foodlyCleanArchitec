import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/authentication/login/data/data_source/login_api_services.dart';
import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:cleanarchitec/features/authentication/login/domain/repository/login_repository.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<DataState<LoginModel>> userLogin(String email, String password) async {
    try {
      LoginModel? loginModel =
          await LoginApiServices().loginUser(email, password);
      return DataSuccess(loginModel!);
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
