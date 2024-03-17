import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/resources/datastate.dart';
import '../../../../../core/shared_helper/shared_pref.dart';
import '../../data/model/login_model.dart';
import '../../data/repository/login_repository_impl.dart';
import '../../domain/repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginRepository loginRepository = LoginRepositoryImpl();

  LoginBloc() : super(LoginScreenInitial()) {
    on<LoginDataPostEvent>(createuserLogin);
  }

  void createuserLogin(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginScreenLoading());

    try {
      DataState<LoginModel> loginModel = await loginRepository.userLogin(
          emailController.text, passwordController.text);
      if (loginModel is DataSuccess) {
        emit(LoginDataSuccess(loginModel.data));
        _saveLoginModelToPrefs(loginModel.data);
        _saveLoginModelToPrefs(loginModel.data);
        await setAccessToken(loginModel.data!.token!);
        await setUserId(loginModel.data!.user!.id!);
        await initiateAccessToken();
        await initaizationUserId();
        Fluttertoast.showToast(
            msg: "${loginModel.data?.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        emit(LoginDataFailed(loginModel.error.toString()));
        Fluttertoast.showToast(
            msg: "${loginModel.data?.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _saveLoginModelToPrefs(LoginModel? loginModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonStr = jsonEncode(loginModel?.toJson());
    await prefs.setString('loginModel', jsonStr);
  }
}
