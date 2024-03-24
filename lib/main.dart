import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cleanarchitec/core/utils/utils.dart';
import 'package:cleanarchitec/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_bloc.dart';
import 'package:cleanarchitec/features/onBoarding/presentation/screen/on_boarding_screen.dart';
import 'package:cleanarchitec/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'features/chat/presentation/screens/chat_screens.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: message.hashCode,
      channelKey: "high_importance_channel",
      title: message.data['title'],
      body: message.data['body'],
      notificationLayout: NotificationLayout.BigPicture,
      hideLargeIconOnExpand: true,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiateAccessToken();
  await initaizationUserId();
  await initiateFcmToken();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "channelKey",
        channelName: "channelName",
        channelDescription: "channelDescription",
        defaultColor: Colors.red,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        locked: true,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone),
  ]);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      FirebaseMessaging.onMessage.listen((event) {
        if (event.data['messageType'] == "call") {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 123,
              channelKey: "channelKey",
              color: Colors.white,
              title: event.notification!.title,
              body: event.notification!.body,
              category: NotificationCategory.Call,
              wakeUpScreen: true,
              fullScreenIntent: true,
              autoDismissible: false,
              backgroundColor: Colors.orange,
              displayOnBackground: true,
              displayOnForeground: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'REJECT',
                label: 'Reject call',
                color: Colors.red,
                autoDismissible: true,
              ),
              NotificationActionButton(
                key: 'ACCEPT',
                label: 'Accept call',
                color: Colors.green,
                autoDismissible: true,
              ),
            ],
          );
        } else {
          // Handle other types of notifications
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 123,
              channelKey: "channelKey",
              color: Colors.white,
              title: event.notification!.title,
              body: event.notification!.body,
              category: NotificationCategory
                  .Message, // Change to appropriate category
            ),
          );
        }
      });


      AwesomeNotifications().setListeners(
          onActionReceivedMethod:
              NotificationControllerPush.onActionReceivedMethod,
          onNotificationCreatedMethod:
              NotificationControllerPush.onNotificationCreatedMethod,
          onNotificationDisplayedMethod:
              NotificationControllerPush.onNotificationDisplayedMethod,
          onDismissActionReceivedMethod:
              NotificationControllerPush.onDismissActionReceivedMethod);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiBlocProvider(
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
        child: GetMaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFEEF1F8),
            primarySwatch: Colors.blue,
            fontFamily: "Intel",
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              errorStyle: TextStyle(height: 0),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
              errorBorder: defaultInputBorder,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/profile': (context) => ProfileScreen(),
            '/chat': (context) => const ChatScreen(),
          },
          home: accessToken.isEmpty
              ? const OnboardingScreen()
              : const ChatScreen(),
        ),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
