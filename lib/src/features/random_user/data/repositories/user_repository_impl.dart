import 'dart:io';
import 'package:dio/dio.dart';

import 'package:rua/src/core/util/data_state.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/local/user_database.dart';
import '../data_sources/remote/randomuser_api_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final RandomUserApiService _randomUserApiService;
  final UserDatabase _userDatabase;

  UserRepositoryImpl(this._randomUserApiService, this._userDatabase);

  @override
  Future<DataState<List<UserModel>>> getRandomUsers(int num) async {
    try {
      final httpResponse = await _randomUserApiService.getRandomUsers(
        results: num.toString(),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.results);
      } else {
        return DataFail(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<List<UserEntity>> getSavedUsers() {
    return _userDatabase.userDao.getUsers();
  }

  @override
  Future<void> removeAllUsers() {
    return _userDatabase.userDao.deleteAllUsers();
  }

  @override
  Future<void> removeUser(UserEntity user) {
    return _userDatabase.userDao.deleteUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> saveUser(UserEntity user) {
    return _userDatabase.userDao.insertUser(UserModel.fromEntity(user));
  }
}