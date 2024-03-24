import 'dart:convert';
import 'dart:developer';

import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../core/utils/utils.dart';
import '../bloc/login_state.dart';
import 'package:http/http.dart' as http;

import '../widget/login_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF77D8E),
        surfaceTintColor: const Color(0xFFF77D8E),
        centerTitle: true,
        title: const Text(
          "Login Screen",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (_, state) {
          if (state is LoginScreenLoading) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
              ),
            );
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customTextField(
                    controller: loginBloc.emailController,
                    hintText: 'Email',
                    iconName: Icons.message_outlined,
                  ),
                  PasswordTextField(
                    hintText: 'Password',
                    iconName: Icons.lock_outline,
                    controller: loginBloc.passwordController,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (loginBloc.emailController.text.isNotEmpty &&
                          loginBloc.passwordController.text.isNotEmpty) {
                        loginBloc.add(LoginDataPostEvent());
                      } else {
                        showSnackBar(
                            context: context,
                            content: "Please fill in all fields.");
                      }
                    },
                    child: Container(
                      width: 315,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Color(0xFFF77D8E),
                        borderRadius: BorderRadius.circular(99),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4c95adfe),
                            offset: Offset(0, 10),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, LoginState state) {
          if (state is LoginDataSuccess) {
            Navigator.pushNamed(context, '/chat');
          }
        },
      ),
    );
  }
}
