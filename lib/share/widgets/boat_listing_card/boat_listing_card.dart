import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/common_controller/common_controller.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BoatListingCard extends StatefulWidget {
  final BoatItem boat;

  /// Called when the info section (title/price) is tapped
  final VoidCallback? onCardTap;

  /// Called when the comment icon is tapped
  final VoidCallback? onCommentTap;

  /// Called when the share icon is tapped (e.g. to open share sheet)
  final VoidCallback? onShareTap;

  /// Called when the image is tapped
  final VoidCallback? imageOnTap;

  /// Called when the user removes the bookmark (unsaves)
  final VoidCallback? onUnsaved;

  const BoatListingCard({
    super.key,
    required this.boat,
    this.onCardTap,
    this.onCommentTap,
    this.onShareTap,
    this.imageOnTap,
    this.onUnsaved,
  });

  @override
  State<BoatListingCard> createState() => _BoatListingCardState();
}

class _BoatListingCardState extends State<BoatListingCard> {
  late final ValueNotifier<bool> _isSaved;
  late final ValueNotifier<bool> _isLiked;
  late final PageController _pageController;
  int _currentPage = 0;

  final _commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    _isSaved = ValueNotifier(widget.boat.isSaved ?? false);
    _isLiked = ValueNotifier(widget.boat.isLiked ?? false);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _isSaved.dispose();
    _isLiked.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _openImageDialog(int initialIndex) {
    final currentMedia = widget.boat.media;
    if (currentMedia == null || currentMedia.isEmpty) return;
    final item = currentMedia[initialIndex];
    if (item.type == 'video') return; // don't open dialog for video
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _ImageCarouselDialog(
        images: currentMedia
            .where((m) => m.type != 'video')
            .map((m) => m.url ?? '')
            .where((u) => u.isNotEmpty)
            .toList(),
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaItems = widget.boat.media ?? [];

    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 0, 14.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================== IMAGE/VIDEO SECTION =====================
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Stack(
              children: [
                // ── Carousel PageView ──
                SizedBox(
                  height: 210.h,
                  child: mediaItems.isEmpty
                      ? Container(
                          color: AppColors.borderColor,
                          child: Icon(Icons.directions_boat, size: 48.sp, color: AppColors.hintTextColor),
                        )
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: mediaItems.length,
                          onPageChanged: (i) => setState(() => _currentPage = i),
                          itemBuilder: (_, i) {
                            final item = mediaItems[i];
                            if (item.type == 'video') {
                              return _VideoPlayerItem(videoUrl: item.url ?? '');
                            }
                            return GestureDetector(
                              onTap: () => _openImageDialog(i),
                              child: CustomNetworkImage(
                                imageUrl: item.url ?? '',
                                height: 210.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                ),

                // ── Seller chip (top-left) ──
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: _SellerChip(
                    name: widget.boat.user?.name ?? '',
                    avatarUrl: widget.boat.user?.avatarUrl ?? '',
                    imageOnTap: widget.imageOnTap,
                  ),
                ),

                // ── Carousel dots (bottom-right) ──
                if (mediaItems.length > 1)
                  Positioned(
                    bottom: 10.h,
                    right: 10.w,
                    child: _CarouselDots(
                      total: mediaItems.length,
                      active: _currentPage,
                    ),
                  ),
              ],
            ),
          ),

          // ===================== INFO SECTION =====================
          GestureDetector(
            onTap: widget.onCardTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      widget.boat.displayTitle ?? '',
                      style: context.titleSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headingText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  // Location
                  Text(
                    widget.boat.location ?? '',
                    style: context.bodySmall.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.hintTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Price ──
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 10.h),
            child: Text(
              '\$ ${_formatPrice((widget.boat.price ?? 0).toDouble())}',
              style: context.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.priceGreen,
              ),
            ),
          ),

          // ── Divider ──
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.borderColor,
            indent: 14.w,
            endIndent: 14.w,
          ),

          // ===================== ACTIONS ROW =====================
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 12.h),
            child: Row(
              children: [
                // Like
                ValueListenableBuilder<bool>(
                  valueListenable: _isLiked,
                  builder: (context, isLiked, _) => _IconCountButton(
                    icon: isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    count: (widget.boat.likesCount ?? 0) + (isLiked ? 1 : 0) - ((widget.boat.isLiked ?? false) ? 1 : 0),
                    color: isLiked
                        ? AppColors.favoriteRed
                        : AppColors.subHeadingText,
                    onTap: () {
                      // Optimistic UI toggle
                      _isLiked.value = !_isLiked.value;
                      // Call API
                      _commonController.likePost(postId: widget.boat.id ?? '');
                    },
                  ),
                ),
                SizedBox(width: 18.w),
                // Comment
                _IconCountButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  count: widget.boat.commentsCount ?? 0,
                  color: AppColors.subHeadingText,
                  onTap: () => widget.onCommentTap?.call(),
                ),
                SizedBox(width: 18.w),
                // Share
                _IconCountButton(
                  icon: Icons.send_rounded,
                  count: widget.boat.shareCount ?? 0,
                  color: AppColors.subHeadingText,
                  onTap: () {
                    // Call share API to increment the count
                    _commonController.sharePost(postId: widget.boat.id ?? '');
                    // Then call the parent's share action (open share sheet)
                    widget.onShareTap?.call();
                  },
                ),
                const Spacer(),
                // Bookmark
                ValueListenableBuilder<bool>(
                  valueListenable: _isSaved,
                  builder: (context, isSaved, _) => GestureDetector(
                    onTap: () {
                      final willBeSaved = !_isSaved.value;
                      // Optimistic UI toggle
                      _isSaved.value = willBeSaved;
                      // Call save API
                      _commonController.savedPost(postId: widget.boat.id ?? '');
                      // Notify parent when user removes the bookmark
                      if (!willBeSaved) {
                        widget.onUnsaved?.call();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        key: ValueKey(isSaved),
                        size: 22.sp,
                        color: isSaved
                            ? AppColors.primaryBlue
                            : AppColors.subHeadingText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    final int whole = price.toInt();
    final String decimals = (price - whole).toStringAsFixed(2).substring(1);
    final String wholeFormatted = whole.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return '$wholeFormatted$decimals';
  }
}

// ─────────────────────────────────────────
//  Inline video player item
// ─────────────────────────────────────────
class _VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const _VideoPlayerItem({required this.videoUrl});

  @override
  State<_VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<_VideoPlayerItem> {
  VideoPlayerController? _ctrl; // nullable until cache + init is done

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  /// Downloads video to local cache on first play;
  /// subsequent plays use the cached file — no network hit.
  Future<void> _initVideo() async {
    try {
      // DefaultCacheManager caches the file on disk automatically.
      // cached_network_image already uses this same cache manager.
      final file = await DefaultCacheManager().getSingleFile(widget.videoUrl);
      final ctrl = VideoPlayerController.file(file);
      await ctrl.initialize();
      if (mounted) setState(() => _ctrl = ctrl); // only ONE setState, just to attach controller
    } catch (e) {
      debugPrint('Video cache/init error: $e');
    }
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── Still fetching/caching file ──
    if (_ctrl == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              SizedBox(height: 8),
              Text('Loading video...', style: TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (!_ctrl!.value.isInitialized) return;
        _ctrl!.value.isPlaying ? _ctrl!.pause() : _ctrl!.play();
        // No setState — ValueListenableBuilder handles all UI updates
      },
      child: Container(
        color: Colors.black,
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _ctrl!,
          builder: (_, value, __) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // ── Video ──
                AspectRatio(
                  aspectRatio: value.aspectRatio,
                  child: VideoPlayer(_ctrl!),
                ),

                // ── Buffering spinner ──
                if (value.isBuffering)
                  const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),

                // ── Play/pause overlay ──
                if (!value.isBuffering)
                  AnimatedOpacity(
                    opacity: value.isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                // ── VIDEO badge ──
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.videocam_rounded, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('VIDEO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Full-screen image carousel AlertDialog
// ─────────────────────────────────────────
class _ImageCarouselDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const _ImageCarouselDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_ImageCarouselDialog> createState() => _ImageCarouselDialogState();
}

class _ImageCarouselDialogState extends State<_ImageCarouselDialog> {
  late final PageController _ctrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header: dots + close ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: Row(
                  children: [
                    // dots
                    Expanded(
                      child: _CarouselDots(
                        total: widget.images.length,
                        active: _current,
                      ),
                    ),
                    // close button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── PageView of images ──
              SizedBox(
                height: 320.h,
                child: PageView.builder(
                  controller: _ctrl,
                  itemCount: widget.images.length,
                  onPageChanged: (i) => setState(() => _current = i),
                  itemBuilder: (_, i) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomNetworkImage(
                        imageUrl: widget.images[i],
                        height: 320.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Image counter label ──
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 14.h),
                child: Text(
                  '${_current + 1} / ${widget.images.length}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Seller chip
// ─────────────────────────────────────────
class _SellerChip extends StatefulWidget {
  final String name;
  final String avatarUrl;
  final VoidCallback? imageOnTap;
  const _SellerChip({
    required this.name,
    required this.avatarUrl,
    this.imageOnTap,
  });

  @override
  State<_SellerChip> createState() => _SellerChipState();
}

class _SellerChipState extends State<_SellerChip> {
  late final ValueNotifier<bool> _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = ValueNotifier(false);
  }

  @override
  void dispose() {
    _isFollowing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.imageOnTap,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 13.r,
                  backgroundColor: const Color(0xFFE8EFF4),
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
                SizedBox(width: 6.w),
                Text(
                  widget.name,
                  style: context.bodySmall.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headingText,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(width: 8.w),
          // ValueListenableBuilder<bool>(
          //   valueListenable: _isFollowing,
          //   builder: (context, isFollowing, _) => GestureDetector(
          //     onTap: () {
          //       _isFollowing.value = !_isFollowing.value;
          //     },
          //     child: AnimatedContainer(
          //       duration: const Duration(milliseconds: 200),
          //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          //       decoration: BoxDecoration(
          //         color: isFollowing ? AppColors.white : AppColors.primaryBlue,
          //         borderRadius: BorderRadius.circular(20.r),
          //         border: isFollowing
          //             ? Border.all(color: AppColors.primaryBlue)
          //             : Border.all(color: Colors.transparent),
          //       ),
          //       child: Text(
          //         isFollowing ? 'Following'.tr : 'Follow'.tr,
          //         style: context.labelSmall.copyWith(
          //           fontSize: 10.sp,
          //           fontWeight: FontWeight.w700,
          //           color: isFollowing ? AppColors.primaryBlue : Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Carousel dot indicators
// ─────────────────────────────────────────
class _CarouselDots extends StatelessWidget {
  final int total;
  final int active;
  const _CarouselDots({required this.total, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == active;
        return Container(
          margin: EdgeInsets.only(left: 4.w),
          width: isActive ? 16.w : 6.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────
//  Icon + count action button
// ─────────────────────────────────────────
class _IconCountButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const _IconCountButton({
    required this.icon,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            '$count',
            style: context.bodySmall.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
