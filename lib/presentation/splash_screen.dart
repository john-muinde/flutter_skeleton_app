import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_buddy_app/constants/constants.dart';
import 'package:study_buddy_app/logic/providers/splash_provider.dart';

import '../constants/custom_theme.dart';
import '../constants/images.dart';
import '../services/notification/model/notification_body.dart';
import '../utils/dimensions.dart';
import 'maintenance_screen.dart';
import 'no_internet_screen.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({Key? key, this.body}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? StringConstants.noNetworkMessage
                : StringConstants.connectedMessage,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    context.read<SplashCubit>().initConfig(context);

    context.read<SplashCubit>().initSharedPrefData();
    Timer(const Duration(seconds: 1), () {
      if (context.read<SplashCubit>().maintenanceMode) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const MaintenanceScreen(),
          ),
        );
      } else if (context.read<SplashCubit>().isLoggedIn) {
        // Provider.of<AuthProvider>(context, listen: false)
        //     .updateToken(context);
        if (widget.body != null) {
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const Scaffold(
                body: Center(
                  child: Text('Intro Screen'),
                ),
              ),
            ),
          );
        }
      } else if (context.read<SplashCubit>().showIntro() ?? true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
              body: Center(
                child: Text('Intro Screen'),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _globalKey,
      body: context.read<SplashCubit>().state.hasConnection
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    width: 100,
                    child: Image.asset(Images.splashLogo, width: 200.0)),
                Text(StringConstants.appName,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                        color: Colors.white)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Text(StringConstants.slogan,
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.white)))
              ]),
            )
          : const NoInternetOrDataScreen(
              isNoInternet: true, child: SplashScreen()),
    );
  }
}
