import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import '../../../utils/dimensions.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationItem notificationModel;
  const NotificationDialog({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          notificationModel.image != "null"
              ? Container(
                  height: MediaQuery.of(context).size.width - 130,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.20)),
                )
              : const SizedBox(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                notificationModel.title!,
                textAlign: TextAlign.center,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(notificationModel.description!,
                  textAlign: TextAlign.center)),
          const SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
        ],
      ),
    );
  }
}
