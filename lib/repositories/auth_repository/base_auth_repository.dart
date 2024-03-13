// ignore_for_file: body_might_complete_normally_nullable

import '../../models/user.dart';

abstract class BaseAuthRepository {
  Future<User?> login({required email, required password}) async {}
  Future<String?> signup(
      {required email, required password, required name}) async {}
  Future<bool?> logout() async {}
  Future<Map<String, dynamic>?> checkTokenValidity() async {}
  Future<User?> checkUser() async {}
}
