import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/chat/controller/chat_controller.dart';
import 'package:boat_sells_app/features/chat/widgets/chat_tile.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: context.bodyMedium.copyWith(
                      color: AppColors.hintTextColor,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.hintTextColor,
                      size: 20.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                  ),
                ),
              ),
            ),

            // ── Inbox List ──
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.dummyChatList.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.dividerColor,
                  indent: 74.w,
                  endIndent: 20.w,
                ),
                itemBuilder: (context, index) {
                  return ChatTile(
                    chat: controller.dummyChatList[index],
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.inboxScreen);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
