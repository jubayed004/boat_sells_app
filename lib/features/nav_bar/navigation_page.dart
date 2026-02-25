import 'package:boat_sells_app/features/nav_bar/controller/navigation_controller.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, this.index = 0});

  final int index;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _controller = Get.find<NavigationControllerMain>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.selectedNavIndex.value = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _controller.getPages()[_controller.selectedNavIndex.value];
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _controller.icons.length,
                (index) => Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _controller.selectedNavIndex.value = index;
                    },
                    child: Obx(() {
                      bool isSelected =
                          _controller.selectedNavIndex.value == index;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isSelected
                              ? Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _controller.icons[index],
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                )
                              : Icon(
                                  _controller.icons[index],
                                  color: Colors.black,
                                  size: 24,
                                ),
                          const SizedBox(height: 4),
                          Text(
                            _controller.labels[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
