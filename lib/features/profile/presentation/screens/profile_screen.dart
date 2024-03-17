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
          backgroundColor: Colors.indigo,
          surfaceTintColor: Colors.indigo,
          elevation: 10,
          centerTitle: true,
          title: const Text('Profile Screen'),
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
                            // Image.network("http://192.168.0.100:4000/api/${state.profileModel.data!.image!}",height: 60,width: 60,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${state.profileModel.data?.username}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${state.profileModel.data?.email}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${state.profileModel.data?.isOnline == "0" ? "InActive" : "Active"}",
                                textAlign: TextAlign.center,
                              ),
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
