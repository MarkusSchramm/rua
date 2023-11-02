import 'package:rua/src/core/util/data_state.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  // API
  Future<DataState<List<UserEntity>>> getRandomUsers(int quantity);

  // Local-DB
  Future<List<UserEntity>> getSavedUsers();
  Future<void> saveUser(UserEntity user);
  Future<void> removeUser(UserEntity user);
  Future<void> removeAllUsers();
}