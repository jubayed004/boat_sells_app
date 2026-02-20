import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  /*
  @override
  void initState() {
    super.initState();
    name.text = profileController.profile.value.data?.fullName ?? "";
    number.text = profileController.profile.value.data?.phoneNumber ?? "";
  }
*/

  @override
  void dispose() {
    name.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
