import 'package:authentications/repository/crud_user_repository.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../commons/common_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends GetView<LoginService> {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    UserService userService = UserService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'User Management',
                  style: CommonWidget.titleText(color: Colors.blue),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  'Login',
                  style: CommonWidget.titleText(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.emailController.value,
                keyboardType: TextInputType.emailAddress,
                decoration: CommonWidget.inputStyle(placeholder: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      controller.clear();
                      Get.offNamed('/register');
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // adminrole=> login
                        // email=> admin@gmail.com
                        // password => admin

                        final email = controller.emailController.value.text;
                        final password = userService.hashPassword(
                            controller.passwordController.value.text);

                        try {
                          final CrudUserRepository userrepo =
                              CrudUserRepository();
                          final userList = await userrepo.list();
                          final user = userList!.firstWhere(
                            (user) =>
                                user.email == email &&
                                user.password == password,
                          );

                          if (user.email == email &&
                              user.password == password) {
                            controller.authService.authenticated = true;

                            await storageService.storage
                                .write(key: 'useremail', value: user.email);
                            await storageService.storage
                                .write(key: 'username', value: user.name);
                            await storageService.storage.write(
                                key: 'userpassword', value: user.password);

                            controller.authService.useremail = email;
                            controller.authService.username = user.name;
                            controller.authService.userpassword = user.password;

                            if (user.id == 0) {
                              controller.clear();
                              Get.offNamed('/adminhome');
                            } else {
                              controller.clear();
                              Get.offNamed('/userhome');
                            }
                            Get.snackbar('Login', 'Success!',
                                backgroundColor: Colors.green);
                          } else {
                            throw Exception('Invalid email or password');
                          }
                        } catch (e) {
                          Get.snackbar('Login', 'Invalid Email & Password',
                              backgroundColor: Colors.red);
                          controller.clear();
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
