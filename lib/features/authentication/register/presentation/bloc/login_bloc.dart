import 'dart:convert';
import 'dart:io';

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

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final RegisterRepository loginRepository = RegisterRepositoryImpl();
  File? _imageFile; // This will hold the picked image file

  RegisterBloc() : super(LoginScreenInitial()) {
    on<RegisterDataPostEvent>(createuserLogin);
  }

  void createuserLogin(RegisterEvent event, Emitter<RegisterState> emit) async {
    emit(LoginScreenLoading());

    try {
      DataState<RegisterModel> loginModel = await loginRepository.userRegister(
          userNameController.text,
          emailController.text,
          passwordController.text,
          _imageFile!);
      if (loginModel is DataSuccess) {
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
}
