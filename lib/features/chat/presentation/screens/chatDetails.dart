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

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io("http://192.168.0.100:4000", <String, dynamic>{
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

  void sendMessage(String message) {
    socket.emit("message", {
      "roomId": generateRoomId(userId, widget.userModel!.id!),
      "senderId": userId,
      "recipientId": widget.userModel!.id,
      "message": message,
    });

    setState(() {
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
  Widget build(BuildContext context) {
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
