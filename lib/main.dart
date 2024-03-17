import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/screens/chatDetails.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/login/presentation/screens/login_screen.dart';
import 'features/chat/presentation/screens/chat_screens.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiateAccessToken();
  await initaizationUserId();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/profile': (context) => ProfileScreen(),
          '/chat': (context) => ChatScreen(),
          '/chat-details': (context) => const ChatDetails(),
        },
        home: accessToken.isEmpty ? const LoginScreen() : ChatScreen(),
      ),
    );
  }
}
