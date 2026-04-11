import 'dart:io';
import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/nav_bar/controller/navigation_controller.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:boat_sells_app/utils/multipart/multipart_body.dart';
import 'package:flutter/material.dart';
import 'package:boat_sells_app/features/add_post/widgets/engine_info_section.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

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
  final hullMaterialController = TextEditingController();
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

  final Rx<List<File>> images = Rx<List<File>>([]);
  final Rx<String?> selectedBoatType = Rx<String?>(null);
  final Rx<String?> selectedCategory = Rx<String?>(null);

  final List<String> boatTypes = ['Sail', 'Motor', 'Speed', 'Fishing', 'Yacht'];

  final List<String> categories = [
    'Motor Yacht',
    'Sailing Yacht',
    'Catamaran',
    'Speedboat',
    'Houseboat',
  ];

  final Rx<List<EngineInfoModel>> engines =
      Rx<List<EngineInfoModel>>([]);

  final RxBool isEnginesExpanded = false.obs;
  final RxBool isAdditionalInfoExpanded = false.obs;

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
    // Additional Information Fields
    hullMaterialController.dispose();
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

    for (var engine in engines.value) {
      engine.dispose();
    }
    super.onClose();
  }

  Future<void> pickImage() async {
    if (images.value.length >= 5) {
      AppToast.error(message: 'You can upload a maximum of 5 media files.');
      return;
    }

    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultipleMedia();

    if (pickedFiles.isNotEmpty) {
      List<File> validFiles = List.from(images.value);

      for (var xFile in pickedFiles) {
        if (validFiles.length >= 5) {
          AppToast.error(message: 'You can upload a maximum of 5 media files.');
          break;
        }

        final file = File(xFile.path);
        final pathLower = file.path.toLowerCase();

        final isVideo =
            pathLower.endsWith('.mp4') ||
            pathLower.endsWith('.mov') ||
            pathLower.endsWith('.avi') ||
            pathLower.endsWith('.mkv');

        if (isVideo) {
          try {
            final videoController = VideoPlayerController.file(file);
            await videoController.initialize();
            final duration = videoController.value.duration;
            await videoController.dispose();

            if (duration.inSeconds > 10) {
              AppToast.error(message: 'Video cannot exceed 10 seconds.');
              continue;
            }
          } catch (e) {
            AppToast.error(message: 'Failed to process video file.');
            continue;
          }
        }

        validFiles.add(file);
      }

      images.value = validFiles;
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

  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = sl();
  final LocalService localService = sl();

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  final addPostLoading = false.obs;

  void _clearFields() {
    titleController.clear();
    locationController.clear();
    priceController.clear();
    modelController.clear();
    yearController.clear();
    lengthController.clear();
    capacityController.clear();
    descriptionController.clear();
    
    // Additional Information Fields
    hullMaterialController.clear();
    manufacturerController.clear();
    bridgeClearanceController.clear();
    addInfoEngineModelController.clear();
    fuelCapacityController.clear();
    freshWaterTankController.clear();
    cruiseSpeedController.clear();
    loaController.clear();
    maxSpeedController.clear();
    beamController.clear();
    cabinController.clear();
    draftController.clear();
    mechanicalEquipmentController.clear();
    galleyEquipmentController.clear();
    deskHullEquipmentController.clear();
    navigationSystemController.clear();
    additionalEquipmentController.clear();

    images.value = [];
    selectedBoatType.value = null;
    selectedCategory.value = null;
    
    for (var engine in engines.value) {
      engine.dispose();
    }
    engines.value = [];
    isEnginesExpanded.value = false;
    isAdditionalInfoExpanded.value = false;
  }
  bool loadingAddPostMethod(bool status) => addPostLoading.value = status;
  Future<void> addPost() async {
    print("presssssssss");
 final body = {
  "title": titleController.text.trim(),
  "location": locationController.text.trim(),
  "price": int.tryParse(priceController.text.trim()) ?? 0,
  "boat_info": {
    "boatType": selectedBoatType.value,
    "category": selectedCategory.value,
    "hullMaterial": hullMaterialController.text.trim(),
    "length": int.tryParse(lengthController.text.trim()) ?? 0,
    "year": int.tryParse(yearController.text.trim()) ?? 0,
    "model": modelController.text.trim(),
    "peopleCapacity": int.tryParse(capacityController.text.trim()) ?? 0,
    "description": descriptionController.text.trim(),
  },
  "boat_engine_info": {
    "engines": engines.value.map((e) => {
      "engineType": e.typeController.text.trim(),
      "fuelType": e.fuelController.text.trim(),
      "engineMake": e.makeController.text.trim(),
      "engineModel": e.modelController.text.trim(),
      "horsePower": int.tryParse(e.powerController.text.trim()) ?? 0,
      "engineHours": int.tryParse(e.hoursController.text.trim()) ?? 0,
    }).toList()
  },
  "boat_additional_info": {
    "manufacturer": manufacturerController.text.trim(),
    "engineModel": addInfoEngineModelController.text.trim(),
    "fuelCapacity": int.tryParse(fuelCapacityController.text.trim()) ?? 0,
    "freshWaterTank": int.tryParse(freshWaterTankController.text.trim()) ?? 0,
    "additionalEquipment": additionalEquipmentController.text.trim(),
    "beam": int.tryParse(beamController.text.trim()) ?? 0,
    "bridgeClearance": int.tryParse(bridgeClearanceController.text.trim()) ?? 0,
    "cabin": int.tryParse(cabinController.text.trim()) ?? 0,
    "cruiseSpeed": int.tryParse(cruiseSpeedController.text.trim()) ?? 0,
    "deckHullEquipment": deskHullEquipmentController.text.trim(),
    "draft": int.tryParse(draftController.text.trim()) ?? 0,
    "galleyEquipment": galleyEquipmentController.text.trim(),
    "loa": int.tryParse(loaController.text.trim()) ?? 0,
    "maxSpeed": int.tryParse(maxSpeedController.text.trim()) ?? 0,
    "mechanicalEquipment": mechanicalEquipmentController.text.trim(),
    "navigationSystem": navigationSystemController.text.trim(),
  }
};
    loadingAddPostMethod(true);
    final token = await localService.getToken();
    try {
      List<MultipartBody> multipartBody = [];

      for (var file in images.value) {
        multipartBody.add(
          MultipartBody(
            fieldKey: "files",
            file: file,
          ),
        );
      }
AppConfig.logger.i(body);
      final response = await apiClient.uploadMultipart(
        url: ApiUrls.addPost(),
        files: multipartBody,
        method: "POST",
        token: token,
        fields: body,
      );
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loadingAddPostMethod(false);
        AppToast.success(message: response.data["message"].toString());
        _clearFields();
        NavigationControllerMain.to.selectedNavIndex.value = 4;
      } else {
        loadingAddPostMethod(false);
        AppToast.error(message: response.data["message"].toString());
      }


      
    } catch (e) {
      loadingAddPostMethod(false);
      AppToast.error(message: e.toString());
    }
  }
}
