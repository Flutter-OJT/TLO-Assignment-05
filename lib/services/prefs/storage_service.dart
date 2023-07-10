import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxController {
  final storage = const FlutterSecureStorage();

  Future<void> clearStorage() async {
    await storage.delete(key: 'useremail');
    await storage.delete(key: 'username');
    await storage.delete(key: 'userpassword');
  }
}
