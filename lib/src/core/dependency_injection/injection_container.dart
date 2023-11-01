import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

//@TODO: register singletons and factories
Future<void> initializeDependencies() async {

  sl.registerSingleton<Dio>(Dio());

}