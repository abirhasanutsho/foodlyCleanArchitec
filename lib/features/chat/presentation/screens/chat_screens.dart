import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_event.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_state.dart';
import 'package:cleanarchitec/features/chat/presentation/screens/chatDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(UserEventDataFetch());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.indigo.withOpacity(.80),
        surfaceTintColor: Colors.indigo.withOpacity(.80),
        centerTitle: true,
        title: const Text(
          "Chat",
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
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>  ChatDetails(
                        userModel: data,
                      )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                      child: Card(
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          elevation: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      "http://192.168.12.208:3000/${data?.image}"),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "${data?.username}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    "${data?.email}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  )
                                ],
                              ),
                              const Spacer(),
                            ],
                          )),
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
