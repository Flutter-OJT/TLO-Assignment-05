import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_service.dart';

class LoginService extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final comfirmpasswordController = TextEditingController().obs;
  final _isObscure = false.obs;
  final _showView = false.obs;

  @override
  void onInit() {
    print('>>> LoginController started');
    clear();
    isObscure;
    super.onInit();
  }

  void clear() {
    nameController.value.text = '';
    emailController.value.text = '';
    passwordController.value.text = '';
    comfirmpasswordController.value.text = '';
  }

  AuthService get authService => Get.find<AuthService>();
  bool get isObscure => _isObscure.value;
  set isObscure(bool value) => _isObscure.value = value;

  bool get showView => _showView.value;
  set showView(bool value) => _showView.value = value;
}
