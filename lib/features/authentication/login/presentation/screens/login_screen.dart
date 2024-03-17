import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:cleanarchitec/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
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
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: loginBloc.emailController,
                      decoration: const InputDecoration(
                          labelText: "Enter your email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: loginBloc.passwordController,
                      decoration: const InputDecoration(
                          labelText: "Enter your password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        loginBloc.add(LoginDataPostEvent());
                      },
                      child: Text("Login")),
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
