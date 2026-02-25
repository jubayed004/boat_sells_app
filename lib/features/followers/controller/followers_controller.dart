import 'package:boat_sells_app/features/followers/model/follower_model.dart';
import 'package:get/get.dart';

class FollowersController extends GetxController {
  // ── Follower list (people who follow you) ──────────────────────────────────
  final RxList<FollowerModel> followers = <FollowerModel>[
    const FollowerModel(
      id: '1',
      name: 'Lauren Burch',
      avatarUrl: 'https://randomuser.me/api/portraits/women/11.jpg',
    ),
    const FollowerModel(
      id: '2',
      name: 'Lauren Burch',
      avatarUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
    ),
    const FollowerModel(
      id: '3',
      name: 'Lauren Burch',
      avatarUrl: 'https://randomuser.me/api/portraits/women/13.jpg',
    ),
    const FollowerModel(
      id: '4',
      name: 'Lauren Burch',
      avatarUrl: 'https://randomuser.me/api/portraits/women/14.jpg',
    ),
    const FollowerModel(
      id: '5',
      name: 'Lauren Burch',
      avatarUrl: 'https://randomuser.me/api/portraits/women/15.jpg',
    ),
    const FollowerModel(
      id: '6',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/21.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '7',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '8',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/23.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '9',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/24.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '10',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/25.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '11',
      name: 'Ivy Marlowe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/26.jpg',
      needsFollowBack: true,
    ),
  ].obs;

  // ── Following list (people you follow) ────────────────────────────────────
  final RxList<FollowerModel> following = <FollowerModel>[
    const FollowerModel(
      id: '101',
      name: 'Sophia Lane',
      avatarUrl: 'https://randomuser.me/api/portraits/women/31.jpg',
    ),
    const FollowerModel(
      id: '102',
      name: 'Emily Carter',
      avatarUrl: 'https://randomuser.me/api/portraits/women/32.jpg',
    ),
    const FollowerModel(
      id: '103',
      name: 'Jessica Hill',
      avatarUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
    ),
    const FollowerModel(
      id: '104',
      name: 'Mia Thornton',
      avatarUrl: 'https://randomuser.me/api/portraits/women/34.jpg',
      needsFollowBack: true,
    ),
    const FollowerModel(
      id: '105',
      name: 'Grace Monroe',
      avatarUrl: 'https://randomuser.me/api/portraits/women/35.jpg',
      needsFollowBack: true,
    ),
  ].obs;

  // ── Set of followed-back user IDs ─────────────────────────────────────────
  final RxSet<String> followedBack = <String>{}.obs;

  // ── Search queries ─────────────────────────────────────────────────────────
  final RxString followerQuery = ''.obs;
  final RxString followingQuery = ''.obs;

  // ── Filtered lists ─────────────────────────────────────────────────────────
  List<FollowerModel> get filteredFollowers {
    final q = followerQuery.value.toLowerCase();
    if (q.isEmpty) return followers;
    return followers.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  List<FollowerModel> get filteredFollowing {
    final q = followingQuery.value.toLowerCase();
    if (q.isEmpty) return following;
    return following.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void toggleFollowBack(String userId) {
    if (followedBack.contains(userId)) {
      followedBack.remove(userId);
    } else {
      followedBack.add(userId);
    }
  }

  bool isFollowedBack(String userId) => followedBack.contains(userId);
}
