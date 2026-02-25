import 'package:boat_sells_app/features/notification/widgets/notification_tile.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static final List<Map<String, dynamic>> _sections = [
    {
      'label': 'Today',
      'items': const [
        NotificationItem(
          name: 'Darrell Steward',
          action: 'Like Your Post',
          time: '2h',
        ),
        NotificationItem(
          name: 'Jenny Wilson',
          action: 'Comment Your Post',
          time: '2h',
        ),
        NotificationItem(
          name: 'Cameron Williamson',
          action: 'Comment Your Post',
          time: '2h',
        ),
      ],
    },
    {
      'label': 'Yesterday',
      'items': const [
        NotificationItem(
          name: 'Robert Fox',
          action: 'Like Your Post',
          time: '1d',
        ),
        NotificationItem(
          name: 'Leslie Alexander',
          action: 'Started Following You',
          time: '1d',
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.headingText),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.headingText,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: _sections.length,
        itemBuilder: (context, sectionIndex) {
          final section = _sections[sectionIndex];
          final items = section['items'] as List<NotificationItem>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Padding(
                padding: EdgeInsets.only(
                  top: sectionIndex == 0 ? 0 : 16.h,
                  bottom: 10.h,
                ),
                child: Text(
                  section['label'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headingText,
                  ),
                ),
              ),

              // Notification tiles
              ...items.map((item) => NotificationTile(item: item)),
            ],
          );
        },
      ),
    );
  }
}
