import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth/auth_service.dart';
import '../commons/common_widget.dart';
import '../home/admin_manage_user.dart';

// ignore: must_be_immutable
class EditingScreen extends GetView<LoginService> {
  final void Function(UserModel) onSave;
  final TextEditingController name;
  final TextEditingController email;

  final _formKey = GlobalKey<FormState>();
  EditingScreen({
    Key? key,
    required this.onSave,
    required this.name,
    required this.email,
  }) : super(key: key);

  UserService userService = UserService();
  final authController = Get.find<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Editing',
                    style: CommonWidget.titleText(),
                  ),
                ),
                TextFormField(
                  controller: name,
                  decoration: CommonWidget.inputStyle(placeholder: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter New Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      CommonWidget.inputStyle(placeholder: 'Current Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Email';
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
                      placeholder: 'New Password',
                      isShow: controller.isObscure,
                      onShow: () {
                        controller.isObscure = !controller.isObscure;
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Create New Password';
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
                  child: const Text('Update'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (controller.emailController.value.text !=
                          authController.useremail) {
                        if (authController.useremail == 'admin@gmail.com') {
                          String password = userService.hashPassword(
                              controller.comfirmpasswordController.value.text);

                          UserModel updateUser = UserModel(
                            name: controller.nameController.value.text,
                            email: controller.emailController.value.text,
                            password: password,
                          );
                          onSave(updateUser);
                          Get.snackbar('Editing', 'Success',
                              backgroundColor: Colors.green);
                          controller.clear();
                          Get.to(() => AdminManageUserScreen());
                        } else {
                          Get.snackbar('Editing', 'Invalid Current Email!',
                              backgroundColor: Colors.red);
                          controller.clear();
                        }
                      } else {
                        String password = userService.hashPassword(
                            controller.comfirmpasswordController.value.text);

                        UserModel updateUser = UserModel(
                          name: controller.nameController.value.text,
                          email: controller.emailController.value.text,
                          password: password,
                        );
                        onSave(updateUser);

                        // ignore: prefer_const_constructors

                        if (updateUser.id == 0) {
                          Get.offNamed('/adminhome');
                        } else {
                          Get.offNamed('/userhome');
                        }
                        Get.snackbar('Editing', 'Success',
                            backgroundColor: Colors.green);
                        controller.clear();
                      }
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
