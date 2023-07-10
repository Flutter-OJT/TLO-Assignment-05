import 'package:authentications/screens/auth/editing_screen.dart';
import 'package:authentications/screens/commons/common_widget.dart';
import 'package:authentications/services/home/home_service.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/user/user_model.dart';
import '../../repository/crud_user_repository.dart';
import '../../services/auth/auth_service.dart';

// ignore: must_be_immutable
class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthService>();
  final loginService = Get.put(LoginService());
  final HomeService controller = Get.put(HomeService());
  UserService userService = UserService();
  final CrudUserRepository userrepo = CrudUserRepository();
  _loadData() async {
    await Get.find<HomeService>().fetchDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/login');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/adminmanageuser');
            },
            icon: const Icon(Icons.next_plan),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Text(
                'RECORD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserModel user = controller.userList[index];
                    return GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.note_add,
                              size: 40,
                            ),
                            title: Text(user.name.toString()),
                            subtitle: Text(user.email.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (user.id == 0)
                                  CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: CommonWidget.commonIconButton(
                                      onPressed: () {
                                        getBottomSheet(
                                            user.id!.toInt(),
                                            user.name.toString(),
                                            user.email.toString());
                                      },
                                      icon: Icons.edit,
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: CommonWidget.commonIconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Delete User'),
                                            content: const Text(
                                                'Are you sure you want to delete this user?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await controller
                                                      .deleteUser(user.id);
                                                  Get.back();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await authController.logout();
                Get.offNamed('/login');
                loginService.clear();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }

  void getBottomSheet(int userid, String name, String email) {
    Get.bottomSheet(EditingScreen(
      onSave: (updateUser) {
        controller.updateUser(updateUser, userid);
      },
      name: TextEditingController(text: name),
      email: TextEditingController(text: email),
    ));
  }
}
