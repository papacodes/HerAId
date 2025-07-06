import 'package:flutter/material.dart';
import 'package:oats_package/core/assets.dart';
import 'package:oats_package/core/keys/burger_menu/burger_menu_keys.dart';
import 'package:oats_package/views/base/viewmodel_provider.dart';
import 'package:oats_package/views/burger_menu/burger_menu_viewmodel.dart';
import 'package:oats_package/views/burger_menu/widgets/footer_item.dart';
import 'package:oats_package/views/burger_menu/widgets/policies_list_card.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:oats_theme/presentation/widgets/generic/icon_box.dart';
import 'package:provider/provider.dart';

class BurgerMenuView extends StatefulWidget {
  const BurgerMenuView({super.key});

  @override
  State<BurgerMenuView> createState() => _BurgerMenuViewState();
}

class _BurgerMenuViewState extends State<BurgerMenuView> {
  late ThemeProvider theme;
  late BurgerMenuViewModel vm;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context);

    return ViewModelProvider<BurgerMenuViewModel>(
      viewModelBuilder: () => BurgerMenuViewModel(),
      builder: (context, viewModel, child) {
        vm = viewModel;
        return viewModel.busy ? BusyIndicator(spinnerColor: theme.colors.loader) : _burgerMenu();
      },
    );
  }

  Widget _burgerMenu() {
    var divider = OatsDivider.fromTheme();

    var signOutButton = Button.fromTheme(
      key: BurgerMenuKeys.signOutButton,
      style: PreDefinedButtonStyle.primaryButton,
      text: vm.screenCopy?.logOutButton?.text,
      busy: vm.busy,
      trailingIcon: OatsIcons.interfaceEssential.rightArrow,
      trailingIconSize: 18,
      onTap: () async => vm.signOutOnTapped(),
    );

    var standardPadding = theme.paddingSize.standard;
    var paddingForScrollBar = theme.paddingSize.xSmall;
    var paddingAfterScrollBar = standardPadding - paddingForScrollBar;

    var signOutFooterButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingAfterScrollBar),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: theme.paddingSize.small),
          divider,
          SizedBox(height: theme.paddingSize.small),
          signOutButton,
        ],
      ),
    );

    var scrollController = ScrollController();

    return Drawer(
      key: BurgerMenuKeys.burgerMenuView,
      backgroundColor: theme.backgroundStyles?.subscreen?.mainBackgroundPrimaryColor,
      surfaceTintColor: theme.backgroundStyles?.subscreen?.mainBackgroundPrimaryColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: standardPadding, horizontal: paddingForScrollBar),
          child: Column(
            children: [
              Expanded(
                child: RawScrollbar(
                  key: BurgerMenuKeys.scrollView,
                  controller: scrollController,
                  thumbVisibility: true,
                  thumbColor: theme.colors.scrollBarThumb,
                  radius: const Radius.circular(4),
                  thickness: 2,
                  fadeDuration: Duration.zero,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingAfterScrollBar),
                      child: Column(
                        children: [
                          _topDrawerBar(),
                          divider,
                          ExpansionButton.fromTheme(
                            key: BurgerMenuKeys.homeButton,
                            itemName: vm.screenCopy?.homeText ?? '',
                            trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                            onTapped: () => vm.navigateToHomeOnTapped(),
                          ),
                          if (vm.showMyCover)
                            ExpansionButton.fromTheme(
                              key: BurgerMenuKeys.myCoverButton,
                              itemName: vm.screenCopy?.myCoverText ?? '',
                              trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                              onTapped: () => vm.navigateToMyCoverOnTapped(),
                            ),
                          if (vm.isPolicyHolder && vm.hasDocumentsFeature)
                            ExpansionButton.fromTheme(
                              key: BurgerMenuKeys.documentsButton,
                              itemName: vm.screenCopy?.documentsText ?? '',
                              trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                              onTapped: () => vm.navigateToDocumentsOnTapped(),
                            ),
                          ExpansionButton.fromTheme(
                            key: BurgerMenuKeys.assistButton,
                            itemName: vm.screenCopy?.assistText ?? '',
                            trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                            onTapped: () => vm.navigateToAssistOnTapped(),
                          ),
                          ExpansionButton.fromTheme(
                            key: BurgerMenuKeys.myProfileButton,
                            itemName: vm.screenCopy?.myProfileText ?? '',
                            trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                            onTapped: () => vm.navigateToMyProfileOnTapped(),
                          ),
                          if (vm.showPaymentDetails)
                            ExpansionButton.fromTheme(
                              key: BurgerMenuKeys.paymentDetailsButton,
                              itemName: vm.screenCopy?.paymentDetailsText ?? '',
                              trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                              onTapped: () => vm.navigateToPaymentDetailsOnTapped(),
                            ),
                          if (vm.showMyTasks)
                            ExpansionButton.fromTheme(
                              key: BurgerMenuKeys.myTasksButton,
                              itemName: vm.screenCopy?.myTasksText ?? '',
                              trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                              onTapped: () => vm.navigateToMyTasksOnTapped(),
                            ),
                          if (vm.policies.length > 1)
                            ExpansionButton.fromTheme(
                              key: BurgerMenuKeys.policySelectButton,
                              itemName: vm.screenCopy?.allMyPoliciesText ?? '',
                              trailingCollapsedIcon: OatsIcons.interfaceEssential.downArrow,
                              trailingExpandedIcon: OatsIcons.interfaceEssential.upArrow,
                              // ignore: avoid_unnecessary_containers
                              drawerChild: Container(
                                margin: EdgeInsets.only(
                                  top: theme.paddingSize.xSmall,
                                  left: theme.paddingSize.xSmall,
                                  right: theme.paddingSize.xSmall,
                                  bottom: theme.paddingSize.standard,
                                ),
                                child: CardView.fromTheme(
                                  child: Padding(
                                    padding: EdgeInsets.all(theme.paddingSize.small),
                                    child: PoliciesListCard(
                                      labelsCopy: vm.labelsCopy,
                                      policies: vm.policies,
                                      activePolicyNumberLabel: vm.screenCopy?.policyNumberText,
                                      inactivePolicyNumberLabel: vm.screenCopy?.inactivePolicyNumberText,
                                      insuredAddressLabel: vm.screenCopy?.insuredAddressText,
                                      activePolicyNumber: vm.activePolicyNumber,
                                      policySelectedAction: vm.onPolicySelected,
                                      addHorizontalPadding: false,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ExpansionButton.fromTheme(
                            key: BurgerMenuKeys.contactUsButton,
                            itemName: vm.screenCopy?.contactUsText ?? '',
                            trailingCollapsedIcon: OatsIcons.interfaceEssential.rightArrow,
                            onTapped: () => vm.navigateToContactUsOnTapped(),
                          ),
                          _otherSection(),
                          if (vm.hasRateAppFeature) _rateAppSection(),
                          SizedBox(height: theme.paddingSize.small), // NOTE: Always keep at the end
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              signOutFooterButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget _topDrawerBar() {
    var exitIcon = OatsGestureDetector(
      key: BurgerMenuKeys.exitButton,
      onTap: () => vm.popBack(),
      child: Container(
        margin: EdgeInsets.only(
          top: theme.paddingSize.small,
          right: theme.paddingSize.small,
          bottom: theme.paddingSize.small,
        ),
        child: IconBox.customPadding(theme: theme, icon: GenericAssets.closeIcon, padding: theme.paddingSize.xSmall),
      ),
    );

    var versionText = TextLabel(
      text: '${vm.screenCopy?.versionText ?? ''} ${vm.appVersion ?? ''}',
      style: theme.textStyles.description(color: theme.colors.primaryText),
    );

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [exitIcon, versionText]);
  }

  Widget _otherSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: theme.paddingSize.xSmall),
      FooterItem(
        key: BurgerMenuKeys.settingsButton,
        text: vm.screenCopy?.settingsText,
        onTap: () => vm.navigateToSettingsOnTapped(),
      ),
      FooterItem(
        key: BurgerMenuKeys.termsAndConditionsButton,
        text: vm.screenCopy?.termsAndConditionsText,
        onTap: () => vm.navigateToTermsAndConditionsOnTapped(),
      ),
      FooterItem(
        key: BurgerMenuKeys.faqsButton,
        text: vm.screenCopy?.faqsText,
        onTap: () => vm.navigateToFaqOnTapped(),
      ),
      FooterItem(
        key: BurgerMenuKeys.privacyPolicyButton,
        text: vm.screenCopy?.privacyPolicyText,
        onTap: () => vm.navigateToPrivacyPolicyOnTapped(),
      ),
    ],
  );

  Widget _rateAppSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: theme.paddingSize.small),
      OatsDivider.fromTheme(),
      SizedBox(height: theme.paddingSize.small),
      TextLabel(
        key: BurgerMenuKeys.rateAppHeading,
        text: vm.screenCopy?.rateAppHeadingText,
        style: theme.textStyles.subtitle(color: theme.colors.primaryText, fontStyleWeight: FontStyleWeight.medium),
      ),
      TextLabel(
        key: BurgerMenuKeys.rateAppDescription,
        text: vm.screenCopy?.rateAppDescriptionText,
        style: theme.textStyles.text(color: theme.colors.primaryText, fontStyleWeight: FontStyleWeight.light),
      ),
      SizedBox(height: theme.paddingSize.small),
      Button.fromTheme(
        key: BurgerMenuKeys.rateAppButton,
        style: PreDefinedButtonStyle.tertiaryButton,
        text: vm.screenCopy?.rateAppButton?.text,
        onTap: () async => vm.rateAppTapped(),
      ),
    ],
  );
}
