// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_buddy_app/constants/urls.dart';
import 'package:study_buddy_app/main.dart';

import '../../data/dio.dart';
import '../../models/user.dart';
import '../../utils/functions.dart';
import '../../utils/log.dart';
import 'base_auth_repository.dart';

typedef LogoutCallback = void Function();

class AuthRepository extends BaseAuthRepository {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  AuthRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<User> login({required email, required password}) async {
    final response = await dioClient!.post(
      URLS.URL_AUTH,
      data: jsonEncode(
        {"email": email, "password": password},
      ),
    );

    final jsonData = jsonDecode(response.data)['data'];

    final User user = User.fromJson(jsonData);

    sharedPreferences!.setString("user", jsonEncode(user));
    return user;
  }

  @override
  Future<bool> logout() async {
    try {
      sharedPreferences!.remove("user");
      UtilFunctions().logoutCallBack(navigatorkey: Get.navigator!);
      return true;
    } catch (e) {
      throw ErrorDescription("Failed to logout");
    }
  }

  @override
  Future<Map<String, dynamic>> checkTokenValidity() async {
    String token = sharedPreferences!.getString("token") ?? "";
    final response =
        await dioClient!.get(URLS.CHECK_TOKEN, acceptedStatusCodes: [200]);
    final bool success = response.statusCode == 200;
    return {
      "success": true,
      "user": jsonDecode(response.data)["data"],
      "token": token
    };
  }

  @override
  Future<User?> checkUser() async {
    String? userFromPrefs = sharedPreferences!.getString('user');

    if (userFromPrefs != null) {
      final userString = jsonDecode(userFromPrefs);
      final User user = User.fromJson(userString);
      Log.i(user.email);
      return user;
    } else {
      throw ('User not authenticated');
    }
  }
}
