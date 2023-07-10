import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/screens/commons/common_widget.dart';
import 'package:authentications/services/home/home_service.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repository/crud_user_repository.dart';
import '../../services/auth/auth_service.dart';
import '../auth/editing_screen.dart';

// ignore: must_be_immutable
class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthService>();
  final loginService = Get.put(LoginService());
  final HomeService controller = Get.put(HomeService());
  UserService userService = UserService();
  //LoginService loginService = LoginService();
  final CrudUserRepository userrepo = CrudUserRepository();

  Future<List<UserModel>?> getUser() async {
    return await userrepo.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('USER')),
      body: FutureBuilder<List<UserModel>?>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching user data.'));
          } else if (snapshot.hasData) {
            List<UserModel> userList = snapshot.data!;
            UserModel userinfo = userList.firstWhere(
                (userinfo) => userinfo.email == authController.useremail);
            if (userinfo.isNull) {
              return const Center(
                child: Text('User No Record!'),
              );
            }

            return Column(
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
                    child: ListView(
                      children: [
                        GestureDetector(
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
                              title: Text(userinfo.name.toString()),
                              subtitle: Text(userinfo.email.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: CommonWidget.commonIconButton(
                                      onPressed: () {
                                        getBottomSheet(
                                            userinfo.id!.toInt(),
                                            userinfo.name.toString(),
                                            userinfo.email.toString());
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
                                                'Are you sure you want to delete this user?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await controller.deleteUser(
                                                        userinfo.id);
                                                    Get.snackbar(
                                                        'Delete', 'Deleted!');
                                                    Get.offNamed('/login');
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
                            ),
                          ),
                        ),
                      ],
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
                ),
              ],
            );
          } else {
            return const Center(child: Text('No user data available.'));
          }
        },
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
