class BoatModel {
  final String id;
  final String imageUrl;
  final String sellerName;
  final String sellerAvatar;
  final bool isVerified;
  final String title;
  final double price;
  final String location;
  final int likes;
  final int comments;
  final int shares;
  final bool isSaved;
  final String category;

  const BoatModel({
    required this.id,
    required this.imageUrl,
    required this.sellerName,
    required this.sellerAvatar,
    this.isVerified = true,
    required this.title,
    required this.price,
    required this.location,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isSaved = false,
    required this.category,
  });
}
