// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorUserDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder databaseBuilder(String name) =>
      _$UserDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$UserDatabaseBuilder(null);
}

class _$UserDatabaseBuilder {
  _$UserDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$UserDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$UserDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<UserDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$UserDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UserDatabase extends UserDatabase {
  _$UserDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER, `lastName` TEXT, `firstName` TEXT, `birthYear` TEXT, `birthMonth` TEXT, `birthDay` TEXT, `age` INTEGER, `email` TEXT, `phone` TEXT, `urlToLargeImage` TEXT, `urlToMediumImage` TEXT, `urlToThumbnail` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'birthYear': item.birthYear,
                  'birthMonth': item.birthMonth,
                  'birthDay': item.birthDay,
                  'age': item.age,
                  'email': item.email,
                  'phone': item.phone,
                  'urlToLargeImage': item.urlToLargeImage,
                  'urlToMediumImage': item.urlToMediumImage,
                  'urlToThumbnail': item.urlToThumbnail
                }),
        _userModelDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'birthYear': item.birthYear,
                  'birthMonth': item.birthMonth,
                  'birthDay': item.birthDay,
                  'age': item.age,
                  'email': item.email,
                  'phone': item.phone,
                  'urlToLargeImage': item.urlToLargeImage,
                  'urlToMediumImage': item.urlToMediumImage,
                  'urlToThumbnail': item.urlToThumbnail
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final DeletionAdapter<UserModel> _userModelDeletionAdapter;

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM users');
  }

  @override
  Future<List<UserModel>> getUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            lastName: row['lastName'] as String?,
            firstName: row['firstName'] as String?,
            birthYear: row['birthYear'] as String?,
            birthMonth: row['birthMonth'] as String?,
            birthDay: row['birthDay'] as String?,
            age: row['age'] as int?,
            email: row['email'] as String?,
            phone: row['phone'] as String?,
            urlToLargeImage: row['urlToLargeImage'] as String?,
            urlToMediumImage: row['urlToMediumImage'] as String?,
            urlToThumbnail: row['urlToThumbnail'] as String?));
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    await _userModelDeletionAdapter.delete(user);
  }
}
