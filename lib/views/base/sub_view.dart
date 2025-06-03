import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oats_package/core/keys/generic/generic_keys.dart';
import 'package:oats_package/core/keys/sub_view_keys.dart';
import 'package:oats_package/helpers/animation_helper.dart';
import 'package:oats_package/views/base/sub_viewmodel.dart';
import 'package:oats_package/views/base/base_view.dart';
import 'package:oats_package/views/burger_menu/burger_menu_view.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:oats_theme/presentation/widgets/app_bars/back_nav_bar.dart';
import 'package:oats_theme/presentation/widgets/generic/hide_on_keyboard_open.dart';
import 'package:provider/provider.dart';

class SubView extends StatefulWidget {
  final SubViewModel vm;
  final bool hasBurgerMenu;
  final String? subViewText;
  final bool hasDoneFooter;
  final List<Widget> children;
  final Widget? footerChild;

  /// When setting [onBackTapped] you should set [canPop] to false, unless you
  /// specifically require [canPop] to be true.
  final void Function()? onBackTapped;
  final String? doneFooterCopy;
  final bool doneFooterEnabled;
  final void Function()? onDoneFooterTapped;
  final bool canPop;
  final bool useStandardSidePadding;

  /// The [vm] property defines the ViewModel to use. [hasBurgerMenu] sets wether
  /// this view should show the default burger menu or not. [subViewText] is used
  /// to set the text displayed at the top of the view. [hasDoneFooter] specifies
  /// if the footer button should be showed. [children] are the child Widgets to be
  /// added to the base view. [onBackTapped] set a custom method to use when clicking
  /// the hardware back. When setting [onBackTapped] you should set [canPop] to false,
  /// unless you specifically require [canPop] to be true.
  /// Set the footer copy with [doneFooterCopy] if it has to differ that the default copy.
  /// [doneFooterEnabled] is used to set the enabled/disabled state of the footer button.
  /// Specify the functionality for the footer button with [onDoneFooterTapped]. Set [canPop]
  /// based on wether you should be able to use the hardware back press. [useStandardSidePadding]
  /// is used to tell the view if you want the default padding for left and right or no
  /// padding at all.
  const SubView({
    required this.vm,
    required this.hasBurgerMenu,
    required this.subViewText,
    required this.hasDoneFooter,
    required this.children,
    this.onBackTapped,
    this.doneFooterCopy,
    this.doneFooterEnabled = true,
    this.onDoneFooterTapped,
    this.canPop = true,
    this.useStandardSidePadding = true,
    this.footerChild,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SubViewState();
}

class _SubViewState extends State<SubView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    widget.vm.onNeedToScrollTop = (animated) => _scrollTo(animated: animated, toTop: true);
    widget.vm.onNeedToScrollBottom = (animated) => _scrollTo(animated: animated, toTop: false);
    widget.vm.onNeedToScrollWidget = (targetKey, offset) => scrollToWidget(targetKey, offset: offset);
  }

  void scrollToWidget(GlobalKey? key, {double? offset}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final keyContext = key?.currentContext;
      if (keyContext != null && _scrollController.hasClients) {
        final targetBox = keyContext.findRenderObject()! as RenderBox;
        final scrollViewBox = _scrollController.position.context.storageContext.findRenderObject()! as RenderBox;
        final targetOffset = targetBox.localToGlobal(Offset.zero, ancestor: scrollViewBox).dy + (offset ?? 0);
        final targetHeight = targetBox.size.height;

        final scrollPosition = _scrollController.position;
        final scrollOffset = _scrollController.position.pixels;
        final viewportDimension = scrollPosition.viewportDimension;

        // Check if the target widget is out of view at the bottom
        if (targetOffset + targetHeight > viewportDimension) {
          // Note: Due to android scroll behaviour we delay a bit before trying to scroll.
          // This is to support widgets that are growing while we scroll.
          if (Platform.isAndroid) {
            await Future.delayed(const Duration(milliseconds: 100));
          }

          await _scrollController.animateTo(
            (scrollOffset + targetOffset + targetHeight) - viewportDimension,
            duration: AnimationHelper.standardDuration,
            curve: Curves.easeOut,
          );
        }
        // Check if the target widget is out of view at the top
        else if (targetOffset < 0) {
          await _scrollController.animateTo(
            targetOffset,
            duration: AnimationHelper.standardDuration,
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  void _scrollTo({required bool animated, required bool toTop}) {
    _executeAfterFrameOrImmediately(() async {
      if (_scrollController.hasClients) {
        if (animated) {
          await _scrollController.animateTo(
            toTop ? 0 : _scrollController.position.maxScrollExtent,
            duration: AnimationHelper.standardDuration,
            curve: Curves.easeOut,
          );
        }
        // JumpTo incase animation was skipped or interrupted
        _scrollController.jumpTo(toTop ? 0 : _scrollController.position.maxScrollExtent);
      }
    });
  }

  void _executeAfterFrameOrImmediately(VoidCallback callback) {
    if (WidgetsBinding.instance.hasScheduledFrame) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    } else {
      callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    var backgroundDecoration = BoxDecoration(
      color: theme.backgroundStyles?.subscreen?.mainBackgroundPrimaryColor ?? theme.colors.primary,
    );

    var navBar = BackNavBar.fromTheme(
      key: GenericKeys.popBackButton,
      backArrowIcon: OatsIcons.interfaceEssential.backNavArrow,
      textKey: GenericKeys.subViewText,
      subViewText: widget.subViewText,
      onTap: () => widget.onBackTapped != null ? widget.onBackTapped!.call() : widget.vm.popBack(),
    );

    return BaseView(
      vm: widget.vm,
      backgroundDecoration: backgroundDecoration,
      burgerMenu: widget.hasBurgerMenu ? const BurgerMenuView() : null,
      canPop: widget.canPop,
      onBackTapped: widget.onBackTapped,
      children: [
        navBar,
        _body(theme: theme),
        ..._footer(theme: theme),
      ],
    );
  }

  Widget _body({required ThemeProvider theme}) => Expanded(
        child: Container(
          //NOTE: Used this Container with GlobalKey to fix some scroll jumping and flickering issues.
          key: widget.vm.containerGlobalKey,
          child: RawScrollbar(
            controller: _scrollController,
            key: widget.vm.scrollbarPageStorageKey,
            thumbVisibility: true,
            thumbColor: theme.colors.scrollBarThumb,
            radius: const Radius.circular(8),
            thickness: 4,
            fadeDuration: Duration.zero,
            padding: EdgeInsets.only(right: theme.paddingSize.xSmall),
            child: SingleChildScrollView(
              key: SubViewFlowKeys.scrollView,
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: widget.useStandardSidePadding
                        ? EdgeInsets.all(theme.paddingSize.standard)
                        : EdgeInsets.only(
                            top: theme.paddingSize.standard,
                            bottom: theme.paddingSize.standard,
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                  ..._inBodyFooter(theme: theme),
                ],
              ),
            ),
          ),
        ),
      );

  List<Widget> _footer({required ThemeProvider theme}) => [
        if (widget.hasDoneFooter) HideOnKeyboardOpen(child: _doneFooterSection(theme: theme)),
        if (widget.footerChild != null) HideOnKeyboardOpen(child: widget.footerChild!),
      ];

  List<Widget> _inBodyFooter({required ThemeProvider theme}) => [
        if (widget.hasDoneFooter)
          HideOnKeyboardOpen(
            replacement: _doneFooterSection(theme: theme),
            child: Container(),
          ),
        if (widget.footerChild != null)
          HideOnKeyboardOpen(
            replacement: widget.footerChild!,
            child: Container(),
          ),
      ];

  Widget _doneFooterSection({required ThemeProvider theme}) {
    var doneButton = Button.fromTheme(
      key: SubViewFlowKeys.doneButtonKey,
      style: PreDefinedButtonStyle.primaryButton,
      text: widget.doneFooterCopy ?? widget.vm.buttonsCopy?.done?.text,
      busy: widget.vm.busy,
      enabled: widget.doneFooterEnabled,
      onTap: widget.onDoneFooterTapped ?? () => widget.vm.popBack(),
    );

    return Container(
      margin: EdgeInsets.only(
        left: theme.paddingSize.standard,
        right: theme.paddingSize.standard,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OatsDivider.fromTheme(),
          SizedBox(height: theme.paddingSize.standard),
          doneButton,
        ],
      ),
    );
  }
}
