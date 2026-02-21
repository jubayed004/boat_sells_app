import 'package:boat_sells_app/features/add_post/view/add_post_screen.dart';
import 'package:boat_sells_app/features/chat/chat_screen.dart';
import 'package:boat_sells_app/features/home/home_screen.dart';
import 'package:boat_sells_app/features/profile/profile_screen.dart';
import 'package:boat_sells_app/features/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationControllerMain extends GetxController {
  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [
      const HomeScreen(),
      const SearchScreen(),
      const AddPostScreen(),
      const ChatScreen(),
      ProfileScreen(),
    ];
  }

  // List of SVG icon asset paths for the navigation bar
  final List<IconData> icons = [
    Iconsax.home,
    Iconsax.search_favorite,
    Iconsax.add_circle,
    Iconsax.message,
    Iconsax.user,
  ];

  // List of labels for the navigation bar
  final List<String> labels = ["Home", "Search", "Add", "Chat", "Profile"];
}
