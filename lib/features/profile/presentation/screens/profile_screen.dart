import 'package:cleanarchitec/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/profile_event.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(ProfileDataFetchEvent());

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.indigo.withOpacity(.80),
          surfaceTintColor: Colors.indigo.withOpacity(.80),
          elevation: 10,
          centerTitle: true,
          title: const Text('Profile Screen',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileScreenLoading) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.red,
                ),
              );
            } else if (state is ProfileDataSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    "http://192.168.12.208:3000/${state.profileModel.data?.image}"),
                              ),
                            ),                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${state.profileModel.data?.username}",
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),
                                textAlign: TextAlign.center,

                              ),
                            ),
                            Text(
                              "${state.profileModel.data?.email}",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${state.profileModel.data?.phone}",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${state.profileModel.data?.address}",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProfileDataFailed) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        ));
  }
}
