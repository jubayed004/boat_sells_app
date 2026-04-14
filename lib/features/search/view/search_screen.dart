import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/search/controller/search_controller.dart';
import 'package:boat_sells_app/features/search/model/search_model.dart'
    as search_model;
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/features/search/widgets/search_widgets.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_shimmer_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/error_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/more_data_error_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchController _searchCtrl;
  final TextEditingController _textCtrl = TextEditingController();
  final ValueNotifier<bool> _hasText = ValueNotifier(false);

  // Track last applied filter values for restoring bottom sheet state
  String _lastBoatType = 'All';
  double _lastMinPrice = 0;
  double _lastMaxPrice = 500000;

  @override
  void initState() {
    super.initState();
    _searchCtrl = Get.find<SearchController>();
    // Sync text field if search text was already set (e.g. tab switch)
    _textCtrl.text = _searchCtrl.searchText.value;
    _textCtrl.addListener(() {
      _hasText.value = _textCtrl.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _hasText.dispose();
    super.dispose();
  }

  // ── Convert SearchItem → BoatItem for BoatListingCard ─────────────────
  BoatItem _toBoatItem(search_model.SearchItem s) {
    String finalId = s.user?.id ?? '';
    String finalName = s.user?.name ?? '';
    String finalAvatarUrl = s.user?.avatarUrl ?? '';
    
    // Inject current user profile if the ID matches or if backend returned empty user for the current user
    if (Get.isRegistered<ProfileController>()) {
      final profileData = Get.find<ProfileController>().profile.value.data;
      if (profileData != null && s.user != null) {
        if (s.user!.id == profileData.id) {
          finalName = finalName.isEmpty ? (profileData.name ?? '') : finalName;
          finalAvatarUrl = finalAvatarUrl.isEmpty ? (profileData.avatarUrl ?? '') : finalAvatarUrl;
        }
      }
    }

    return BoatItem(
      id: s.id,
      user: s.user == null
          ? null
          : User(
              id: finalId,
              name: finalName,
              avatarUrl: finalAvatarUrl,
            ),
      location: s.location,
      price: s.price,
      displayTitle: s.displayTitle,
      media: s.media
          ?.map((m) => Media(url: m.url, type: m.type, order: m.order))
          .toList(),
      likesCount: s.likesCount,
      commentsCount: s.commentsCount,
      shareCount: s.shareCount,
      isLiked: s.isLiked,
      isSaved: s.isSaved,
      createdAt: s.createdAt,
    );
  }

  // ── Open filter bottom sheet ───────────────────────────────────────────
  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SearchFilterBottomSheet(
          initialBoatType: _lastBoatType,
          initialMinPrice: _lastMinPrice,
          initialMaxPrice: _lastMaxPrice,
          onApply: ({
            required String boatType,
            required String minPrice,
            required String maxPrice,
          }) {
            // Persist UI state
            setState(() {
              _lastBoatType = boatType.isEmpty ? 'All' : boatType;
              _lastMinPrice =
                  minPrice.isEmpty ? 0 : double.tryParse(minPrice) ?? 0;
              _lastMaxPrice =
                  maxPrice.isEmpty ? 500000 : double.tryParse(maxPrice) ?? 500000;
            });
            _searchCtrl.applyFilters(
              selectedBoatType: boatType,
              selectedMinPrice: minPrice,
              selectedMaxPrice: maxPrice,
            );
          },
        ),
      ),
    );
  }

  // ── Filter badge dot indicator ─────────────────────────────────────────
  bool get _hasActiveFilters => _searchCtrl.hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryBlue,
          onRefresh: () async => _searchCtrl.pagingController.refresh(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // ── Search bar ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
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
                            controller: _textCtrl,
                            onChanged: _searchCtrl.onSearchChanged,
                            textInputAction: TextInputAction.search,
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
                              suffixIcon: ValueListenableBuilder<bool>(
                                valueListenable: _hasText,
                                builder: (context, hasText, child) => hasText
                                    ? GestureDetector(
                                        onTap: () {
                                          _textCtrl.clear();
                                          _searchCtrl.onSearchChanged('');
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: AppColors.hintTextColor,
                                          size: 18.sp,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12.h),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      // Filter button with active badge
                      Obx(
                        () => GestureDetector(
                          onTap: _openFilter,
                          child: Stack(
                            children: [
                              Container(
                                width: 46.w,
                                height: 46.h,
                                decoration: BoxDecoration(
                                  color: _hasActiveFilters
                                      ? AppColors.primaryBlue
                                            .withValues(alpha: 0.12)
                                      : AppColors.sectionBg,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: _hasActiveFilters
                                        ? AppColors.primaryBlue
                                        : AppColors.borderColor,
                                  ),
                                ),
                                child: Icon(
                                  Icons.tune_rounded,
                                  color: _hasActiveFilters
                                      ? AppColors.primaryBlue
                                      : AppColors.headingText,
                                  size: 22.sp,
                                ),
                              ),
                              if (_hasActiveFilters)
                                Positioned(
                                  top: 5.h,
                                  right: 5.w,
                                  child: Container(
                                    width: 8.r,
                                    height: 8.r,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Active filter chips ────────────────────────────────────
              Obx(
                () => _searchCtrl.hasActiveFilters
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 8.h,
                          ),
                          child: Wrap(
                            spacing: 8.w,
                            runSpacing: 4.h,
                            children: [
                              if (_searchCtrl.boatType.value.isNotEmpty)
                                _FilterChip(
                                  label: _searchCtrl.boatType.value,
                                  onRemove: () => _searchCtrl.applyFilters(
                                    selectedBoatType: '',
                                    selectedMinPrice:
                                        _searchCtrl.minPrice.value,
                                    selectedMaxPrice:
                                        _searchCtrl.maxPrice.value,
                                  ),
                                ),
                              if (_searchCtrl.minPrice.value.isNotEmpty ||
                                  _searchCtrl.maxPrice.value.isNotEmpty)
                                _FilterChip(
                                  label:
                                      '\$${_searchCtrl.minPrice.value.isEmpty ? '0' : _searchCtrl.minPrice.value}'
                                      ' – '
                                      '\$${_searchCtrl.maxPrice.value.isEmpty ? '500,000' : _searchCtrl.maxPrice.value}',
                                  onRemove: () => _searchCtrl.applyFilters(
                                    selectedBoatType:
                                        _searchCtrl.boatType.value,
                                    selectedMinPrice: '',
                                    selectedMaxPrice: '',
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),

              // ── Paged list ─────────────────────────────────────────────
              PagedSliverList<int, search_model.SearchItem>(
                pagingController: _searchCtrl.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<search_model.SearchItem>(
                  // ── Each card ──────────────────────────────────────────
                  itemBuilder: (context, item, index) {
                    final boat = _toBoatItem(item);
                    return BoatListingCard(
                      boat: boat,
                      onCardTap: () => AppRouter.route.pushNamed(
                        RoutePath.detailsPostScreen,
                        extra: item.id,
                      ),
                      onCommentTap: () => AppRouter.route.pushNamed(
                        RoutePath.commentsScreen,
                        extra: item.id,
                      ),
                      onShareTap: () {
                        SharePlus.instance.share(
                          ShareParams(
                            text:
                                'Check out this boat: ${item.displayTitle} for \$${item.price} on Boat Sells App!',
                          ),
                        );
                      },
                      imageOnTap: () => AppRouter.route
                          .pushNamed(RoutePath.otherProfileScreen,extra: item.user?.id),
                    );
                  },

                  // ── First-page loading shimmer ─────────────────────────
                  firstPageProgressIndicatorBuilder: (_) => Column(
                    children: List.generate(
                      3,
                      (_) => const BoatListingShimmerCard(),
                    ),
                  ),

                  // ── First-page error (network / server error) ──────────
                  firstPageErrorIndicatorBuilder: (_) => ErrorCard(
                    onTap: () =>
                        _searchCtrl.pagingController.refresh(),
                    title: 'Something went wrong',
                    message: _searchCtrl.pagingController.error?.toString() ??
                        'Could not load boats. Please try again.',
                  ),

                  // ── Empty state ────────────────────────────────────────
                  noItemsFoundIndicatorBuilder: (_) => NoDataCard(
                    onTap: () =>
                        _searchCtrl.pagingController.refresh(),
                    title: 'No Boats Found',
                    subtitle: 'Try adjusting your search or filter.',
                    icon: Icons.directions_boat_outlined,
                  ),

                  // ── Next-page loading indicator ────────────────────────
                  newPageProgressIndicatorBuilder: (_) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),

                  // ── Next-page error (inline row) ───────────────────────
                  newPageErrorIndicatorBuilder: (_) => MoreDataErrorCard(
                    onTap: () =>
                        _searchCtrl.pagingController.retryLastFailedRequest(),
                    message: 'Failed to load more. Tap to retry.',
                  ),
                ),
              ),

              // ── Bottom padding ─────────────────────────────────────────
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Small dismissible filter chip ─────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _FilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlue,
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close_rounded,
              size: 14.sp,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
