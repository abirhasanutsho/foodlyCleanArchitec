class MessageModel {
  final String roomId;
  final String senderId;
  final String recipientId;
  final String ? message;
  final String  ?image;

  MessageModel({
    required this.roomId,
    required this.senderId,
    required this.recipientId,
    this.message,
    this.image,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      roomId: json['roomId'],
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      message: json['message'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'senderId': senderId,
      'recipientId': recipientId,
      'message': message,
      'image': image,
    };
  }
}
