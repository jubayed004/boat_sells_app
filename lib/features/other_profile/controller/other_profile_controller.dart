import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:get/get.dart';

class OtherProfileController extends GetxController {
  final String userName = 'Garrell Steward';
  final String avatarUrl = 'https://randomuser.me/api/portraits/women/45.jpg';
  final int postCount = 3;
  final int followersCount = 114;
  final int followingCount = 37;
  final String bio =
      'A Wanderer Born Under A Rare Celestial Alignment, Elowyn Channels Ancient Starlight To Heal, Protect, And Uncover Forgotten Magic.';

  // Initial state for follow button
  final RxBool isFollowing = false.obs;

  // Toggle follow status
  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  // To test the empty state, you can clear this list or set it to false
  final RxList<BoatModel> userPosts = <BoatModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Simulate fetching data to see the post list
    userPosts.assignAll([
      BoatModel(
        id: 'p3',
        imageUrl: 'https://images.unsplash.com/photo-1544253106-96de23c4a2bf',
        imageUrls: [
          'https://images.unsplash.com/photo-1544253106-96de23c4a2bf',
          'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a',
        ],
        sellerName: userName,
        sellerAvatar: avatarUrl,
        title: '2027 Mazu Yachts 112DS',
        location: 'New York',
        price: 12000.00,
        likes: 136,
        comments: 136,
        shares: 136,
        category: 'Yacht',
      ),
      BoatModel(
        id: 'p4',
        imageUrl:
            'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a',
        imageUrls: [
          'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a',
        ],
        sellerName: userName,
        sellerAvatar: avatarUrl,
        title: '2028 Ocean Explorer',
        location: 'Miami',
        price: 15000.00,
        likes: 245,
        comments: 89,
        shares: 32,
        category: 'Yacht',
      ),
    ]);
  }
}
