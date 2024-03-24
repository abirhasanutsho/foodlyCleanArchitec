import 'package:cleanarchitec/core/shared_helper/shared_pref.dart';
import 'package:cleanarchitec/features/onBoarding/presentation/screen/on_boarding_screen.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFFF77D8E),
          surfaceTintColor: const Color(0xFFF77D8E),
          elevation: 2,
          centerTitle: true,
          title: const Text(
            'Profile Screen',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Card(
                      elevation: 3,
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
                                      "http://192.168.0.102:3000/${state.profileModel.data?.image}"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${state.profileModel.data?.username}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 33.0, bottom: 24, left: 24, right: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        setAccessToken("");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const OnboardingScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF77D8E),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)))),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
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
