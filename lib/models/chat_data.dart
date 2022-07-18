import 'dart:ffi';

class ChatData {
  String text;
  int? senderId;

  ChatData({
    required this.text,
    required this.senderId,
  });
}

List<ChatData> chat_data = [
  ChatData(
    text: 'Hi',
    senderId: 1,
  ),
  ChatData(
    text: 'Hi this is Sam',
    senderId: 2,
  ),
];
