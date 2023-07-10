import 'package:sqflite/sqflite.dart';

import '../../main.dart';

/// # CRUDRepository
///
/// The CRUD repository for all repositories.
/// The generic type of the CRUD repository must be the Model class.
///
/// @author TintLwinOo
abstract class CRUDRepository<E> {
  /// ## list
  ///
  /// Get the list from the database with the specified model
  ///
  /// @return :
  ///   - [Future]
  Future<List<E>?> list();

  /// ## getById
  ///
  /// Get the model from the database with the specified id
  ///
  /// [Parameters]:
  ///   - id [dynamic]
  ///
  /// @return :
  ///   - [Future]
  Future<E?> getById(id);

  /// ## create
  ///
  /// Create a new data to model.
  ///
  /// [Parameters]:
  ///   - data [Map<String, Object>]
  ///
  /// @return :
  ///   - [Future]
  Future<int?> create(Map<String, Object> data);

  /// ## update
  /// Update the model data
  ///
  /// Update the model data.
  ///
  /// [Parameters] :
  ///   - id [dynamic]
  ///   - data [Map<String, Object>]
  ///
  /// @return :
  ///   - [Future]
  Future<int?> update(id, Map<String, Object> data);

  /// ## delete
  ///
  /// Delete the model data.
  ///
  /// [Parameters] :
  ///   - id [dynamic]
  ///
  /// @return :
  ///   - [Future]
  Future<int?> delete(id);

  /// ## database
  /// get the database
  ///
  /// @return :
  ///   - [Database]
  Database get database => entityService.database;
}
