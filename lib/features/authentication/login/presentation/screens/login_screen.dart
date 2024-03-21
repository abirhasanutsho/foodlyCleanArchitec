import 'dart:convert';
import 'dart:developer';

import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/login_state.dart';
import 'package:http/http.dart'as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  postLogin()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://localhost:3000/api/user/login'));
    request.body = json.encode({
      "email": "abir@gmail.com",
      "password": "12345678"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("ressss--${response.reasonPhrase}");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


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
                  SizedBox(
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
