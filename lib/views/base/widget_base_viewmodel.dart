import 'package:flutter/foundation.dart';
import 'package:oats_package/data/services/change_notifier_service.dart';

class WidgetBaseViewModel extends ChangeNotifier with ChangeNotifierServices {
  @override
  @mustCallSuper
  void dispose() {
    unregisterAllChangeNotifierServices();
    super.dispose();
  }
}
