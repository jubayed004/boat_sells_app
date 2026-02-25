import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';

class ContactAndSupportScreen extends StatefulWidget {
  const ContactAndSupportScreen({super.key});

  @override
  State<ContactAndSupportScreen> createState() =>
      _ContactAndSupportScreenState();
}

class _ContactAndSupportScreenState extends State<ContactAndSupportScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Contact & Support'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(10.h),
                      CustomTextField(
                        hintText: "Enter Your Name",
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: "Enter Email Address",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: "Write here...",
                        controller: _messageController,
                        maxLines: 6,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Submit",
                onTap: () {
                  // TODO: Implement submit logic
                  AppRouter.route.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
