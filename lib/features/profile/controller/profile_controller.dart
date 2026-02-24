import 'package:get/get.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';

class ProfileController extends GetxController {
  final String userName = 'Ivy Marlowe';
  final String avatarUrl = 'https://randomuser.me/api/portraits/women/44.jpg';
  final int postCount = 3;
  final int followersCount = 114;
  final int followingCount = 37;
  final String bio =
      'A Wanderer Born Under A Rare Celestial Alignment, Elowyn Channels Ancient Starlight To Heal, Protect, And Uncover Forgotten Magic.';

  final List<BoatModel> userPosts = [
    BoatModel(
      id: 'p1',
      imageUrl: 'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13',
      imageUrls: [
        'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13',
        'https://images.unsplash.com/photo-1544253106-96de23c4a2bf',
      ],
      sellerName: 'Ivy Marlowe',
      sellerAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      title: '2027 Mazu Yachts 112DS',
      location: 'New York',
      price: 12000.00,
      likes: 136,
      comments: 136,
      shares: 136,
      category: '',
    ),
    BoatModel(
      id: 'p2',
      imageUrl: 'https://images.unsplash.com/photo-1544253106-96de23c4a2bf',
      imageUrls: [
        'https://images.unsplash.com/photo-1544253106-96de23c4a2bf',
        'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13',
      ],
      sellerName: 'Ivy Marlowe',
      sellerAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      title: '2027 Mazu Yachts 112DS',
      location: 'New York',
      price: 12000.00,
      likes: 136,
      comments: 136,
      shares: 136,
      category: '',
    ),
  ];
}
