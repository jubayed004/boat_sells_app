import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:get/get.dart';

class InboxController extends GetxController {
  // User info for the chat header
  final String userName = 'Ivy Marlowe';
  final String avatarUrl = 'https://randomuser.me/api/portraits/women/44.jpg';

  // Dummy conversation messages
  final List<InboxMessageModel> messages = const [
    InboxMessageModel(
      text:
          'Hi Doctor, I\'ve Been Having A Headache Since Yesterday, And It Hasn\'t Gone Away.',
      isSent: false,
    ),
    InboxMessageModel(
      text:
          'I\'m Sorry To Hear That. Can You Describe The Headache—Does It Feel Sharp, Dull Or Throbbing?',
      isSent: true,
    ),
    InboxMessageModel(
      text: 'It\'s More Of A Dull Pain, Mostly Around My Forehead.',
      isSent: false,
    ),
    InboxMessageModel(
      text:
          'See, Have You Noticed Any Other Symptoms Like Fever, Nausea, Or Vision Changes?',
      isSent: true,
    ),
    InboxMessageModel(
      text: 'No Fever, But I Felt A Little Dizzy In The Morning.',
      isSent: false,
    ),
    InboxMessageModel(
      text: 'Thanks For Sharing That. Have You Taken Any Medication For It?',
      isSent: true,
    ),
  ];
}
