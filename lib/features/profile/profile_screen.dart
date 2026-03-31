import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.find<ProfileController>();

  Future<void> _launchUrl(dynamic urlData) async {
    if (urlData == null || urlData.toString().isEmpty || urlData.toString() == 'null') {
      AppToast.error(message: 'Link not available');
      return;
    }
    String urlString = urlData.toString();
    if (!urlString.startsWith('http')) {
      urlString = 'https://$urlString';
    }
    final url = Uri.tryParse(urlString);
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      AppToast.error(message: 'Could not open link: $urlString');
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getProfile();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getProfile();
          controller.pagingController.refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ── Profile Head (Avatar and Stats) ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Obx(
                  () => Row(
                    children: [
                      // Avatar
                      CustomNetworkImage(
                        imageUrl:
                            controller.profile.value.data?.avatarUrl ?? '',
                        borderRadius: BorderRadius.circular(38.r),
                        width: 70.w,
                        height: 70.h,
                      ),
                      SizedBox(width: 20.w),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              controller.profile.value.data?.name ?? 'Unknown',
                              style: context.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: AppColors.headingText,
                              ),
                            ),
                            Gap(5.h),
                            Text(
                              controller.profile.value.data?.phone ?? "N/A",
                              style: context.bodyMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.headingText,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            // Stats Row
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     _StatItem(
                            //       value: '${controller.postCount}',
                            //       label: 'Posts',
                            //       onTap: () {},
                            //     ),
                            //     // _StatItem(
                            //     //   value: '${controller.followersCount}',
                            //     //   label: 'Followers',
                            //     //   onTap: () {
                            //     //     AppRouter.route.pushNamed(
                            //     //       RoutePath.followersScreen,
                            //     //     );
                            //     //   },
                            //     // ),
                            //     // _StatItem(
                            //     //   value: '${controller.followingCount}',
                            //     //   label: 'Following',
                            //     //   onTap: () {
                            //     //     AppRouter.route.pushNamed(
                            //     //       RoutePath.followersScreen,
                            //     //     );
                            //     //   },
                            //     // ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bio ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Obx(
                  () => Text(
                    controller.profile.value.data?.bio ?? 'No bio available',
                    style: context.bodySmall.copyWith(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: AppColors.headingText,
                    ),
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
                    _SocialCircle(
                      label: 'FB',
                      onTap: () => _launchUrl(controller.profile.value.data?.socialLinks?.facebook),
                    ),
                    SizedBox(width: 8.w),
                    _SocialCircle(
                      label: 'IN',
                      onTap: () => _launchUrl(controller.profile.value.data?.socialLinks?.instagram),
                    ),
                    SizedBox(width: 8.w),
                    _SocialCircle(
                      label: 'X',
                      onTap: () => _launchUrl(controller.profile.value.data?.socialLinks?.twitter),
                    ),

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
            PagedSliverList<int, BoatItem>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<BoatItem>(
                itemBuilder: (context, boat, index) => BoatListingCard(
                  boat: boat,
                  onCardTap: () =>
                      AppRouter.route.pushNamed(RoutePath.detailsPostScreen),
                  onCommentTap: () =>
                      AppRouter.route.pushNamed(RoutePath.commentsScreen),
                  onShareTap: () {
                    SharePlus.instance.share(
                      ShareParams(
                        text:
                            'Check out this boat: ${boat.displayTitle} for \$${boat.price} on Boat Sells App!',
                      ),
                    );
                  },
                ),
                firstPageProgressIndicatorBuilder: (_) => const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                noItemsFoundIndicatorBuilder: (_) => Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: NoDataCard(
                    onTap: () => controller.pagingController.refresh(),
                    title: 'No Posts Yet',
                    subtitle: 'There are no active posts available.',
                    icon: Icons.post_add_rounded,
                    iconColor: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Helper Widgets
// ─────────────────────────────────────────

// class _StatItem extends StatelessWidget {
//   final String value;
//   final String label;
//   final VoidCallback onTap;
//   const _StatItem({
//     required this.value,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             value,
//             style: context.titleSmall.copyWith(
//               fontWeight: FontWeight.w700,
//               fontSize: 14.sp,
//               color: AppColors.headingText,
//             ),
//           ),
//           SizedBox(height: 2.h),
//           Text(
//             label,
//             style: context.bodySmall.copyWith(
//               fontSize: 12.sp,
//               color: AppColors.headingText,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
