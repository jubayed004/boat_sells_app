class CommentModel {
  final String userName;
  final String avatarUrl;
  final String timeAgo;
  final String text;
  final int repliesCount;

  const CommentModel({
    required this.userName,
    required this.avatarUrl,
    required this.timeAgo,
    required this.text,
    this.repliesCount = 0,
  });
}
