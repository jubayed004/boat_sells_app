class ChatModel {
  final String id;
  final String userName;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final bool isRead;

  const ChatModel({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.isRead = true,
  });
}
