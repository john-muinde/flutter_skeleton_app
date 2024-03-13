import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../utils/dimensions.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: ColorPalette.primaryVariantDavyGray.withOpacity(0.2),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorPalette.onSuccessColor),
              subtitle: Container(
                  height: 10, width: 50, color: ColorPalette.onSuccessColor),
            ),
          ),
        );
      },
    );
  }
}
