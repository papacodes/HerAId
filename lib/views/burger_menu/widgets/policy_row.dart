import 'package:flutter/material.dart';
import 'package:oats_package/core/assets.dart';
import 'package:oats_package/core/keys/main/dashboard_keys.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_labels_content.dart';
import 'package:oats_package/helpers/extensions/string_extensions.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:provider/provider.dart';

class PolicyRow extends StatelessWidget {
  final int count;
  final BuildContext context;
  final RealmLabelsContent? labelsCopy;
  final String? activePolicyNumberLabel;
  final String? inactivePolicyNumberLabel;
  final String? policyNumber;
  final String? insuredAddress;
  final bool active;
  final String? insuredAddressLabel;
  final String? activePolicyNumber;
  final void Function(String)? policySelectedAction;

  const PolicyRow({
    required super.key,
    required this.count,
    required this.context,
    required this.labelsCopy,
    required this.activePolicyNumberLabel,
    required this.inactivePolicyNumberLabel,
    required this.policyNumber,
    required this.insuredAddress,
    required this.active,
    required this.insuredAddressLabel,
    required this.activePolicyNumber,
    required this.policySelectedAction,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    var activePolicyIcon = SvgPicture.asset(
      GenericAssets.circleCheckIcon,
      colorFilter:
          ColorFilter.mode(active ? theme.colors.circleActiveCheck : theme.colors.circleInactiveCheck, BlendMode.srcIn),
      width: 28,
      height: 28,
    );

    var policyNumberText = TextLabel(
      key: DashboardKeys.policySelectorPolicyNumberText(count),
      text:
          '${active ? activePolicyNumberLabel : inactivePolicyNumberLabel} ${policyNumber.toDisplayValueWithFallback(fallback: labelsCopy?.emptyFieldText)}',
      style: theme.textStyles.text(
        color: active ? theme.colors.primaryText : theme.colors.inactivePolicyText,
        fontStyleWeight: FontStyleWeight.medium,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    var insuredAddressText = TextLabel(
      key: DashboardKeys.policySelectorInsuredAddressText(count),
      text: '$insuredAddressLabel ${insuredAddress.toDisplayValueWithFallback(fallback: labelsCopy?.emptyFieldText)}',
      style: theme.textStyles.text(
        color: active ? theme.colors.primaryText : theme.colors.inactivePolicyText,
        fontStyleWeight: FontStyleWeight.light,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    return OatsGestureDetector(
      onTap: () => policySelectedAction?.call(policyNumber ?? ''),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                policyNumberText,
                insuredAddressText,
              ],
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: policyNumber == activePolicyNumber,
            child: activePolicyIcon,
          ),
        ],
      ),
    );
  }
}
