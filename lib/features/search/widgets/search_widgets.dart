import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Search photo grid item (kept for potential photo-grid view, currently unused)
// ──────────────────────────────────────────────────────────────────────────────
class SearchPhotoGridItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const SearchPhotoGridItem({super.key, required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CustomNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Filter Bottom Sheet
// ──────────────────────────────────────────────────────────────────────────────

/// Called when the user taps "Apply Filter".
/// [boatType]  – selected type ('All' means no filter)
/// [minPrice]  – min price as string (empty = no filter)
/// [maxPrice]  – max price as string (empty = no filter)
typedef OnFilterApplied = void Function({
  required String boatType,
  required String minPrice,
  required String maxPrice,
});

class SearchFilterBottomSheet extends StatefulWidget {
  final String initialBoatType;
  final double initialMinPrice;
  final double initialMaxPrice;
  final OnFilterApplied onApply;

  const SearchFilterBottomSheet({
    super.key,
    this.initialBoatType = 'All',
    this.initialMinPrice = 0,
    this.initialMaxPrice = 500000,
    required this.onApply,
  });

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  late String _selectedBoatType;
  late RangeValues _priceRange;

  final List<String> _boatTypes = [
    'All',
    'Sailboat',
    'Motorboat',
    'Yacht',
    'Ferry',
    'Speedboat',
    'Sail', 'Motor', 'Speed', 'Fishing', 'Yacht'
  ];

  @override
  void initState() {
    super.initState();
    _selectedBoatType = widget.initialBoatType;
    _priceRange = RangeValues(widget.initialMinPrice, widget.initialMaxPrice);
  }

  String _formatPrice(double value) {
    return value
        .toInt()
        .toString()
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');
  }

  void _applyFilter() {
    final isAllType = _selectedBoatType == 'All';
    final isFullRange =
        _priceRange.start == 0 && _priceRange.end == 500000;

    widget.onApply(
      boatType: isAllType ? '' : _selectedBoatType,
      minPrice: isFullRange ? '' : _priceRange.start.toInt().toString(),
      maxPrice: isFullRange ? '' : _priceRange.end.toInt().toString(),
    );
    Navigator.pop(context);
  }

  void _resetFilter() {
    setState(() {
      _selectedBoatType = 'All';
      _priceRange = const RangeValues(0, 500000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle bar ──────────────────────────────────────────────────
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // ── Header ──────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.headingText,
                ),
              ),
              GestureDetector(
                onTap: _resetFilter,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // ── Boat Type ───────────────────────────────────────────────────
          Text(
            'Boat Type',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.headingText,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _boatTypes.map((type) {
              final isSelected = _selectedBoatType == type;
              return GestureDetector(
                onTap: () => setState(() => _selectedBoatType = type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.sectionBg,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.borderColor,
                    ),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : AppColors.subHeadingText,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),

          // ── Price Range ─────────────────────────────────────────────────
          Text(
            'Price Range',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.headingText,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_formatPrice(_priceRange.start)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.subHeadingText,
                ),
              ),
              Text(
                '\$${_formatPrice(_priceRange.end)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.subHeadingText,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primaryBlue,
              thumbColor: AppColors.primaryBlue,
              overlayColor: AppColors.primaryBlue.withValues(alpha: 0.12),
              inactiveTrackColor: AppColors.borderColor,
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
              ),
            ),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 500000,
              divisions: 100,
              onChanged: (v) => setState(() => _priceRange = v),
            ),
          ),
          SizedBox(height: 20.h),

          // ── Apply button ────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _applyFilter,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Apply Filter',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
