import 'dart:async';

import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/search/model/search_model.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchController extends GetxController {
  final ApiClient apiClient = sl();

  // ── Paging ──────────────────────────────────────────────────────────────
  final PagingController<int, SearchItem> pagingController =
      PagingController(firstPageKey: 1);

  // ── Search (text) ────────────────────────────────────────────────────────
  final RxString searchText = ''.obs;
  Timer? _debounce;

  // ── Filter params ────────────────────────────────────────────────────────
  final RxString boatType = ''.obs;
  final RxString minPrice = ''.obs;
  final RxString maxPrice = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_loadPage);

    // Debounce so we don't hammer the API on every keystroke
    ever(searchText, (_) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        pagingController.refresh();
      });
    });
  }

  // Called by the search text field
  void onSearchChanged(String value) => searchText.value = value;

  // Called by the filter bottom-sheet "Apply" button
  void applyFilters({
    required String selectedBoatType,
    required String selectedMinPrice,
    required String selectedMaxPrice,
  }) {
    boatType.value = selectedBoatType;
    minPrice.value = selectedMinPrice;
    maxPrice.value = selectedMaxPrice;
    pagingController.refresh();
  }

  // Reset all filters (keeps search text intact)
  void resetFilters() {
    boatType.value = '';
    minPrice.value = '';
    maxPrice.value = '';
    pagingController.refresh();
  }

  bool get hasActiveFilters =>
      boatType.value.isNotEmpty ||
      minPrice.value.isNotEmpty ||
      maxPrice.value.isNotEmpty;

  // ── Internal page fetcher ─────────────────────────────────────────────────
  Future<void> _loadPage(int pageKey) async {
    try {
      final response = await apiClient.get(
        url: ApiUrls.search(
          page: pageKey,
          search: searchText.value,
          maxPrice: maxPrice.value,
          minPrice: minPrice.value,
          boatType: boatType.value,
        ),
      );
      AppConfig.logger.d(response.data);

      if (response.statusCode == 200) {
        final searchModel = SearchModel.fromJson(response.data);
        final newItems = searchModel.data ?? [];
        final isLastPage = newItems.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = response.data['message'] ?? 'Unknown error';
      }
    } catch (error) {
      AppConfig.logger.e(error);
      pagingController.error = error;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    pagingController.dispose();
    super.onClose();
  }
}
