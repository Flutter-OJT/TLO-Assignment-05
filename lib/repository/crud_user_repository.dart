import 'package:authentications/models/user/user_model.dart';
import 'crud_repository.dart';

/// The item repository.
///
/// author TintLwinOo
class CrudUserRepository extends CRUDRepository<UserModel> {
  @override
  Future<int?> create(Map<String, Object?> data) async {
    final id = await database.insert('userinfo', data);
    return id;
  }

  @override
  Future<int?> update(id, Map<String, Object?> data) async {
    final rowsAffected = await database
        .update('userinfo', data, where: 'id = ?', whereArgs: [id]);
    return rowsAffected;
  }

  @override
  Future<int?> delete(id) async {
    final rowsAffected =
        await database.delete('userinfo', where: 'id = ?', whereArgs: [id]);
    return rowsAffected;
  }

  @override
  Future<UserModel?> getById(id) async {
    final List<Map<String, dynamic>> results = await database.query(
      'userinfo',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }

    return null;
  }

  @override
  Future<List<UserModel>?> list() async {
    List<Map<String, dynamic>> getuser = await database.query('userinfo');

    if (getuser.isNotEmpty) {
      return getuser.map((map) => UserModel.fromMap(map)).toList();
    }
    return null;
  }
}
