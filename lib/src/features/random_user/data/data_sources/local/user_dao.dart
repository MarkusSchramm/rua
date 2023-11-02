import 'package:floor/floor.dart';

import '../../models/user_model.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> insertUser(UserModel user);

  @delete
  Future<void> deleteUser(UserModel user);

  @Query('DELETE * FROM users')
  Future<void> deleteAllUsers();

  @Query('SELECT * FROM users')
  Future<List<UserModel>> getUsers();
}