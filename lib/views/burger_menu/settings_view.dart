import 'package:flutter/material.dart';
import 'package:oats_package/core/keys/burger_menu/settings_keys.dart';
import 'package:oats_package/data/services/settings_service.dart';
import 'package:oats_package/views/base/viewmodel_provider.dart';
import 'package:oats_package/views/burger_menu/settings_viewmodel.dart';
import 'package:oats_package/views/base/sub_view.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:provider/provider.dart';
import 'package:oats_theme/presentation/widgets/cards/generic_switch_heading_and_description_card_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return ViewModelProvider<SettingsViewModel>(
      viewModelBuilder: () => SettingsViewModel(context),
      builder: (context, viewModel, child) => SubView(
        key: SettingsKeys.settingsView,
        vm: viewModel,
        hasBurgerMenu: true,
        subViewText: viewModel.screenCopy?.titleText,
        hasDoneFooter: true,
        children: _settingComponentsWidget(theme: theme, vm: viewModel),
      ),
    );
  }

  List<Widget> _settingComponentsWidget({
    required ThemeProvider theme,
    required SettingsViewModel vm,
  }) =>
      [
        //Location Services Row
        _settingsRowWidget(
          switchKey: SettingsKeys.locationSwitch,
          onTapFunction: vm.updateSetting,
          state: vm.settings.location,
          settingsType: SettingsType.location,
          headingKey: SettingsKeys.locationHeadingText,
          descriptionKey: SettingsKeys.locationDescriptionText,
          enabledHeading: vm.screenCopy?.locationServicesEnabledComponent?.headingText,
          disabledHeading: vm.screenCopy?.locationServicesDisabledComponent?.headingText,
          enabledDescription: vm.screenCopy?.locationServicesEnabledComponent?.descriptionText,
          disabledDescription: vm.screenCopy?.locationServicesDisabledComponent?.descriptionText,
        ),
        SizedBox(height: theme.paddingSize.small),
        //Biometrics Row
        if (vm.biometricsSupported) ...[
          _settingsRowWidget(
            switchKey: SettingsKeys.biometricsSwitch,
            onTapFunction: vm.updateSetting,
            state: vm.settings.biometrics,
            settingsType: SettingsType.biometrics,
            headingKey: SettingsKeys.biometricsHeadingText,
            descriptionKey: SettingsKeys.biometricsDescriptionText,
            enabledHeading: vm.screenCopy?.biometricLoginEnabledComponent?.headingText,
            disabledHeading: vm.screenCopy?.biometricLoginDisabledComponent?.headingText,
            enabledDescription: vm.screenCopy?.biometricLoginEnabledComponent?.descriptionText,
            disabledDescription: vm.screenCopy?.biometricLoginDisabledComponent?.descriptionText,
          ),
          SizedBox(height: theme.paddingSize.small),
        ],
        // Notifications Permission Row
        if (vm.showPushNotificationSetting) ...[
          _settingsRowWidget(
            switchKey: SettingsKeys.notificationsSwitch,
            onTapFunction: vm.updateSetting,
            state: vm.settings.notifications,
            settingsType: SettingsType.notifications,
            headingKey: SettingsKeys.notificationsHeadingText,
            descriptionKey: SettingsKeys.notificationsDescriptionText,
            enabledHeading: vm.screenCopy?.pushNotificationsEnabledComponent?.headingText,
            disabledHeading: vm.screenCopy?.pushNotificationsDisabledComponent?.headingText,
            enabledDescription: vm.screenCopy?.pushNotificationsEnabledComponent?.descriptionText,
            disabledDescription: vm.screenCopy?.pushNotificationsDisabledComponent?.descriptionText,
          ),
          SizedBox(height: theme.paddingSize.small),
        ],
        //Dark/Light Mode Based on System Appearance Row
        if (vm.systemAppearanceSupported) ...[
          _settingsRowWidget(
            switchKey: SettingsKeys.systemAppearanceSwitch,
            onTapFunction: vm.updateSetting,
            state: vm.settings.systemAppearance,
            settingsType: SettingsType.systemAppearance,
            headingKey: SettingsKeys.systemAppearanceHeadingText,
            descriptionKey: SettingsKeys.systemAppearanceDescriptionText,
            enabledHeading: vm.screenCopy?.systemSettingsDarkModeEnabledComponent?.headingText,
            disabledHeading: vm.screenCopy?.systemSettingsDarkModeDisabledComponent?.headingText,
            enabledDescription: vm.screenCopy?.systemSettingsDarkModeEnabledComponent?.descriptionText,
            disabledDescription: vm.screenCopy?.systemSettingsDarkModeDisabledComponent?.descriptionText,
          ),
          SizedBox(height: theme.paddingSize.small),
        ],
        //Dark Mode Row
        if ((vm.settings.systemAppearance == null) || !vm.settings.systemAppearance!) ...[
          _settingsRowWidget(
            switchKey: SettingsKeys.darkModeSwitch,
            onTapFunction: vm.updateSetting,
            state: vm.settings.darkMode,
            settingsType: SettingsType.darkMode,
            headingKey: SettingsKeys.darkModeHeadingText,
            descriptionKey: SettingsKeys.darkModeDescriptionText,
            enabledHeading: vm.screenCopy?.darkModeEnabledComponent?.headingText,
            disabledHeading: vm.screenCopy?.darkModeDisabledComponent?.headingText,
            enabledDescription: vm.screenCopy?.darkModeEnabledComponent?.descriptionText,
            disabledDescription: vm.screenCopy?.darkModeDisabledComponent?.descriptionText,
          ),
          SizedBox(height: theme.paddingSize.small),
        ],
        SizedBox(height: theme.paddingSize.small),
      ];

  GenericSwitchHeadingAndDescriptionCardView _settingsRowWidget({
    required Key switchKey,
    required Function onTapFunction,
    required bool? state,
    required SettingsType settingsType,
    required Key headingKey,
    required Key descriptionKey,
    required String? enabledHeading,
    required String? enabledDescription,
    required String? disabledHeading,
    required String? disabledDescription,
  }) =>
      GenericSwitchHeadingAndDescriptionCardView(
        switchKey: switchKey,
        state: state ?? false,
        headingKey: headingKey,
        heading: (state ?? false) ? disabledHeading ?? '' : enabledHeading ?? '',
        descriptionKey: descriptionKey,
        description: (state ?? false) ? disabledDescription ?? '' : enabledDescription ?? '',
        onTap: () => onTapFunction(
          settingsType,
          (state == null) ? true : !state,
        ),
      );
}
