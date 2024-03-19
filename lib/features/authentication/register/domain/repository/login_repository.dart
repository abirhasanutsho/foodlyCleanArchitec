import 'dart:io';

import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/authentication/login/data/model/login_model.dart';
import 'package:cleanarchitec/features/authentication/register/data/model/login_model.dart';

abstract class RegisterRepository {
  Future<DataState<RegisterModel>> userRegister(String userName,String email, String password,File file);
}
