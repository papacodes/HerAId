import 'dart:async';
import 'package:oats_package/data/models/audit/audit_event_feature.dart';
import 'package:oats_package/data/models/audit/audit_page_detail.dart';
import 'package:oats_package/data/models/realm/content/burgerMenu/realm_contact_us_view_content.dart';
import 'package:oats_package/data/models/realm/content/realm_configuration_content.dart';
import 'package:oats_package/data/services/external_url_service.dart';
import 'package:oats_package/helpers/content_locator.dart';
import 'package:oats_package/oats_package.dart';
import 'package:oats_package/views/base/sub_viewmodel.dart';

class ContactUsViewModel extends SubViewModel {
  final ExternalUrlService _externalUrlService = getService<ExternalUrlService>();

  final RealmConfigurationContent? _configurationContent = ContentLocator.configuration.content;
  final RealmContactUsViewContent? screenCopy = ContentLocator.contactUsView.content;

  ContactUsViewModel();

  @override
  AuditPageDetail get auditPageDetail => AuditPageDetail(
        name: screenCopy?.analyticsName,
        feature: AuditEventFeature.general,
      );

  Future<void> callMedicalAssistance() async =>
      _externalUrlService.callNumber(_configurationContent?.medicalAssistanceNumber);

  Future<void> callPolicyServices() async =>
      _externalUrlService.callNumber(_configurationContent?.policyServicesNumber);

  Future<void> openWebsite() async => _externalUrlService.openWebsite(_configurationContent?.websiteUrl);
}
