import 'package:boat_sells_app/features/home/controller/home_controller.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_shimmer_card.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/home/widgets/home_app_bar.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () async => _homeController.pagingController.refresh(),
        child: CustomScrollView(
          
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ---- App Bar ----
            const HomeAppBar(),
        
            // ---- Top spacing ----
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        
            // ---- Boat cards paginated list ----
            PagedSliverList<int, BoatItem>(
              pagingController: _homeController.pagingController,
              builderDelegate: PagedChildBuilderDelegate<BoatItem>(
                itemBuilder: (context, item, index) => BoatListingCard(
                  boat: item,
                  onCardTap: () =>
                      AppRouter.route.pushNamed(RoutePath.detailsPostScreen,extra: item.id),
                  onCommentTap: () =>
                      AppRouter.route.pushNamed(RoutePath.commentsScreen,extra: item.id),
                  onShareTap: () {
                    SharePlus.instance.share(
                      ShareParams(
                        text: 'Check out this boat: ${item.displayTitle} for \$${item.price} on Boat Sells App!',
                      ),
                    );
                  },
                  imageOnTap: () {
                    AppRouter.route.pushNamed(RoutePath.otherProfileScreen);
                  },
                ),
                firstPageProgressIndicatorBuilder: (_) => Column(
                  children: List.generate(
                    3,
                    (index) => const BoatListingShimmerCard(),
                  ),
                ),
                newPageProgressIndicatorBuilder: (_) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
            ),
        
            // ---- Bottom padding ----
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      ),
    );
  }
}
