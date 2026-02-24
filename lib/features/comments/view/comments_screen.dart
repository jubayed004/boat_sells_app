import 'package:boat_sells_app/features/comments/controller/comments_controller.dart';
import 'package:boat_sells_app/features/comments/widgets/comment_item.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  final controller = Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    // Inject the controller

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,

        title: Text(
          'Comments',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.subHeadingText,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Comments List ──
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.dummyComments.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                return CommentItem(comment: controller.dummyComments[index]);
              },
            ),
          ),

          // ── Bottom Input Field ──
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBg,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Comment',
                        hintStyle: context.bodyMedium.copyWith(
                          color: AppColors.hintTextColor,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 14.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: AppColors.white,
                      size: 22.sp,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
