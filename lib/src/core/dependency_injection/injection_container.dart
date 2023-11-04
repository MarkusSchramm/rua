import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:rua/src/features/random_user/data/data_sources/local/user_database.dart';
import 'package:rua/src/features/random_user/data/data_sources/remote/randomuser_api_service.dart';
import 'package:rua/src/features/random_user/data/repositories/user_repository_impl.dart';
import 'package:rua/src/features/random_user/domain/repositories/user_repository.dart';
import 'package:rua/src/features/random_user/domain/usecases/get_random_users.dart';
import 'package:rua/src/features/random_user/domain/usecases/get_saved_users.dart';
import 'package:rua/src/features/random_user/domain/usecases/remove_all_users.dart';
import 'package:rua/src/features/random_user/domain/usecases/remove_user.dart';
import 'package:rua/src/features/random_user/domain/usecases/save_user.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/local_user_bloc.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/remote_user_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final userDb = await $FloorUserDatabase
      .databaseBuilder('user_database.db')
      .build();

  sl.registerSingleton<UserDatabase>(userDb);
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<RandomUserApiService>(RandomUserApiService(sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GetRandomUsersUseCase>(GetRandomUsersUseCase(sl()));
  sl.registerSingleton<GetSavedUsersUseCase>(GetSavedUsersUseCase(sl()));
  sl.registerSingleton<RemoveAllUsersUseCase>(RemoveAllUsersUseCase(sl()));
  sl.registerSingleton<RemoveUserUseCase>(RemoveUserUseCase(sl()));
  sl.registerSingleton<SaveUserUseCase>(SaveUserUseCase(sl()));

  sl.registerFactory<RemoteUserBloc>(() => RemoteUserBloc(sl()));
  sl.registerFactory<LocalUserBloc>(() => LocalUserBloc(sl(), sl(), sl(), sl()));
}