import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/strings.dart';
import '../../data/dio.dart';
import '../../services/network/network_info.dart';

class SplashRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  SplashRepo({required this.dioClient, required this.sharedPreferences});

  bool _hasConnection = false;

  bool get hasConnection => _hasConnection;

  Future<bool> checkConnection() async {
    _hasConnection = await NetworkInfo(Connectivity()).isConnected;
    return _hasConnection;
  }

  void initSharedData() {
    if (!sharedPreferences!.containsKey(StringConstants.showIntro)) {
      sharedPreferences!.setBool(StringConstants.showIntro, true);
    }
    sharedPreferences!.setBool(StringConstants.firstTimeConnectionCheck, false);
  }

  bool? showIntro() {
    return sharedPreferences!.getBool(StringConstants.showIntro) ?? true;
  }

  void disableIntro() {
    sharedPreferences!.setBool(StringConstants.showIntro, false);
  }

  bool? isMaintenanceMode() {
    return sharedPreferences!.getBool(StringConstants.maintenanceMode) ?? false;
  }
}
