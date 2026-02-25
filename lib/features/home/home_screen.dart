import 'package:boat_sells_app/features/home/controller/home_controller.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/home/widgets/home_app_bar.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ---- App Bar ----
          const HomeAppBar(),

          // ---- Top spacing ----
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          // ---- Boat cards paginated list ----
          PagedSliverList<int, BoatModel>(
            pagingController: _homeController.pagingController,
            builderDelegate: PagedChildBuilderDelegate<BoatModel>(
              itemBuilder: (context, item, index) => BoatListingCard(
                boat: item,
                onCardTap: () =>
                    AppRouter.route.pushNamed(RoutePath.detailsPostScreen),
                onCommentTap: () =>
                    AppRouter.route.pushNamed(RoutePath.commentsScreen),
                imageOnTap: () {
                  print('image tapped');
                  AppRouter.route.pushNamed(RoutePath.otherProfileScreen);
                },
              ),
              firstPageProgressIndicatorBuilder: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
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
    );
  }
}
