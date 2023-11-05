import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import '../../models/user_model.dart';
import 'user_dao.dart';

part 'user_database.g.dart';

@Database(version: 1, entities: [UserModel])
abstract class UserDatabase extends FloorDatabase {
  UserDao get userDao;
}