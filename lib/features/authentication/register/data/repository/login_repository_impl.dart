import 'dart:io';

import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/authentication/register/data/data_source/login_api_services.dart';
import 'package:cleanarchitec/features/authentication/register/data/model/login_model.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/login_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<DataState<RegisterModel>> userRegister(String userName,String email, String password,File file) async {
    try {
      RegisterModel? registerModel =
          await RegisterApiServices().registerUser(userName,email, password,file);
      return DataSuccess(registerModel!);
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
