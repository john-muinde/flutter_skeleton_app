import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy_app/constants/constants.dart';

import '../constants/custom_theme.dart';
import '../constants/images.dart';
import '../main.dart';
import '../utils/dimensions.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget? child;
  final String? message;
  final String? icon;
  const NoInternetOrDataScreen({
    Key? key,
    required this.isNoInternet,
    this.child,
    this.message,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                isNoInternet
                    ? Images.noInternet
                    : icon != null
                        ? icon!
                        : Images.noData,
                width: 75),
            if (isNoInternet)
              Text('OOPS',
                  style: titilliumBold.copyWith(
                      fontSize: 30, color: Colors.white)),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Text(
                isNoInternet
                    ? StringConstants.noNetworkMessage
                    : message != null
                        ? message.toString()
                        : StringConstants.noDataFound,
                textAlign: TextAlign.center,
                style: textRegular.copyWith()),
            const SizedBox(height: 20),
            isNoInternet
                ? Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorPalette.backgroundCornflowerBlue),
                    child: TextButton(
                      onPressed: () async {
                        if (await Connectivity().checkConnectivity() !=
                            ConnectivityResult.none) {
                          Navigator.pushReplacement(Get.context!,
                              MaterialPageRoute(builder: (_) => child!));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(StringConstants.retry,
                            style: titilliumSemiBold.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontSize: Dimensions.fontSizeLarge)),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
