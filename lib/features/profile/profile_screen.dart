import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.headingText, size: 24.sp),
            onPressed: () {
              AppRouter.route.pushNamed(RoutePath.settingsScreen);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Profile Head (Avatar and Stats) ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2.w,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 38.r,
                      backgroundColor: AppColors.borderColor,
                      backgroundImage: NetworkImage(controller.avatarUrl),
                    ),
                  ),
                  SizedBox(width: 20.w),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          controller.userName,
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColors.headingText,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _StatItem(
                              value: '${controller.postCount}',
                              label: 'Posts',
                            ),
                            _StatItem(
                              value: '${controller.followersCount}',
                              label: 'Followers',
                            ),
                            _StatItem(
                              value: '${controller.followingCount}',
                              label: 'Following',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bio ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                controller.bio,
                style: context.bodySmall.copyWith(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: AppColors.headingText,
                ),
              ),
            ),
          ),

          // ── Socials and Chat Button ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  // FB, IN, X
                  _SocialCircle(label: 'FB', onTap: () {}),
                  SizedBox(width: 8.w),
                  _SocialCircle(label: 'IN', onTap: () {}),
                  SizedBox(width: 8.w),
                  _SocialCircle(label: 'X', onTap: () {}),

                  SizedBox(width: 16.w),
                  // Chat Button
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          AppRouter.route.pushNamed(
                            RoutePath.editProfileScreen,
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: context.titleSmall.copyWith(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── "Posts" Title ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Text(
                'Posts',
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.headingText,
                ),
              ),
            ),
          ),

          // ── Posts List ──
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return BoatListingCard(
                boat: controller.userPosts[index],
                onCardTap: () =>
                    AppRouter.route.pushNamed(RoutePath.detailsPostScreen),
                onCommentTap: () =>
                    AppRouter.route.pushNamed(RoutePath.commentsScreen),
              );
            }, childCount: controller.userPosts.length),
          ),

          // Bottom padding
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Helper Widgets
// ─────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: AppColors.headingText,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 12.sp,
            color: AppColors.headingText,
          ),
        ),
      ],
    );
  }
}

class _SocialCircle extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SocialCircle({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.r,
        height: 38.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.headingText, width: 1.w),
        ),
        child: Text(
          label,
          style: context.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: AppColors.headingText,
          ),
        ),
      ),
    );
  }
}
