import 'package:flutter/material.dart';
import 'package:oats_package/core/keys/main/dashboard_keys.dart';
import 'package:oats_package/data/models/api/policy/policy_status.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_labels_content.dart';
import 'package:oats_package/data/models/realm/policy/realm_policy.dart';
import 'package:oats_package/helpers/extensions/string_extensions.dart';
import 'package:oats_package/views/burger_menu/widgets/policy_row.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:provider/provider.dart';

class PoliciesListCard extends StatelessWidget {
  final RealmLabelsContent? labelsCopy;
  final List<RealmPolicy?> policies;
  final String? activePolicyNumberLabel;
  final String? inactivePolicyNumberLabel;
  final String? insuredAddressLabel;
  final String? activePolicyNumber;
  final bool addHorizontalPadding;
  final void Function(String)? policySelectedAction;

  const PoliciesListCard({
    required this.labelsCopy,
    required this.policies,
    required this.activePolicyNumberLabel,
    required this.inactivePolicyNumberLabel,
    required this.insuredAddressLabel,
    required this.activePolicyNumber,
    required this.policySelectedAction,
    this.addHorizontalPadding = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < policies.length; i++) ...[
          if (i != 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.paddingSize.small),
              child: OatsDivider.fromTheme(),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: addHorizontalPadding ? theme.paddingSize.small : 0,
              vertical: theme.paddingSize.small,
            ),
            child: PolicyRow(
              key: DashboardKeys.policySelectorView(i),
              count: i,
              context: context,
              labelsCopy: labelsCopy,
              activePolicyNumberLabel: activePolicyNumberLabel,
              inactivePolicyNumberLabel: inactivePolicyNumberLabel,
              policyNumber: policies[i]?.policyNumber,
              insuredAddress:
                  policies[i]?.home?.riskAddress.toDisplayValueWithFallback(fallback: labelsCopy?.emptyFieldText),
              active: policies[i]?.home?.policyStatusValue?.isPolicyActive() ?? false,
              insuredAddressLabel: insuredAddressLabel,
              activePolicyNumber: activePolicyNumber,
              policySelectedAction: policySelectedAction,
            ),
          ),
        ],
      ],
    );
  }
}
