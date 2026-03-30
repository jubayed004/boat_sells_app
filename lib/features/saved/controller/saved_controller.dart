import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:get/get.dart';

class SavedController extends GetxController {
  /// Currently saved boats list (observable)
  final RxList<BoatItem> savedBoats = <BoatItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedBoats();
  }

  void _loadSavedBoats() {
    // Mock data – replace with API call when backend is ready
    savedBoats.assignAll([
      BoatItem(
        id: 's1',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1599408738289-f7e5c06ddaf9?w=800'),
          Media(url: 'https://images.unsplash.com/photo-1543882282-c4d3e6a17e6f?w=800'),
        ],
        user: User(name: 'John Marine', avatarUrl: 'https://i.pravatar.cc/150?img=11'),
        displayTitle: 'Sea Ray SPX 190',
        price: 24500,
        location: 'Miami, FL',
        likesCount: 142,
        commentsCount: 23,
        shareCount: 8,
        isSaved: true,
      ),
      BoatItem(
        id: 's2',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800'),
          Media(url: 'https://images.unsplash.com/photo-1623041882901-0e0a0d9e1e29?w=800'),
        ],
        user: User(name: 'Laura Bay', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
        displayTitle: 'Bayliner VR5 Bowrider',
        price: 31200,
        location: 'Tampa, FL',
        likesCount: 98,
        commentsCount: 17,
        shareCount: 5,
        isSaved: true,
      ),
      BoatItem(
        id: 's3',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1540946485063-a40da27545f8?w=800'),
        ],
        user: User(name: 'Nordic Sails', avatarUrl: 'https://i.pravatar.cc/150?img=14'),
        displayTitle: 'Jeanneau Sun Odyssey 410',
        price: 189000,
        location: 'Newport, RI',
        likesCount: 310,
        commentsCount: 44,
        shareCount: 22,
        isSaved: true,
      ),
      BoatItem(
        id: 's4',
        media: [
          Media(url: 'https://images.unsplash.com/photo-1506932248762-69d978912b80?w=800'),
          Media(url: 'https://images.unsplash.com/photo-1568430558700-b7e6d0de93c1?w=800'),
        ],
        user: User(name: 'Rio Yachts', avatarUrl: 'https://i.pravatar.cc/150?img=32'),
        displayTitle: 'Azimut S7 Yacht',
        price: 480000,
        location: 'Fort Lauderdale, FL',
        likesCount: 521,
        commentsCount: 89,
        shareCount: 61,
        isSaved: true,
      ),
    ]);
  }

  /// Remove a boat from saved list
  void removeSaved(String id) {
    savedBoats.removeWhere((b) => b.id == id);
  }
}
