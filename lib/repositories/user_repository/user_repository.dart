// ignore_for_file: unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/dio.dart';
import 'base_user_repository.dart';

typedef LogoutCallback = void Function();

class UserRepository extends BaseUserRepository {
  DioClient? dioClient;
  SharedPreferences? sharedPreferences;
  UserRepository({required this.dioClient, required this.sharedPreferences});
}
