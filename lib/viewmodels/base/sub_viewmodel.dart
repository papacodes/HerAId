import 'package:flutter/widgets.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_buttons_content.dart';
import 'package:oats_package/helpers/content_locator.dart';
import 'package:oats_package/views/base/base_viewmodel.dart';

abstract class SubViewModel extends BaseViewModel {
  final RealmButtonsContent? buttonsCopy = ContentLocator.buttons.content;

  final PageStorageKey scrollbarPageStorageKey = const PageStorageKey('scrollbar');
  final GlobalKey containerGlobalKey = GlobalKey();

  void Function(bool)? onNeedToScrollTop;
  void Function(bool)? onNeedToScrollBottom;
  void Function(GlobalKey?, double?)? onNeedToScrollWidget;

  void triggerScrollToTop({required bool animated}) {
    onNeedToScrollTop?.call(animated);
  }

  void triggerScrollToBottom({required bool animated}) {
    onNeedToScrollBottom?.call(animated);
  }

  void triggerScrollToWidget(GlobalKey? key, double? offset) {
    onNeedToScrollWidget?.call(key, offset);
  }

  SubViewModel();
}
