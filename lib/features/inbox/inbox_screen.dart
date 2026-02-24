import 'package:boat_sells_app/features/inbox/controller/inbox_controller.dart';
import 'package:boat_sells_app/features/inbox/widgets/chat_bubble.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final InboxController controller = Get.put(InboxController());
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    Get.delete<InboxController>();
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
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.borderColor,
              backgroundImage: NetworkImage(controller.avatarUrl),
            ),
            SizedBox(width: 10.w),
            Text(
              controller.userName,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
                color: AppColors.headingText,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ── Messages ──
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: controller.messages[index]);
              },
            ),
          ),

          // ── Input Bar ──
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 28.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Text field
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBg,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Type Something ...',
                              hintStyle: context.bodyMedium.copyWith(
                                color: AppColors.hintTextColor,
                                fontSize: 13.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                        // Image picker icon
                        IconButton(
                          onPressed: () {
                            // TODO: integrate image_picker on integration phase
                          },
                          icon: Icon(
                            Icons.image_outlined,
                            color: AppColors.hintTextColor,
                            size: 22.sp,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 36.w,
                            minHeight: 36.h,
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // Send button
                Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: integrate send message on integration phase
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
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
