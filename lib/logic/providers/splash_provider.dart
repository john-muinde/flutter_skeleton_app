import 'package:flutter/material.dart';

import '../../repositories/splash_screen_repository/splash_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashState {
  final bool hasConnection;
  final bool firstTimeConnectionCheck;

  SplashState({
    required this.hasConnection,
    required this.firstTimeConnectionCheck,
  });

  // copy with method to create a new instance of the class
  SplashState copyWith({
    bool? hasConnection,
    bool? firstTimeConnectionCheck,
  }) {
    return SplashState(
      hasConnection: hasConnection ?? this.hasConnection,
      firstTimeConnectionCheck:
          firstTimeConnectionCheck ?? this.firstTimeConnectionCheck,
    );
  }
}

class SplashCubit extends Cubit<SplashState> {
  final SplashRepo splashRepo;

  SplashCubit({required this.splashRepo})
      : super(
            SplashState(hasConnection: false, firstTimeConnectionCheck: true));

  Future<void> initConfig(BuildContext context) async {
    final hasConnection = await splashRepo.checkConnection();
    emit(state.copyWith(hasConnection: hasConnection));
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    emit(state.copyWith(firstTimeConnectionCheck: isChecked));
  }

  void initSharedPrefData() {
    splashRepo.initSharedData();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }

  bool? isMaintenanceMode() {
    return splashRepo.isMaintenanceMode();
  }

  bool get hasConnection => state.hasConnection;
  bool get firstTimeConnectionCheck => state.firstTimeConnectionCheck;
  bool get showIntroScreen => splashRepo.showIntro() ?? true;
  bool get maintenanceMode => splashRepo.isMaintenanceMode() ?? false;
  bool get isLoggedIn =>
      splashRepo.sharedPreferences!.getBool('isLoggedIn') ?? false;
}
