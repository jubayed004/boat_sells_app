class BoatModel {
  final String id;
  final String imageUrl;
  final List<String> imageUrls; // multiple images for carousel
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
    this.imageUrls = const [],
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

  /// Returns imageUrls if non-empty, else falls back to [imageUrl].
  List<String> get allImages => imageUrls.isNotEmpty ? imageUrls : [imageUrl];
}
