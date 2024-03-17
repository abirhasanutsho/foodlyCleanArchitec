import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_event.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chatDetails.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(UserEventDataFetch());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
        title: const Text(
          "Chat Screen",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          if (state is UserStateLoading) {
            return const Center(
              child: SpinKitDancingSquare(
                color: Colors.red,
              ),
            );
          }
          if (state is UserDataSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: state.userModel.data?.length,
              itemBuilder: (_, index) {
                var data = state.userModel.data?[index];
                if (userId == data?.id) {
                  return Container();
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        subtitle: Text("${data?.email}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatDetails(
                                userModel: data!,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          "${data?.username}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
