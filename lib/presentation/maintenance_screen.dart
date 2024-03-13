import 'package:flutter/material.dart';
import 'package:study_buddy_app/constants/constants.dart';

import '../constants/custom_theme.dart';
import '../constants/images.dart';
import '../utils/dimensions.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(Images.maintenance, width: 200, height: 200),
            Text(StringConstants.maintenanceMode,
                style: titilliumBold.copyWith(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                )),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              StringConstants.maintenanceMessage,
              textAlign: TextAlign.center,
              style: titilliumRegular,
            ),
          ]),
        ),
      ),
    );
  }
}
