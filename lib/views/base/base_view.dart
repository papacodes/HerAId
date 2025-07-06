import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mzala/helpers/custom_system_ui_overlay_style.dart';
import 'package:mzala/helpers/device_details_helper.dart';
import 'package:mzala/helpers/navigation_helper.dart';
import 'package:mzala/viewmodels/base/base_viewmodel.dart';
import 'package:app_theme/app_theme.dart';
import 'package:provider/provider.dart';

class BaseView extends StatelessWidget {
  final BaseViewModel vm;
  final BoxDecoration backgroundDecoration;
  final Widget? burgerMenu;
  final List<Widget> children;
  final bool canPop;
  final SystemUiOverlayStyle? systemUiOverlayStyleOverride;

  /// When setting [onBackTapped] you should set [canPop] to false, unless you
  /// specifically require [canPop] to be true.
  final void Function()? onBackTapped;

  /// The [vm] property defines the ViewModel to use. [backgroundDecoration] refers
  /// to the styling that has to be applied to the background of this view.
  /// [children] are the child Widgets to be added to the base view.
  /// Set [canPop] based on wether you should be able to use the hardware back press.
  /// [onBackTapped] set a custom method to use when clicking the hardware back. When
  /// setting [onBackTapped] you should set [canPop] to false, unless you specifically require
  /// [canPop] to be true.
  const BaseView({
    required this.vm,
    required this.backgroundDecoration,
    required this.children,
    required this.canPop,
    this.burgerMenu,
    this.onBackTapped,
    this.systemUiOverlayStyleOverride,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    var scaffoldKey = GlobalKey<ScaffoldState>();

    var burgerMenuImage = OatsGestureDetector(
      onTap: () {
        NavigationHelper.addBurgerMenuRoute();
        scaffoldKey.currentState?.openDrawer();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: theme.paddingSize.small,
          right: theme.paddingSize.small,
          bottom: theme.paddingSize.small,
        ),
        child: SvgPicture.asset(
          OatsIcons.interfaceEssential.burgerMenu,
          colorFilter: ColorFilter.mode(theme.colors.navIconsAndText, BlendMode.srcIn),
          width: 18,
          height: 18,
        ),
      ),
    );

    var systemUiOverlayStyleFromTheme =
        theme.brightness == Brightness.light ? CustomSystemUiOverlayStyle.dark : CustomSystemUiOverlayStyle.light;

    var emptyAppBar = PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: systemUiOverlayStyleOverride ?? systemUiOverlayStyleFromTheme,
      ),
    );

    var burgerMenuAppBar = AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: <Widget>[burgerMenuImage],
      ),
      systemOverlayStyle: systemUiOverlayStyleOverride ?? systemUiOverlayStyleFromTheme,
    );

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        printInfo('base_view PopScope was called with result: $result');

        if (!NavigationHelper.isProgrammaticPop) {
          onBackTapped != null ? onBackTapped!.call() : onPopInvoked(didPop: didPop, theme: theme);
        }
      },
      child: OatsGestureDetector(
        onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
        child: DecoratedBox(
          decoration: backgroundDecoration,
          child: Scaffold(
            key: scaffoldKey,
            appBar: burgerMenu != null ? burgerMenuAppBar : emptyAppBar,
            drawer: burgerMenu,
            onDrawerChanged: (isOpened) {
              if (!isOpened) {
                NavigationHelper.removeBurgerMenuRoute();
              }
            },
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              minimum: DeviceDetailsHelper.hasBottomPadding
                  ? EdgeInsets.zero
                  : EdgeInsets.only(bottom: theme.paddingSize.standard),
              child: Container(
                margin: EdgeInsets.only(
                  top: theme.paddingSize.standard,
                  bottom: Platform.isAndroid ? theme.paddingSize.standard : 0,
                ),
                child: Column(
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPopInvoked({
    required bool didPop,
    required ThemeProvider theme,
  }) {
    if (canPop) {
      if (didPop) {
        NavigationHelper.hardwareBackPressed();
      }
    } else {
      vm.onPopInvoked(didPop: didPop, theme: theme);
    }
  }
}
