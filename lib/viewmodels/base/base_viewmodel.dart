import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oats_package/data/models/audit/audit_page_detail.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_labels_content.dart';
import 'package:oats_package/data/services/analytics_service.dart';
import 'package:oats_package/data/services/change_notifier_service.dart';
import 'package:oats_package/data/services/dialog_service.dart';
import 'package:oats_package/helpers/content_locator.dart';
import 'package:oats_package/helpers/navigation_helper.dart';
import 'package:oats_package/oats_package.dart';
import 'package:oats_theme/providers/theme_provider.dart';

abstract class BaseViewModel extends ChangeNotifier with ChangeNotifierServices {
  final AnalyticsService _analyticsService = getService<AnalyticsService>();

  final RealmLabelsContent? labelsCopy = ContentLocator.labels.content;

  bool _disposed = false;

  bool _busy = false;
  bool get busy => _busy;

  String errorMessage = '';
  dynamic data;
  bool get disposed => _disposed;

  // Note: set to a value that wont evaluate to clicking back twice in quick succession
  DateTime backPressed = DateTime.now().add(const Duration(seconds: -2));

  BaseViewModel() {
    Future.microtask(() {
      _analyticsService.logPageView(
        pageAnalyticsName: auditPageDetail.name ?? '',
        auditEventFeature: auditPageDetail.feature,
        extraDetail: auditPageDetail.extraDetail,
      );
    });
  }

  void onPoppedBack() {
    _analyticsService.logPageView(
      pageAnalyticsName: auditPageDetail.name ?? '',
      auditEventFeature: auditPageDetail.feature,
      extraDetail: auditPageDetail.extraDetail,
    );
  }

  AuditPageDetail get auditPageDetail;

  void popBack() => NavigationHelper.pop();

  void setBusy(bool newValue) {
    _busy = newValue;
    notifyListeners();
  }

  //NOTE: Should we set busy automatically to false once the error message was set
  void setErrorMessage(String newValue, {bool? setBusy}) {
    _busy = setBusy ?? _busy;
    errorMessage = newValue;
    notifyListeners();
  }

  void setData(dynamic newValue) {
    data = newValue;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  //NOTE: Calls the builder function with this updated ViewModel
  void forceRebuild() {
    notifyListeners();
  }

  void softResetStateManager({bool? disposed, bool? busy, bool? errorMessage, bool? data}) {
    if (disposed == true) {
      _disposed = false;
    }

    if (busy == true) {
      _busy = false;
    }

    if (errorMessage == true) {
      this.errorMessage = '';
    }

    if (data == true) {
      this.data = null;
    }
  }

  void softResetStateManagers() {
    _disposed = false;
    _busy = false;
    errorMessage = '';
    data = null;
  }

  void resetStateManagersWithStateUpdate() {
    _disposed = false;
    _busy = false;
    errorMessage = '';
    data = null;

    forceRebuild();
  }

  void onPopInvoked({
    required bool didPop,
    required ThemeProvider theme,
  }) async {
    if (!didPop) {
      if (DateTime.now().difference(backPressed).inSeconds < 2) {
        // Note: Close app
        await SystemNavigator.pop();
      } else {
        getService<DialogService>().showToastMessage(message: labelsCopy?.pushBackToExitText, theme: theme);
      }

      backPressed = DateTime.now();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    unregisterAllChangeNotifierServices();
    super.dispose();
  }
}
