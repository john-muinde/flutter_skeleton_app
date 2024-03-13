import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_buddy_app/constants/constants.dart';
import 'package:study_buddy_app/data/token_interceptor.dart';
import 'package:study_buddy_app/repositories/auth_repository/auth_repository.dart';
import 'package:study_buddy_app/repositories/user_repository/user_repository.dart';

import 'data/dio.dart';
import 'services/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(
    () => DioClient(
      URLS.BASE_URL,
      sl(),
      tokenInterceptor: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton(
      () => AuthRepository(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(
      () => UserRepository(dioClient: sl(), sharedPreferences: sl()));

  // Provider/ Cubits
  // sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => TokenInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
