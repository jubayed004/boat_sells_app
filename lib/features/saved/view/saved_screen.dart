import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/saved/controller/saved_controller.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_shimmer_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedController controller = Get.put(SavedController());

  @override
  void dispose() {
    Get.delete<SavedController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: RefreshIndicator(
        onRefresh: () async => controller.pagingController.refresh(),
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──────────────────────────────────────────────
            SliverAppBar(
              pinned: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              scrolledUnderElevation: 0,
              foregroundColor: Colors.transparent,
              title: Text(
                'Saved',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingText,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.h),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.borderColor,
                ),
              ),
            ),
        
            // ── Top spacing ──────────────────────────────────────────
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        
            // ── Boat cards list ──────────────────────────────────────
            PagedSliverList<int, BoatItem>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<BoatItem>(
                itemBuilder: (context, boat, index) => BoatListingCard(
                  boat: boat,
                  onCardTap: () =>
                      AppRouter.route.pushNamed(RoutePath.detailsPostScreen),
                  onCommentTap: () =>
                      AppRouter.route.pushNamed(RoutePath.commentsScreen, extra: boat.id),
                  imageOnTap: () =>
                      AppRouter.route.pushNamed(RoutePath.otherProfileScreen),
                  onUnsaved: () => controller.removeSaved(boat.id ?? ''),
                ),
                firstPageProgressIndicatorBuilder: (_) => Column(
                  children: List.generate(
                    3,
                    (_) => const BoatListingShimmerCard(),
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) => NoDataCard(
                  onTap: () => controller.pagingController.refresh(),
                  title: 'No Saved Listings',
                  subtitle: 'Bookmark boats you love and they will appear here.',
                  icon: Icons.bookmark_border_rounded,
                  iconColor: AppColors.primaryBlue,
                ),
              ),
            ),
        
            // ── Bottom padding ───────────────────────────────────────
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      ),
    );
  }
}
