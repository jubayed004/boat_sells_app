import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTile extends StatelessWidget {
  final ChatItem chat;
  final VoidCallback? onTap;

  const ChatTile({super.key, required this.chat, this.onTap});

  String get _avatarUrl {
    return chat.participants?.lastOrNull?.image?.toString() ?? '';
  }

  String get _userName {
    return chat.participants?.lastOrNull?.name ?? 'Unknown';
  }

  String get _lastMessage {
    final text = chat.lastMessage?.text;
    if (text != null && text.isNotEmpty) return text;
    if (chat.lastMessage?.images != null && chat.lastMessage!.images!.isNotEmpty) return 'Sent an image';
    return '';
  }

  String get _time {
    final dateTime = chat.lastMessage?.createdAt?.toLocal();
    if (dateTime != null) {
      final hour = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
      final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:${dateTime.minute.toString().padLeft(2, '0')} $amPm';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          children: [
            // Avatar
            CustomNetworkImage(
              imageUrl: _avatarUrl,
              height: 52.r,
              width: 52.r,
              boxShape: BoxShape.circle,
              backgroundColor: AppColors.borderColor,
              errorWidget: Icon(
                Icons.person,
                color: AppColors.subHeadingText,
                size: 26.sp,
              ),
            ),
            SizedBox(width: 14.w),

            // Name & Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.headingText,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    _lastMessage,
                    style: context.bodySmall.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.hintTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time
            Text(
              _time,
              style: context.bodySmall.copyWith(
                fontSize: 11.sp,
                color: AppColors.hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
