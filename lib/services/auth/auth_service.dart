import 'package:authentications/services/prefs/storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  final _authenticated = false.obs;
  final _useremail = RxString('');
  final _username = RxString('');
  final _userpassword = RxString('');

  Future<void> logout() async {
    await storageService.clearStorage();
    _authenticated.value = false;
    _useremail.value = "";
    _username.value = "";
  }

  bool get authenticated => _authenticated.value;
  set authenticated(bool value) => _authenticated.value = value;
  String get useremail => _useremail.value;
  set useremail(value) => _useremail.value = value;

  String get username => _username.value;
  set username(value) => _username.value = value;

  String get userpassword => _userpassword.value;
  set userpassword(value) => _userpassword.value = value;
}
