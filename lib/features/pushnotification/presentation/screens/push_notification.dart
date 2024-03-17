import 'package:flutter/material.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
        title: const Text(
          'Notification',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Container(),
    );
  }
}
