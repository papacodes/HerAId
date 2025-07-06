import 'dart:async';
import 'package:oats_package/core/keys/generic/generic_content_keys.dart';
import 'package:oats_package/core/routes.dart';
import 'package:oats_package/data/models/audit/audit_event_feature.dart';
import 'package:oats_package/data/models/audit/audit_page_detail.dart';
import 'package:oats_package/data/models/realm/content/burgerMenu/realm_burger_menu_view_content.dart';
import 'package:oats_package/data/models/realm/policy/realm_policy.dart';
import 'package:oats_package/data/models/realm/policy/realm_risk_item_summary.dart';
import 'package:oats_package/data/services/assist_service.dart';
import 'package:oats_package/data/services/feature_service.dart';
import 'package:oats_package/data/services/policy_service.dart';
import 'package:oats_package/data/services/dialog_service.dart';
import 'package:oats_package/data/services/profile_service.dart';
import 'package:oats_package/data/services/rate_app_service.dart';
import 'package:oats_package/helpers/content_locator.dart';
import 'package:oats_package/helpers/device_details_helper.dart';
import 'package:oats_package/helpers/navigation_helper.dart';
import 'package:oats_package/oats_package.dart';
import 'package:oats_package/views/base/base_viewmodel.dart';
import 'package:oats_package/views/generic/generic_content_view.dart';
import 'package:oats_package/views/my_cover/risk_items_view.dart';
import 'package:oats_package/views/my_tasks/my_tasks_view.dart';

class BurgerMenuViewModel extends BaseViewModel {
  final DialogService _dialogService = getService<DialogService>();
  final RateAppService _rateAppService = getService<RateAppService>();
  final AssistService _assistService = getService<AssistService>();
  late final FeatureService _featureService = getServiceAndListen<FeatureService>(_updateFeatures);
  late final PolicyService _policyService = getServiceAndListen<PolicyService>(_updatePolicyInfo);
  late final ProfileService _profileService = getServiceAndListen<ProfileService>(_updatePolicyInfo);

  final RealmBurgerMenuViewContent? screenCopy = ContentLocator.burgerMenuView.content;

  late String? appVersion;
  late List<RealmPolicy?> policies;

  bool hasDocumentsFeature = false;
  bool hasRateAppFeature = false;
  bool showMyCover = false;
  bool showPaymentDetails = false;
  bool showMyTasks = false;
  List<RealmRiskItemSummary> riskItemsSummary = List.empty();
  bool isPolicyHolder = false;
  String? activePolicyNumber;

  BurgerMenuViewModel() {
    _initializePackageInfo();

    _updatePolicyInfo();
    _updateFeatures();
  }

  @override
  AuditPageDetail get auditPageDetail => AuditPageDetail(
        name: screenCopy?.analyticsName,
        feature: AuditEventFeature.dashboard,
      );

  void _initializePackageInfo() async {
    setBusy(true);
    appVersion = await DeviceDetailsHelper.appVersion();
    setBusy(false);
  }

  void _updatePolicyInfo() {
    var activePolicy = _policyService.activePolicy;
    if (activePolicy != null) {
      isPolicyHolder = _profileService.isPolicyHolder;
      riskItemsSummary = activePolicy.riskItems?.riskItemsSummary.toList() ?? List.empty();
      showMyCover = riskItemsSummary.isNotEmpty;
      showPaymentDetails = _policyService.activePolicy?.hasPaymentAccounts ?? false;
      showMyTasks = _profileService.isPolicyHolder || _profileService.isRegularDriver;
      policies = _policyService.allPolicies;
      activePolicyNumber = activePolicy.policyNumber;

      notifyListeners();
    }
  }

  void navigateToHomeOnTapped() => unawaited(NavigationHelper.navigateTo(route: PackageRoutes.dashboard.path));

  void navigateToMyCoverOnTapped() {
    popBack();

    if (riskItemsSummary.length == 1 && riskItemsSummary[0].actionValue != null) {
      unawaited(
        NavigationHelper.navigateTo(
          route: PackageRoutes.riskItems.path,
          arguments: RiskItemsViewArguments(
            riskItemAction: riskItemsSummary[0].actionValue!,
            showPolicySwitcherAndInfo: true,
          ),
        ),
      );
    } else {
      unawaited(NavigationHelper.navigateTo(route: PackageRoutes.myCover.path));
    }
  }

  void navigateToDocumentsOnTapped() {
    popBack();
    unawaited(NavigationHelper.navigateTo(route: PackageRoutes.documents.path));
  }

  void navigateToAssistOnTapped() {
    popBack();
    _assistService.navigateToAssistPage();
  }

  void navigateToMyProfileOnTapped() {
    popBack();
    unawaited(NavigationHelper.navigateTo(route: PackageRoutes.myProfile.path));
  }

  void navigateToContactUsOnTapped() {
    popBack();
    unawaited(NavigationHelper.navigateTo(route: PackageRoutes.contactUs.path));
  }

  void navigateToMyTasksOnTapped() {
    popBack();
    unawaited(
      NavigationHelper.navigateTo(
        route: PackageRoutes.myTasks.path,
        arguments: TasksArguments(searchQuery: ''),
      ),
    );
  }

  void navigateToSettingsOnTapped() {
    popBack();
    unawaited(NavigationHelper.navigateTo(route: PackageRoutes.settings.path));
  }

  void navigateToPaymentDetailsOnTapped() {
    popBack();
    unawaited(NavigationHelper.navigateTo(route: PackageRoutes.paymentDetails.path));
  }

  void navigateToTermsAndConditionsOnTapped() {
    popBack();

    var termsCopy = ContentLocator.termsAndConditionsView.content;
    unawaited(
      NavigationHelper.navigateTo(
        route: PackageRoutes.termsAndConditions.path,
        arguments: GenericContentViewArguments(
          viewKey: GenericContentKeys.termsAndConditionsView,
          hasBurgerMenu: true,
          titleText: termsCopy?.titleText ?? '',
          headingText: termsCopy?.headingText ?? '',
          descriptionText: termsCopy?.descriptionText ?? '',
          genericContentViewSections:
              termsCopy?.termsAndConditionsComponents.map((e) => e.toRealmObject()).toList() ?? [],
          auditEventFeature: auditPageDetail.feature,
          analyticsName: termsCopy?.analyticsName,
        ),
      ),
    );
  }

  void navigateToFaqOnTapped() {
    popBack();

    var faqsCopy = ContentLocator.faqsView.content;
    unawaited(
      NavigationHelper.navigateTo(
        route: PackageRoutes.faqs.path,
        arguments: GenericContentViewArguments(
          viewKey: GenericContentKeys.faqsView,
          hasBurgerMenu: true,
          titleText: faqsCopy?.titleText ?? '',
          headingText: faqsCopy?.headingText ?? '',
          descriptionText: faqsCopy?.descriptionText ?? '',
          genericContentViewSections: faqsCopy?.faqsComponents.map((e) => e.toRealmObject()).toList() ?? [],
          auditEventFeature: auditPageDetail.feature,
          analyticsName: faqsCopy?.analyticsName,
        ),
      ),
    );
  }

  void navigateToPrivacyPolicyOnTapped() {
    popBack();

    var privacyPolicyCopy = ContentLocator.privacyPolicyView.content;
    unawaited(
      NavigationHelper.navigateTo(
        route: PackageRoutes.privacyPolicy.path,
        arguments: GenericContentViewArguments(
          viewKey: GenericContentKeys.privacyPolicyView,
          hasBurgerMenu: true,
          titleText: privacyPolicyCopy?.titleText ?? '',
          headingText: privacyPolicyCopy?.headingText ?? '',
          descriptionText: privacyPolicyCopy?.descriptionText ?? '',
          genericContentViewSections:
              privacyPolicyCopy?.privacyPolicyComponents.map((e) => e.toRealmObject()).toList() ?? [],
          auditEventFeature: auditPageDetail.feature,
          analyticsName: privacyPolicyCopy?.analyticsName,
        ),
      ),
    );
  }

  Future<void> rateAppTapped() => _rateAppService.openAppStore();

  Future<void> signOutOnTapped() async {
    NavigationHelper.pop();

    await Future.delayed(const Duration(milliseconds: 200));

    _dialogService.showSignOutDialog();
  }

  void _updateFeatures() {
    hasDocumentsFeature = _featureService.hasFeature(Feature.documents);
    hasRateAppFeature = _featureService.hasFeature(Feature.rateApp);
    notifyListeners();
  }

  void onPolicySelected(String policyNumber) {
    _policyService.setActivePolicyNumber(policyNumber);
    popBack();
  }
}
