import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_sells_app/features/add_post/widgets/engine_info_section.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostController extends GetxController {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final lengthController = TextEditingController();
  final capacityController = TextEditingController();
  final descriptionController = TextEditingController();

  // Additional Information Fields
  final manufacturerController = TextEditingController();
  final bridgeClearanceController = TextEditingController();
  final addInfoEngineModelController = TextEditingController();
  final fuelCapacityController = TextEditingController();
  final freshWaterTankController = TextEditingController();
  final cruiseSpeedController = TextEditingController();
  final loaController = TextEditingController();
  final maxSpeedController = TextEditingController();
  final beamController = TextEditingController();
  final cabinController = TextEditingController();
  final draftController = TextEditingController();
  final mechanicalEquipmentController = TextEditingController();
  final galleyEquipmentController = TextEditingController();
  final deskHullEquipmentController = TextEditingController();
  final navigationSystemController = TextEditingController();
  final additionalEquipmentController = TextEditingController();

  final ValueNotifier<List<File>> images = ValueNotifier<List<File>>([]);
  final ValueNotifier<String?> selectedBoatType = ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  final List<String> boatTypes = ['Sail', 'Motor', 'Speed', 'Fishing', 'Yacht'];

  final List<String> categories = [
    'Motor Yacht',
    'Sailing Yacht',
    'Catamaran',
    'Speedboat',
    'Houseboat',
  ];

  final ValueNotifier<List<EngineInfoModel>> engines =
      ValueNotifier<List<EngineInfoModel>>([]);

  final ValueNotifier<bool> isEnginesExpanded = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAdditionalInfoExpanded = ValueNotifier<bool>(
    false,
  );

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    priceController.dispose();
    modelController.dispose();
    yearController.dispose();
    lengthController.dispose();
    capacityController.dispose();
    descriptionController.dispose();

    manufacturerController.dispose();
    bridgeClearanceController.dispose();
    addInfoEngineModelController.dispose();
    fuelCapacityController.dispose();
    freshWaterTankController.dispose();
    cruiseSpeedController.dispose();
    loaController.dispose();
    maxSpeedController.dispose();
    beamController.dispose();
    cabinController.dispose();
    draftController.dispose();
    mechanicalEquipmentController.dispose();
    galleyEquipmentController.dispose();
    deskHullEquipmentController.dispose();
    navigationSystemController.dispose();
    additionalEquipmentController.dispose();

    images.dispose();
    selectedBoatType.dispose();
    selectedCategory.dispose();
    for (var engine in engines.value) {
      engine.dispose();
    }
    engines.dispose();
    isEnginesExpanded.dispose();
    isAdditionalInfoExpanded.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.value = [...images.value, File(picked.path)];
    }
  }

  void removeImage(int index) {
    final newList = List<File>.from(images.value);
    newList.removeAt(index);
    images.value = newList;
  }

  void setBoatType(String? value) {
    selectedBoatType.value = value;
  }

  void setCategory(String? value) {
    selectedCategory.value = value;
  }

  void addEngine() {
    engines.value = [...engines.value, EngineInfoModel()];
  }

  void removeEngine(int index) {
    final newList = List<EngineInfoModel>.from(engines.value);
    final removed = newList.removeAt(index);
    removed.dispose();
    engines.value = newList;
  }

  void toggleEnginesExpanded() {
    isEnginesExpanded.value = !isEnginesExpanded.value;
  }

  void toggleAdditionalInfoExpanded() {
    isAdditionalInfoExpanded.value = !isAdditionalInfoExpanded.value;
  }
}
