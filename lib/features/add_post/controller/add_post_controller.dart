import 'dart:io';
import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
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
  bool loadingAddPostMethod(bool status) => addPostLoading.value = status;
  Future<void> addPost() async {
    final body = {
      "title": titleController.text,
      "location": locationController.text,
      "price": priceController.text,
      "capacity": capacityController.text,
      "boat_info": {
        "boatType": selectedBoatType.value,
        "category": selectedCategory.value,
        "hullMaterial": hullMaterialController.text,
        "length": int.tryParse(lengthController.text) ?? 0,
        "year": int.tryParse(yearController.text) ?? 0,
        "model": modelController.text,
        "peopleCapacity": int.tryParse(capacityController.text) ?? 0,
        "description": descriptionController.text,
      },
      "boat_engine_info": {
       "engines": engines.value.map((e) => {
        "engineType": e.typeController.text,
        "fuelType": e.fuelController.text,
        "engineMake": e.makeController.text,
        "engineModel": e.modelController.text,
        "horsePower": int.tryParse(e.powerController.text) ?? 0,
        "engineHours": int.tryParse(e.hoursController.text) ?? 0,
       }).toList()
      },
      "boat_additional_info": {
        "manufacturer": manufacturerController.text,
        "engineModel": addInfoEngineModelController.text,
        "fuelCapacity": int.tryParse(fuelCapacityController.text) ?? 0,
        "freshWaterTank": int.tryParse(freshWaterTankController.text) ?? 0,
        "additionalEquipment": additionalEquipmentController.text,
        "beam": int.tryParse(beamController.text) ?? 0,
        "bridgeClearance": int.tryParse(bridgeClearanceController.text) ?? 0,
        "cabin": int.tryParse(cabinController.text) ?? 0,
        "cruiseSpeed": int.tryParse(cruiseSpeedController.text) ?? 0,
        "deckHullEquipment": deskHullEquipmentController.text,
        "draft": int.tryParse(draftController.text) ?? 0,
        "galleyEquipment": galleyEquipmentController.text,
        "loa": int.tryParse(loaController.text) ?? 0,
        "maxSpeed": int.tryParse(maxSpeedController.text) ?? 0,
        "mechanicalEquipment": mechanicalEquipmentController.text,
        "navigationSystem": navigationSystemController.text,
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
      if (response.statusCode == 200) {
        loadingAddPostMethod(false);
        AppToast.success(message: response.data["message"].toString());
        AppRouter.route.pop();
        return;
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
