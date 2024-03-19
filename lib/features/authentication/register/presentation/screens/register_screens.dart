import 'package:cleanarchitec/features/authentication/register/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/login_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          "Register Screen",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage(""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: loginBloc.userNameController,
                      decoration: const InputDecoration(
                          labelText: "Enter your username",
                          hintText: "Enter your username",
                          border: OutlineInputBorder()),
                    ),
                  ),
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
                  ElevatedButton(onPressed: () {}, child: Text("Register")),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, RegisterState state) {
          if (state is LoginDataSuccess) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
