import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:get/get.dart';

class SavedController extends GetxController {
  /// Currently saved boats list (observable)
  final RxList<BoatModel> savedBoats = <BoatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedBoats();
  }

  void _loadSavedBoats() {
    // Mock data – replace with API call when backend is ready
    savedBoats.assignAll([
      const BoatModel(
        id: 's1',
        imageUrl:
            'https://images.unsplash.com/photo-1599408738289-f7e5c06ddaf9?w=800',
        imageUrls: [
          'https://images.unsplash.com/photo-1599408738289-f7e5c06ddaf9?w=800',
          'https://images.unsplash.com/photo-1543882282-c4d3e6a17e6f?w=800',
        ],
        sellerName: 'John Marine',
        sellerAvatar: 'https://i.pravatar.cc/150?img=11',
        title: 'Sea Ray SPX 190',
        price: 24500,
        location: 'Miami, FL',
        likes: 142,
        comments: 23,
        shares: 8,
        isSaved: true,
        category: 'Speed Boat',
      ),
      const BoatModel(
        id: 's2',
        imageUrl:
            'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800',
        imageUrls: [
          'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800',
          'https://images.unsplash.com/photo-1623041882901-0e0a0d9e1e29?w=800',
        ],
        sellerName: 'Laura Bay',
        sellerAvatar: 'https://i.pravatar.cc/150?img=5',
        title: 'Bayliner VR5 Bowrider',
        price: 31200,
        location: 'Tampa, FL',
        likes: 98,
        comments: 17,
        shares: 5,
        isSaved: true,
        category: 'Bowrider',
      ),
      const BoatModel(
        id: 's3',
        imageUrl:
            'https://images.unsplash.com/photo-1540946485063-a40da27545f8?w=800',
        imageUrls: [
          'https://images.unsplash.com/photo-1540946485063-a40da27545f8?w=800',
        ],
        sellerName: 'Nordic Sails',
        sellerAvatar: 'https://i.pravatar.cc/150?img=14',
        title: 'Jeanneau Sun Odyssey 410',
        price: 189000,
        location: 'Newport, RI',
        likes: 310,
        comments: 44,
        shares: 22,
        isSaved: true,
        category: 'Sailboat',
      ),
      const BoatModel(
        id: 's4',
        imageUrl:
            'https://images.unsplash.com/photo-1506932248762-69d978912b80?w=800',
        imageUrls: [
          'https://images.unsplash.com/photo-1506932248762-69d978912b80?w=800',
          'https://images.unsplash.com/photo-1568430558700-b7e6d0de93c1?w=800',
        ],
        sellerName: 'Rio Yachts',
        sellerAvatar: 'https://i.pravatar.cc/150?img=32',
        title: 'Azimut S7 Yacht',
        price: 480000,
        location: 'Fort Lauderdale, FL',
        likes: 521,
        comments: 89,
        shares: 61,
        isSaved: true,
        category: 'Yacht',
      ),
    ]);
  }

  /// Remove a boat from saved list
  void removeSaved(String id) {
    savedBoats.removeWhere((b) => b.id == id);
  }
}
