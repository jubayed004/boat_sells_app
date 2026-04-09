import 'package:boat_sells_app/features/home/controller/home_controller.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
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
  final _profileController = Get.find<ProfileController>();

  /// The backend might return empty strings for the logged-in user object. 
  /// Patch them with the current profile data.
  BoatItem _patchBoatUser(BoatItem boat) {
    if (!Get.isRegistered<ProfileController>()) return boat;
    final profileData = _profileController.profile.value.data;
    if (profileData == null) return boat;

    final currentUser = boat.user;
    
    // Only patch if it's the current user's post OR backend sent completely empty user
    // Since we only have the current user's profile, we can only safely patch if IDs match 
    // or if the ID is also empty (which shouldn't happen, but just in case).
    if (currentUser != null && 
        currentUser.id != null && 
        currentUser.id != profileData.id) {
          return boat;
    }

    final needsPatch =
        (currentUser?.name?.isEmpty ?? true) ||
        (currentUser?.avatarUrl?.isEmpty ?? true);

    if (!needsPatch) return boat;

    return BoatItem(
      id: boat.id,
      user: User(
        id: currentUser?.id ?? profileData.id,
        name: currentUser?.name?.isNotEmpty == true
            ? currentUser!.name
            : profileData.name,
        avatarUrl: currentUser?.avatarUrl?.isNotEmpty == true
            ? currentUser!.avatarUrl
            : profileData.avatarUrl,
      ),
      location: boat.location,
      price: boat.price,
      displayTitle: boat.displayTitle,
      media: boat.media,
      likesCount: boat.likesCount,
      commentsCount: boat.commentsCount,
      shareCount: boat.shareCount,
      isLiked: boat.isLiked,
      isSaved: boat.isSaved,
      createdAt: boat.createdAt,
    );
  }

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
                itemBuilder: (context, item, index) {
                  final patchedItem = _patchBoatUser(item);
                  return BoatListingCard(
                    boat: patchedItem,
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
                  );
                },
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
