import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/repository/crud_user_repository.dart';
import 'package:get/get.dart';

class HomeService extends GetxController {
  final CrudUserRepository _crudUserRepository = CrudUserRepository();
  RxList<UserModel> userList = <UserModel>[].obs;
  final _isAdmin = false.obs;
  final _isUser = false.obs;
  String name = '';
  String email = '';

  @override
  void onInit() {
    print(">>> HomeService called");
    fetchDataFromDatabase();
    super.onInit();
  }

  bool get isAdmin => _isAdmin.value;
  set isAdmin(bool value) => _isAdmin.value = value;

  bool get isUser => _isUser.value;
  set isUser(bool value) => _isUser.value = value;
  Future<void> fetchDataFromDatabase() async {
    List<UserModel>? users = await _crudUserRepository.list();
    if (users != null) {
      userList.assignAll(users);
    }
  }

  Future<void> createItem(UserModel userModel) async {
    int? id = await _crudUserRepository.create(userModel.toMap());
    if (id != null) {
      userModel.id = id;
      userList.add(userModel);
    }
  }

  Future<void> updateUser(UserModel updatedUser, int id) async {
    updatedUser.id = id;
    await _crudUserRepository.update(id, updatedUser.toMap());

    int index = userList.indexWhere((user) => user.id == id);
    if (index != -1) {
      userList[index].id = id;
      userList[index].name = updatedUser.name;
      userList[index].email = updatedUser.email;
      userList[index].password = updatedUser.password;
      userList.refresh(); // Notify observers about the change
    }
  }

  Future<void> deleteUser(int? id) async {
    if (id != null) {
      await _crudUserRepository.delete(id);
      userList.removeWhere((user) => user.id == id);
    }
  }
}
