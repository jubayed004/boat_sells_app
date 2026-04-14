import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final InboxMessageDatum message;
  final String currentUserId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final isSent = message.sender?.id == currentUserId;
    final hasText = (message.text ?? '').isNotEmpty;
    final images = message.images ?? [];
    final hasImages = images.isNotEmpty;

    // If nothing to show, return empty
    if (!hasText && !hasImages) return const SizedBox.shrink();

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4.h,
          bottom: 4.h,
          left: isSent ? 60.w : 0,
          right: isSent ? 0 : 60.w,
        ),
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // ── Images ──────────────────────────────────────────────────────
            if (hasImages)
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                alignment: isSent ? WrapAlignment.end : WrapAlignment.start,
                children: images.map((url) => _ImageTile(url: url)).toList(),
              ),

            if (hasImages && hasText) SizedBox(height: 4.h),

            // ── Text bubble ──────────────────────────────────────────────────
            if (hasText)
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSent
                      ? AppColors.primaryBlue
                      : const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(isSent ? 16.r : 4.r),
                    bottomRight: Radius.circular(isSent ? 4.r : 16.r),
                  ),
                ),
                child: Text(
                  message.text!,
                  style: context.bodySmall.copyWith(
                    fontSize: 13.sp,
                    color: isSent ? AppColors.white : AppColors.headingText,
                    height: 1.4,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A single image tile inside a chat bubble.
class _ImageTile extends StatelessWidget {
  final String url;
  const _ImageTile({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CustomNetworkImage(
        imageUrl: url,
        height: 180.h,
        width: 180.w,
        fit: BoxFit.cover,
        backgroundColor: AppColors.borderColor,
        errorWidget: Container(
          height: 180.h,
          width: 180.w,
          color: AppColors.borderColor,
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColors.hintTextColor,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}
