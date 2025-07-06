import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oats_package/core/assets.dart';
import 'package:oats_package/core/keys/burger_menu/contact_us_keys.dart';
import 'package:oats_package/views/base/viewmodel_provider.dart';
import 'package:oats_package/views/burger_menu/contact_us_viewmodel.dart';
import 'package:oats_package/views/base/sub_view.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:oats_theme/presentation/widgets/cards/generic_icon_heading_and_description_text_card_view.dart';
import 'package:provider/provider.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return ViewModelProvider<ContactUsViewModel>(
      viewModelBuilder: () => ContactUsViewModel(),
      builder: (context, viewModel, child) => SubView(
        key: ContactUsKeys.contactUsView,
        vm: viewModel,
        hasBurgerMenu: true,
        subViewText: viewModel.screenCopy?.titleText,
        hasDoneFooter: true,
        useStandardSidePadding: false,
        children: _body(theme: theme, vm: viewModel),
      ),
    );
  }

  List<Widget> _body({required ThemeProvider theme, required ContactUsViewModel vm}) => [
        // Medical Assistance
        Padding(
          padding: EdgeInsets.only(left: theme.paddingSize.standard, right: theme.paddingSize.standard),
          child: GenericIconHeadingAndDescriptionCardView(
            iconName: ContactUsAssets.medicalAssistanceIcon,
            headingKey: ContactUsKeys.medicalAssistanceHeadingText,
            heading: vm.screenCopy?.medicalAssistanceComponent?.headingText ?? '',
            descriptionKey: ContactUsKeys.medicalAssistanceDescriptionText,
            description: vm.screenCopy?.medicalAssistanceComponent?.descriptionText ?? '',
            descriptionWeight: FontStyleWeight.light,
            descriptionColor: theme.colors.primaryText,
            onTap: vm.callMedicalAssistance,
          ),
        ),
        SizedBox(height: theme.paddingSize.small),
        // Policy Services
        Padding(
          padding: EdgeInsets.only(left: theme.paddingSize.standard, right: theme.paddingSize.standard),
          child: GenericIconHeadingAndDescriptionCardView(
            iconName: ContactUsAssets.policyServicesIcon,
            headingKey: ContactUsKeys.policyServicesHeadingText,
            heading: vm.screenCopy?.policyServicesComponent?.headingText ?? '',
            descriptionKey: ContactUsKeys.policyServicesDescriptionText,
            description: vm.screenCopy?.policyServicesComponent?.descriptionText ?? '',
            descriptionWeight: FontStyleWeight.light,
            descriptionColor: theme.colors.primaryText,
            onTap: vm.callPolicyServices,
          ),
        ),
        SizedBox(height: theme.paddingSize.small),
        // Visit Website
        Padding(
          padding: EdgeInsets.only(left: theme.paddingSize.standard, right: theme.paddingSize.standard),
          child: GenericIconHeadingAndDescriptionCardView(
            iconName: ContactUsAssets.viewWebsiteIcon,
            headingKey: ContactUsKeys.viewWebsiteHeadingText,
            heading: vm.screenCopy?.viewWebsiteComponent?.headingText ?? '',
            descriptionKey: ContactUsKeys.viewWebsiteDescriptionText,
            description: vm.screenCopy?.viewWebsiteComponent?.descriptionText ?? '',
            descriptionWeight: FontStyleWeight.medium,
            descriptionColor: theme.colors.contactUsWebsite,
            onTap: vm.openWebsite,
          ),
        ),
        SizedBox(height: theme.paddingSize.standard),
        // Call Centre Hours
        _callCentreHoursControl(theme: theme, vm: vm),
      ];

  Widget _callCentreHoursControl({required ThemeProvider theme, required ContactUsViewModel vm}) {
    var subScreenBlock = Container(
      width: 170,
      height: 170,
      color: theme.colors.subScreenBlock,
    );

    var headingText = Container(
      margin: EdgeInsets.only(
        top: theme.paddingSize.standard,
        left: theme.paddingSize.standard,
        right: theme.paddingSize.standard,
      ),
      child: TextLabel(
        key: ContactUsKeys.callCentreHoursHeadingText,
        text: vm.screenCopy?.callCentreHoursText,
        style: theme.textStyles.text(color: theme.colors.primaryText, fontStyleWeight: FontStyleWeight.medium),
      ),
    );

    var callCentreHoursCard = CardView.fromTheme(
      margin: EdgeInsets.only(
        left: theme.paddingSize.standard,
        right: theme.paddingSize.standard,
      ),
      child: Container(
        margin: EdgeInsets.all(theme.paddingSize.standard),
        child: Column(
          children: [
            // Monday to Friday
            _callCentreHoursRowControl(
              theme: theme,
              daysKey: ContactUsKeys.mondayToFridayText,
              days: vm.screenCopy?.mondayToFridayText ?? '',
              daysValueKey: ContactUsKeys.mondayToFridayValue,
              daysValue: vm.screenCopy?.mondayToFridayValueText ?? '',
            ),
            SizedBox(height: theme.paddingSize.standard),
            // Saturday
            _callCentreHoursRowControl(
              theme: theme,
              daysKey: ContactUsKeys.saturdayText,
              days: vm.screenCopy?.saturdayText ?? '',
              daysValueKey: ContactUsKeys.saturdayValue,
              daysValue: vm.screenCopy?.saturdayValueText ?? '',
            ),
            SizedBox(height: theme.paddingSize.standard),
            // Sunday
            _callCentreHoursRowControl(
              theme: theme,
              daysKey: ContactUsKeys.sundayText,
              days: vm.screenCopy?.sundayText ?? '',
              daysValueKey: ContactUsKeys.sundayValue,
              daysValue: vm.screenCopy?.sundayValueText ?? '',
            ),
            SizedBox(height: theme.paddingSize.standard),
            // Public Holiday
            _callCentreHoursRowControl(
              theme: theme,
              daysKey: ContactUsKeys.publicHolidayText,
              days: vm.screenCopy?.publicHolidayText ?? '',
              daysValueKey: ContactUsKeys.publicHolidayValue,
              daysValue: vm.screenCopy?.publicHolidayValueText ?? '',
            ),
          ],
        ),
      ),
    );

    return Stack(
      children: [
        subScreenBlock,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingText,
            SizedBox(height: theme.paddingSize.standard),
            callCentreHoursCard,
          ],
        ),
      ],
    );
  }

  Widget _callCentreHoursRowControl({
    required ThemeProvider theme,
    required Key daysKey,
    required String days,
    required Key daysValueKey,
    required String daysValue,
  }) {
    var daysText = TextLabel(
      key: daysKey,
      text: days,
      style: theme.textStyles
          .text(color: theme.colors.primaryText, fontStyleWeight: FontStyleWeight.light)
          .copyWith(fontSize: theme.fontSizes.medium),
    );

    var daysValueText = TextLabel(
      key: daysValueKey,
      text: daysValue,
      textAlign: TextAlign.right,
      style: theme.textStyles.text(color: theme.colors.primaryText, fontStyleWeight: FontStyleWeight.medium),
    );

    return Row(
      children: [
        Expanded(child: daysText),
        SizedBox(width: theme.paddingSize.small),
        daysValueText,
      ],
    );
  }
}
