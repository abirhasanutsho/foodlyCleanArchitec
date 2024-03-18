import 'dart:async';

import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/screens/chatDetails.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/login/presentation/screens/login_screen.dart';
import 'features/chat/presentation/screens/chat_screens.dart';
import 'features/notification/data/model/push_model.dart';
import 'features/notification/presentation/screens/notification_bloc_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiateAccessToken();
  await initaizationUserId();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    _messaging.getToken().then((value) {
      if (kDebugMode) {
        print('Fcm::${value!}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
          path: message.data['path'],
        );
        notificationBloc.notification(notification);
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
          title: initialMessage.notification?.title,
          body: initialMessage.notification?.body,
          dataTitle: initialMessage.data['title'],
          dataBody: initialMessage.data['body'],
          path: initialMessage.data['path']);

      print("Abir${notification.path}");

      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
        path: message.data['path'],
      );

      setState(() {
        _notificationInfo = notification;
      });
    });

    Timer(const Duration(seconds: 3), () async {
      if (kDebugMode) {}

      if (_notificationInfo != null) {
        //Route Specific Screen
      } else {
        Navigator.pushNamed(context, "/chat");
      }
    });
  }

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
