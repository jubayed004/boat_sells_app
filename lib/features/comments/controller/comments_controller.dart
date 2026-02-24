import 'package:boat_sells_app/features/comments/model/comment_model.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  // Dummy data list reflecting the design
  final List<CommentModel> dummyComments = [
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text:
          'However Rare Side Effects Observed Among Children Can Be Metabolic Acidosis, Coma, Respiratory Depre',
    ),
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text:
          'Simultaneously We Had A Problem With Prisoner Drunkenness That We Couldn\'t Figure Out. I Mean , The',
    ),
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text:
          'Their Blood Alcohol Levels Rose To 0.007 To 0.02 0/Oo (Parts Per Thousand), Or 0.7 To 2.0 Mg/L.',
      repliesCount: 1, // To show 'View More Reply'
    ),
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text:
          'Their Blood Alcohol Levels Rose To 0.007 To 0.02 0/Oo (Parts Per Thousand), Or 0.7 To 2.0 Mg/L.',
    ),
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text:
          'Their Blood Alcohol Levels Rose To 0.007 To 0.02 0/Oo (Parts Per Thousand), Or 0.7 To 2.0 Mg/L.',
    ),
    const CommentModel(
      userName: 'Darrell Steward',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2h',
      text: 'Their Blood Alcohol Levels Rose To 0.007',
    ),
  ];
}
