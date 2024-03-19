import 'dart:convert';
import 'dart:developer';
import 'package:cleanarchitec/core/shared_helper/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/utils/utils.dart';
import '../../data/model/chatModel.dart';
import '../../domain/entity/userEntity.dart';

class ChatDetails extends StatefulWidget {
  final Datum? userModel;

  const ChatDetails({Key? key, this.userModel}) : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final TextEditingController sendMessageController = TextEditingController();
  List<MessageModel> messageList = [];
  late IO.Socket socket;

  var fcmToken;
  getFcm() async {
    await getFcmToken().then((value) {
      setState(() {
        fcmToken = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFcm();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io("http://192.168.0.107:4000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.emit(
        "join-room", {"roomId": generateRoomId(userId, widget.userModel!.id!)});

    socket.on("receive-message", (data) {
      if (mounted) {
        setState(() {
          messageList.add(MessageModel.fromJson(data));
        });
      }
    });

    socket.on("message-history", (data) {
      if (mounted) {
        setState(() {
          messageList = List.from(data)
              .map((item) => MessageModel.fromJson(item))
              .toList();
        });
      }
    });
  }

  String generateRoomId(String id1, String id2) {
    List<String> ids = [id1, id2];
    ids.sort();
    return ids.join("-");
  }

  Future<void> sendPushNotification({
    required String fcmToken,
    required String senderUsername,
    required String message,
  }) async {
    final apiUrl =
        'http://192.168.0.107:4000/send'; // Replace with your backend URL
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'fcmToken': fcmToken,
      'senderUsername': senderUsername,
      'message': message,
    });

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Push notification sent successfully');
      } else {
        print('Failed to send push notification: ${response.body}');
      }
    } catch (error) {
      print('Error sending push notification: $error');
    }
  }

  // Inside your sendMessage function
  void sendMessage(String message) {
    // Send message through socket
    socket.emit("message", {
      "roomId": generateRoomId(userId, widget.userModel!.id!),
      "senderId": userId,
      "recipientId": widget.userModel!.id,
      "message": message,
    });

    // Send push notification to recipient
    sendPushNotification(
      fcmToken: widget.userModel!.fcmToken.toString(),
      senderUsername: widget.userModel!.username.toString(),
      message: message,
    );

    setState(() {
      // Update UI to show sent message
      messageList.add(MessageModel(
        roomId: generateRoomId(userId, widget.userModel!.id!),
        senderId: userId,
        recipientId: widget.userModel!.id!,
        message: message,
      ));
      sendMessageController.clear();
    });
  }

  @override
  void dispose() {
    socket.disconnect(); // Disconnect from the socket
    socket.off("receive-message"); // Unsubscribe from the event
    socket.off("message-history"); // Unsubscribe from the event
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("FCM CC_${fcmToken}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userModel!.username}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: messageList.length,
              itemBuilder: (_, index) {
                var currentItem = messageList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: currentItem.senderId == userId
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: currentItem.senderId == userId
                            ? Colors.blueAccent
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${currentItem.message}",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: sendMessageController,
                    decoration: InputDecoration(
                        hintText: "Send Message", border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage(sendMessageController.text);
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
