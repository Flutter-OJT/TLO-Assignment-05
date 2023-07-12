import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/repository/crud_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeService extends GetxController {
  final CrudUserRepository _crudUserRepository = CrudUserRepository();
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<UserModel> userPerPage = <UserModel>[].obs;
  final ScrollController scrollController = ScrollController();

  final _isLoadMore = false.obs;
  final _isAdmin = false.obs;
  final _isUser = false.obs;
  String name = '';
  String email = '';
  final _itemsPerPage = 8.obs;
  final _currentpage = 0.obs;

  @override
  void onInit() {
    print(">>> HomeService called");
    fetchDataFromDatabase();
    fetchUser();
    super.onInit();
  }

  bool get isAdmin => _isAdmin.value;
  set isAdmin(bool value) => _isAdmin.value = value;

  bool get isUser => _isUser.value;
  set isUser(bool value) => _isUser.value = value;

  int get currentpage => _currentpage.value;
  int get itemperPage => _itemsPerPage.value;

  set currentpage(int value) => _currentpage.value = value;
  set itemperPage(int value) => _itemsPerPage.value = value;

  bool get isLoadMore => _isLoadMore.value;
  set isLoadMore(bool value) => _isLoadMore.value = value;

  Future<void> fetchDataFromDatabase() async {
    List<UserModel>? users = await _crudUserRepository.list();
    if (users != null) {
      userList.assignAll(users);
    }
  }

  fetchUser({int? itemPerPage, int? currentPage}) async {
    List<UserModel>? data = await _crudUserRepository.list();
    final userData = await _paginateData(
        data, itemPerPage ?? itemperPage, currentPage ?? currentpage);
    if (userData != null) {
      userPerPage.addAll(userData);
    }
    isLoadMore = false;
  }

  Future<List<UserModel>?> _paginateData(
      List<UserModel>? data, int itemPerPage, int currentPage) async {
    if (data == null) return null;

    final startIndex = currentPage * itemPerPage;
    final endIndex = startIndex + itemPerPage;
    if (startIndex >= data.length) return null;

    return data.sublist(
        startIndex, endIndex < data.length ? endIndex : data.length);
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
