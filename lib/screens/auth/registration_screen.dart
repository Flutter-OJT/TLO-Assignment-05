import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../commons/common_widget.dart';

// ignore: must_be_immutable
class RegistrationScreen extends GetView<LoginService> {
  RegistrationScreen({Key? key}) : super(key: key);
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();

  LoginService loginService = Get.find<LoginService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/login');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    'Registration',
                    style: CommonWidget.titleText(),
                  ),
                ),
                TextFormField(
                  controller: controller.nameController.value,
                  decoration: CommonWidget.inputStyle(placeholder: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmail) {
                      return 'Please Enter your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.emailController.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CommonWidget.inputStyle(placeholder: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController.value,
                    obscureText: !controller.isObscure,
                    decoration: CommonWidget.passwordStyle(
                      placeholder: 'Password',
                      isShow: controller.isObscure,
                      onShow: () {
                        controller.isObscure = !controller.isObscure;
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => TextFormField(
                    controller: controller.comfirmpasswordController.value,
                    obscureText: !controller.isObscure,
                    decoration: CommonWidget.passwordStyle(
                      placeholder: 'Confirm Password',
                      isShow: controller.isObscure,
                      onShow: () {
                        controller.isObscure = !controller.isObscure;
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Confirm Password';
                      }
                      if (value != controller.passwordController.value.text) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String password = userService.hashPassword(
                          controller.comfirmpasswordController.value.text);

                      UserModel newUser = UserModel(
                        name: controller.nameController.value.text,
                        email: controller.emailController.value.text,
                        password: password,
                      );

                      userService.createUser(newUser);

                      // ignore: prefer_const_constructors
                      Get.snackbar('Registration', 'Success',
                          backgroundColor: Colors.green);
                      Get.offNamed('/login');
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
