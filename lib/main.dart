import 'package:authentications/screens/configs/page_config.dart';
import 'package:authentications/services/auth/auth_service.dart';
import 'package:authentications/services/configs/initial_binding.dart';
import 'package:authentications/services/entity/entity_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

final entityService = EntityService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await entityService.initialize();
  final StorageService storageService = Get.put(StorageService());
  final AuthService authController = Get.put(AuthService());
  await _checkLoggedUser(storageService, authController);

  // ignore: unused_local_variable
  Database database = entityService.database;
  runApp(const UserManagementApp());
}

class UserManagementApp extends StatelessWidget {
  const UserManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication',
      initialBinding: InitialBinding(),
      initialRoute: '/login',
      getPages: PageConfig.pages,
    );
  }
}

Future<void> _checkLoggedUser(storageService, authController) async {
  final String? data = await storageService.storage.read(key: 'useremail');

  authController.authenticated = data != null;
  authController.useremail = data ?? "";
  authController.username = data ?? "";
  authController.userpassword = data ?? "";
}
