import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/other_profile/controller/other_profile_controller.dart';
import 'package:boat_sells_app/features/profile/widgets/profile_stat_item.dart';
import 'package:boat_sells_app/features/profile/widgets/social_circle.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/dialog/custom_dialog.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  final OtherProfileController controller = Get.put(OtherProfileController());

  @override
  void dispose() {
    Get.delete<OtherProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert_rounded,
              color: AppColors.headingText,
              size: 24.sp,
            ),
            color: AppColors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              if (value == 'share') {
                // TODO: Handle Profile Share
                AppToast.info(message: 'Share Profile Selected');
              } else if (value == 'report') {
                // TODO: Handle User Report
                AppToast.info(message: 'Report User Selected');
              } else if (value == 'block') {
                // TODO: Handle User Block
                AppToast.info(message: 'Block User Selected');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                // PopupMenuItem(
                //   value: 'share',
                //   child: Text(
                //     'Share Profile',
                //     style: context.bodyMedium.copyWith(fontSize: 14.sp),
                //   ),
                // ),
                PopupMenuItem(
                  value: 'report',
                  child: Text(
                    'Report User',
                    style: context.bodyMedium.copyWith(fontSize: 14.sp),
                  ),
                ),
                // PopupMenuItem(
                //   value: 'block',
                //   child: Text(
                //     'Block User',
                //     style: context.bodyMedium.copyWith(fontSize: 14.sp),
                //   ),
                // ),
              ];
            },
          ),
        ],
      ),
      body: Obx(
        () => CustomScrollView(
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
                              ProfileStatItem(
                                value: '${controller.postCount}',
                                label: 'Posts',
                              ),
                              ProfileStatItem(
                                value: '${controller.followersCount}',
                                label: 'Followers',
                              ),
                              ProfileStatItem(
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

            // ── Socials and Action Buttons (Follow / Chat) ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    // FB, IN, X
                    SocialCircle(label: 'FB', onTap: () {}),
                    SizedBox(width: 8.w),
                    SocialCircle(label: 'IN', onTap: () {}),
                    SizedBox(width: 8.w),
                    SocialCircle(label: 'X', onTap: () {}),

                    SizedBox(width: 16.w),

                    // Follow Button
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: controller.isFollowing.value
                                  ? AppColors.borderColor
                                  : AppColors.primaryBlue,
                              width: 1.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: controller.toggleFollow,
                          child: Text(
                            controller.isFollowing.value
                                ? 'Following'
                                : 'Follow',
                            style: context.titleSmall.copyWith(
                              color: controller.isFollowing.value
                                  ? AppColors.subHeadingText
                                  : AppColors.primaryBlue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    // Chat Button
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          AppRouter.route.pushNamed(RoutePath.inboxScreen);
                        },
                        text: 'Chat',
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

            // ── Posts List or Empty State ──
            if (controller.userPosts.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No Post Available',
                    style: context.titleMedium.copyWith(
                      color: AppColors.hintTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )
            else
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
      ),
    );
  }
}
