import 'dart:convert';
import 'dart:developer';
import 'package:cleanarchitec/features/call/presentation/screen/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:cleanarchitec/core/shared_helper/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:cleanarchitec/core/utils/utils.dart';
import '../../data/model/chatModel.dart';
import '../../domain/entity/userEntity.dart';

class ChatDetails extends StatefulWidget {
  final Datum? userModel;

  const ChatDetails({super.key, this.userModel});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final TextEditingController sendMessageController = TextEditingController();
  List<MessageModel> messageList = [];
  late IO.Socket socket;

  final ScrollController scrollController = ScrollController();

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
    socket = IO.io("http://192.168.0.102:3000", <String, dynamic>{
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
    const apiUrl =
        'http://192.168.0.102:3000/api/send'; // Replace with your backend URL
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

  Future<void> sendCall(String name, String token, String id) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAdd6uXzw:APA91bHJP_fTXKAxwtnkXe5kgYh13tAvX9BScSKOeZiRR5lHEaCDm4MQCNUrA7oDbWQgKHRL399rHnKcNgPAfAUnweeR7P0Nu0yJ-LYfQBHt2MKJ2N_Qu0nhrRk9zOuxDg_Egms9vrod',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "${name}",
              'title': 'Incoming calls',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'messageType': "call",
            },
            'to': "${token}",
          },
        ),
      );
      print("RES_${response.body}");
      response;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CallScreen(
                    channelId: id,
                  )));
    } catch (e) {
      e;
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

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
    log("kk--${widget.userModel?.id}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sendCall(widget.userModel!.username!,
                    widget.userModel!.fcmToken!, widget.userModel!.id!);
              },
              icon: const Icon(
                Icons.call_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam_outlined,
                size: 30,
              )),
        ],
        backgroundColor: const Color(0xFFF77D8E),
        surfaceTintColor: const Color(0xFFF77D8E),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Chat with ${widget.userModel!.username}',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              primary: false,
              itemCount: messageList.length,
              itemBuilder: (_, index) {
                var currentItem = messageList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: currentItem.senderId == userId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: currentItem.senderId == userId
                            ? Colors.pinkAccent.withOpacity(.70)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      child: Text(
                        "${currentItem.message}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          buildChatComposer(),
        ],
      ),
    );
  }

  Widget buildChatComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: sendMessageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message ...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          InkWell(
            onTap: () {
              if (sendMessageController.text.isNotEmpty) {
                sendMessage(sendMessageController.text);
              } else {
                Fluttertoast.showToast(
                    msg: "Please Input your message",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xFFF77D8E), shape: BoxShape.circle),
              child: const Icon(
                Icons.send_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
