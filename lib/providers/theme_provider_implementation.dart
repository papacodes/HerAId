import 'dart:async';
import 'dart:convert';
import 'package:app_theme/data/models/theme/theme.dart' as theme;
import 'package:app_theme/helpers/debug_helper.dart';
import 'package:app_theme/providers/theme_provider.dart';

class ThemeProviderImplementation extends ThemeProvider {
  Completer<void> initializationCompleter = Completer<void>();

  ThemeProviderImplementation({required super.isDarkMode});

  @override
  void loadTheme() {
    _updateThemeAndNotify();
  }

  @override
  Future<void> updateTheme() async {}

  void _updateThemeAndNotify() {
    try {
      _updateThemesFromRealm();
      notifyListeners();
    } catch (e, stackTrace) {
      printError(e.toString());
      // Logger.logException(e, stackTrace);
    } finally {
      initializationCompleter.complete();
    }
  }

  void _updateThemesFromRealm() {
    try {
      var themeDataJson = '{}';
      //_themeRealmService.themeData;

      if (themeDataJson != null) {
        Map<String, dynamic> valueMap = json.decode(themeDataJson);
        lightTheme = theme.ThemeData.themeFromJson(valueMap['themeLight']);

        if (valueMap.keys.contains('themeDark')) {
          darkTheme = theme.ThemeData.themeFromJson(valueMap['themeDark']);
        } else {
          printWarning('Dark Theme Not Provided, switching to light as default');

          darkTheme = lightTheme;
        }
      }
    } catch (e, stackTrace) {
      printError(e.toString());
      // Logger.logException(e, stackTrace);
    }
  }
}
