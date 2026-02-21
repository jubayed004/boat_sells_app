import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // Maximum number of items per page
  static const _pageSize = 5;

  // The PagingController to handle the pagination state
  final PagingController<int, BoatModel> pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    super.onInit();
    // Listen for new page requests
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Simulate an API call delay
      await Future.delayed(const Duration(milliseconds: 1500));

      final newItems = _generateDummyBoats(pageKey, _pageSize);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  // --- Dummy Data Generator ---
  List<BoatModel> _generateDummyBoats(int offset, int limit) {
    // Generate 'limit' number of dummy boats based on the offset
    return List.generate(limit, (index) {
      final id = offset + index + 1;
      return BoatModel(
        id: id.toString(),
        imageUrl: _dummyImages[id % _dummyImages.length],
        sellerName: 'Seller $id',
        sellerAvatar: 'https://randomuser.me/api/portraits/thumb/men/$id.jpg',
        title: 'Boat Model $id - Excellence',
        price: 10000.00 + (id * 500),
        location: 'Location City $id',
        likes: 10 * id,
        comments: 5 * id,
        shares: 2 * id,
        category: 'Yacht',
      );
    });
  }

  // A small pool of dummy images to cycle through
  final List<String> _dummyImages = const [
    'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800',
    'https://www.yachtingnews.com/wp-content/uploads/2023/07/Absolute-FLY.jpg',
    'https://www.tessllc.us/wp-content/uploads/2020/07/yacht-post-825x510.jpg',
    'https://www.yachtingnews.com/wp-content/uploads/2023/07/Absolute-FLY.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTumCYkr6Mt5yoAbiLFrNLY1CxwFVjYpCk2MQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd0WBUoQDX8XXESA3yQB7vKVxKRTKjdBFjLQ&s',
  ];

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
