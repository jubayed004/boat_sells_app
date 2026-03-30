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
  final RxList<BoatItem> userPosts = <BoatItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Simulate fetching data to see the post list
    userPosts.assignAll([
      BoatItem(
        id: 'p3',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1544253106-96de23c4a2bf'),
          Media(url: 'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a'),
        ],
        user: User(name: userName, avatarUrl: avatarUrl),
        displayTitle: '2027 Mazu Yachts 112DS',
        location: 'New York',
        price: 12000,
        likesCount: 136,
        commentsCount: 136,
        shareCount: 136,
      ),
      BoatItem(
        id: 'p4',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a'),
        ],
        user: User(name: userName, avatarUrl: avatarUrl),
        displayTitle: '2028 Ocean Explorer',
        location: 'Miami',
        price: 15000,
        likesCount: 245,
        commentsCount: 89,
        shareCount: 32,
      ),
    ]);
  }
}
