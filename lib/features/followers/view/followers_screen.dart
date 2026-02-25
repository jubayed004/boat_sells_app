import 'package:boat_sells_app/features/followers/controller/followers_controller.dart';
import 'package:boat_sells_app/features/followers/widgets/follower_widgets.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final FollowersController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<FollowersController>();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.headingText),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(44.h),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.subHeadingText,
            indicatorColor: AppColors.primaryBlue,
            indicatorWeight: 2.5,
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(text: '${_controller.followers.length} Followers'),
              Tab(text: '${_controller.following.length} Following'),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // ─── Search bar ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.sectionBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: TextField(
                onChanged: (val) {
                  // Update the active tab's search query
                  if (_tabController.index == 0) {
                    _controller.followerQuery.value = val.trim();
                  } else {
                    _controller.followingQuery.value = val.trim();
                  }
                },
                style: TextStyle(fontSize: 14.sp, color: AppColors.headingText),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.hintTextColor,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.hintTextColor,
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),

          // ─── Tab views ──────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Followers tab
                Obx(() => UserList(items: _controller.filteredFollowers)),
                // Following tab
                Obx(() => UserList(items: _controller.filteredFollowing)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
