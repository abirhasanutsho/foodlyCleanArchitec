import 'package:cleanarchitec/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_event.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch an event to fetch data when the screen initializes
    BlocProvider.of<ProfileBloc>(context).add(ProfileDataFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
            return ListTile(
              title: Text("${state.profileModel.data?.fullName}"),
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
      ),
    );
  }
}
