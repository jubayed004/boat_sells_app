import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final List<ChatModel> dummyChatList = const [
    ChatModel(
      id: '1',
      userName: 'Ivy Larlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      lastMessage: 'Sent You A Message',
      time: '11.15 pm',
    ),
    ChatModel(
      id: '2',
      userName: 'Aisha Bello',
      avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      lastMessage: 'Sent You A Message',
      time: '11.15 pm',
    ),
    ChatModel(
      id: '3',
      userName: 'Kylie Jenne',
      avatarUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
      lastMessage: 'Sent You A Message',
      time: '11.15 pm',
    ),
    ChatModel(
      id: '4',
      userName: 'Sarah Connor',
      avatarUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      lastMessage: 'Sent You A Message',
      time: '10.45 pm',
    ),
    ChatModel(
      id: '5',
      userName: 'Monica Green',
      avatarUrl: 'https://randomuser.me/api/portraits/women/55.jpg',
      lastMessage: 'Sent You A Message',
      time: '09.30 am',
    ),
  ];
}
