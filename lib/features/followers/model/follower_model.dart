class FollowerModel {
  final String id;
  final String name;
  final String? avatarUrl;

  /// false → already mutual (show "Message")
  /// true  → they follow you but you don't follow back (show "Follow Back")
  final bool needsFollowBack;

  const FollowerModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.needsFollowBack = false,
  });
}
