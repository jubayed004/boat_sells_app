import 'package:boat_sells_app/features/followers/controller/followers_controller.dart';
import 'package:boat_sells_app/features/followers/model/follower_model.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// ───── User List ──────────────────────────────────────────────────────────────

class UserList extends StatelessWidget {
  final List<FollowerModel> items;
  const UserList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No users found',
          style: TextStyle(fontSize: 14.sp, color: AppColors.subHeadingText),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
      itemBuilder: (_, i) => UserRow(item: items[i]),
    );
  }
}

// ───── User Row ───────────────────────────────────────────────────────────────

class UserRow extends StatelessWidget {
  final FollowerModel item;
  const UserRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FollowersController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 26.r,
            backgroundColor: AppColors.iconBg,
            backgroundImage: item.avatarUrl != null
                ? NetworkImage(item.avatarUrl!)
                : null,
            child: item.avatarUrl == null
                ? Icon(
                    Icons.person,
                    color: AppColors.subHeadingText,
                    size: 26.sp,
                  )
                : null,
          ),
          Gap(12.w),

          // Name
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.headingText,
              ),
            ),
          ),

          // Action button
          item.needsFollowBack
              ? Obx(
                  () => FollowBackButton(
                    followed: controller.isFollowedBack(item.id),
                    onTap: () => controller.toggleFollowBack(item.id),
                  ),
                )
              : const MessageButton(),
        ],
      ),
    );
  }
}

// ───── Message Button ─────────────────────────────────────────────────────────

class MessageButton extends StatelessWidget {
  const MessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.sectionBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        'Message',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.subHeadingText,
        ),
      ),
    );
  }
}

// ───── Follow Back Button ─────────────────────────────────────────────────────

class FollowBackButton extends StatelessWidget {
  final bool followed;
  final VoidCallback onTap;
  const FollowBackButton({
    super.key,
    required this.followed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: followed ? AppColors.white : AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primaryBlue),
        ),
        child: Text(
          followed ? 'Following' : 'Follow Back',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: followed ? AppColors.primaryBlue : Colors.white,
          ),
        ),
      ),
    );
  }
}
