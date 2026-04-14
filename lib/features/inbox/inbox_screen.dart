import 'dart:io';

import 'package:boat_sells_app/core/service/datasource/remote/socket_service.dart';
import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/inbox/controller/inbox_controller.dart';
import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/features/inbox/widgets/chat_bubble.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InboxScreen extends StatefulWidget {
  /// The conversation that was tapped in ChatScreen, passed via route extra.
  /// Or the user id from the other profile screen.
  final String? userId;
  final ChatItem? chatItem;

  const InboxScreen({super.key, this.chatItem, this.userId});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late final InboxController controller;
  late final PagingController<int, InboxMessageDatum> pagingController;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(InboxController());

    // Seed header (avatar / name) from the passed ChatItem or userId.
    controller.initWith(
      chatItem: widget.chatItem,
      overrideUserId: widget.userId,
    );

    pagingController = PagingController<int, InboxMessageDatum>(
      firstPageKey: 1,
    );
    pagingController.addPageRequestListener((pageKey) {
      if (widget.chatItem?.id != null && widget.chatItem!.id!.isNotEmpty) {
        controller.getChatList(
          pageKey: pageKey,
          id: widget.chatItem!.id!,
          pagingController: pagingController,
        );
      } else {
        // If there's no conversation ID yet (new chat), just append empty page
        pagingController.appendLastPage([]);
      }
    });

    _setupSocketListeners();
    controller.markAsRead();

    messageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (messageController.text.isNotEmpty) {
      if (!controller.isTyping.value) controller.emitTyping();
    } else {
      controller.emitStopTyping();
    }
  }

  Future<void> _setupSocketListeners() async {
    await SocketApi.init();
    controller.listenForNewMessages(
      pagingController: pagingController,
    );
  }

  @override
  void dispose() {
    messageController.removeListener(_onTextChanged);
    messageController.dispose();
    pagingController.dispose();
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
        title: Obx(
          () => Row(
            children: [
              CustomNetworkImage(
                imageUrl: controller.avatarUrl.value,
                height: 36.r,
                width: 36.r,
                boxShape: BoxShape.circle,
                backgroundColor: AppColors.borderColor,
                errorWidget: Icon(
                  Icons.person,
                  color: AppColors.subHeadingText,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.userName.value,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColors.headingText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (controller.isTyping.value)
                      Text(
                        'typing...',
                        style: context.bodySmall.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.primaryBlue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Messages List ──
          Expanded(
            child: Obx(() {
              final currentUserId = controller.userId.value;
              return PagedListView<int, InboxMessageDatum>(
                reverse: true, // newest messages appear at the bottom
                pagingController: pagingController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                builderDelegate: PagedChildBuilderDelegate<InboxMessageDatum>(
                  itemBuilder: (context, message, index) => ChatBubble(
                    message: message,
                    currentUserId: currentUserId,
                  ),
                  firstPageProgressIndicatorBuilder:
                      (_) => const Center(child: CircularProgressIndicator()),
                  noItemsFoundIndicatorBuilder:
                      (_) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 80.h),
                          child: Text(
                            'No messages yet.\nSay hello! 👋',
                            textAlign: TextAlign.center,
                            style: context.bodyMedium.copyWith(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ),
                ),
              );
            }),
          ),

          // ── Selected Images Preview ──
          Obx(() {
            if (controller.selectedImages.isEmpty) {
              return const SizedBox.shrink();
            }
            return Container(
              height: 80.h,
              color: AppColors.scaffoldBg,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                itemCount: controller.selectedImages.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final file = controller.selectedImages[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          File(file.path),
                          height: 64.h,
                          width: 64.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),

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
                // Text field + image picker
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 48.h),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBg,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            maxLines: null,
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
                        IconButton(
                          onPressed: controller.pickImage,
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
                Obx(
                  () => GestureDetector(
                    onTap:
                        controller.callMessageSend.value
                            ? null
                            : () => controller.sendMessage(
                              context: context,
                              messageController: messageController,
                            ),
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      decoration: BoxDecoration(
                        color:
                            controller.callMessageSend.value
                                ? AppColors.hintTextColor
                                : AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child:
                          controller.callMessageSend.value
                              ? Padding(
                                padding: EdgeInsets.all(12.r),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Icon(
                                Icons.send_rounded,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
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
