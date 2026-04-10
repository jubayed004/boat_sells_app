import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/remote/socket_service.dart';
import 'package:boat_sells_app/features/chat/controller/chat_controller.dart';
import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/chat/widgets/chat_tile.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ChatController controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initSocket();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.pagingController.refresh();
      _initSocket();
    }
  }

  Future<void> _initSocket() async {
    await SocketApi.init();
    controller.listenForNewConversation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Chat',
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 14.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => controller.pagingController.refresh(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              PagedSliverList<int, ChatItem>.separated(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<ChatItem>(
                  itemBuilder: (context, item, index) => ChatTile(
                    chat: item,
                    onTap: () {
                      AppRouter.route.pushNamed(
                        RoutePath.inboxScreen,
                        extra: item,
                      );
                    },
                  ),
                  firstPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: NoDataCard(
                      onTap: () => controller.pagingController.refresh(),
                      title: 'No Chats',
                      subtitle: 'You have no chats yet.',
                      icon: Icons.chat_bubble_outline_rounded,
                      iconColor: AppColors.primaryBlue,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.dividerColor,
                  indent: 74.w,
                  endIndent: 20.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
