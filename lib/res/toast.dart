import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class ToastManager {
  static void showErrorToast(BuildContext context, String message) {
    ElegantNotification.error(
        height: 80,
        showProgressIndicator: true,
        displayCloseButton: true,
        description: Text(
          message,
        )).show(context);
  }

  static void showSuccessToast(BuildContext context, String message) {
    ElegantNotification.success(
        height: 80,
        showProgressIndicator: false,
        displayCloseButton: false,
        description: Text(
          message,
        )).show(context);
  }
}
