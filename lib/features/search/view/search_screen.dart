import 'package:boat_sells_app/features/search/widgets/search_widgets.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample boat image URLs for the grid (2-column staggered layout)
  final List<String> _boatImages = [
    'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=400',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
    'https://images.unsplash.com/photo-1527004013197-933b96a5bbbd?w=400',
    'https://images.unsplash.com/photo-1605281317010-fe5ffe798166?w=400',
    'https://images.unsplash.com/photo-1580177347030-16dc51e3a0a3?w=400',
    'https://images.unsplash.com/photo-1593351415075-3bac9f45c877?w=400',
    'https://images.unsplash.com/photo-1520591913582-500e90c78c78?w=400',
    'https://images.unsplash.com/photo-1534430480872-3498386e7856?w=400',
    'https://images.unsplash.com/photo-1611527663827-c9e19aabea80?w=400',
    'https://images.unsplash.com/photo-1559494007-9f5847c49d94?w=400',
    'https://images.unsplash.com/photo-1502680390469-be75c86b636f?w=400',
    'https://images.unsplash.com/photo-1575843902781-a5c4bce6d80e?w=400',
  ];

  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_boatImages);
    _searchController.addListener(_onSearch);
  }

  void _onSearch() => setState(() {});

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearch)
      ..dispose();
    super.dispose();
  }

  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchFilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Search Bar ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  // Search field
                  Expanded(
                    child: Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: AppColors.sectionBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.headingText,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Find Your Boat',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.hintTextColor,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: AppColors.hintTextColor,
                            size: 20.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Filter button
                  GestureDetector(
                    onTap: _openFilter,
                    child: Container(
                      width: 46.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: AppColors.sectionBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: AppColors.headingText,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Photo Grid ────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 60.sp,
                            color: AppColors.hintTextColor,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No results found',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.subHeadingText,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 16.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.h,
                          crossAxisSpacing: 8.w,
                          // Alternate tile heights for the staggered look
                          childAspectRatio: 0.75,
                        ),
                        itemCount: _filtered.length,
                        itemBuilder: (context, index) {
                          return SearchPhotoGridItem(
                            imageUrl: _filtered[index],
                            onTap: () {},
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
