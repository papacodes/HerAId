import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mzala/core/models/http_service/http_error.dart';
import 'package:mzala/res/navigator.dart';

class BaseHttpService {
  Future<Map<String, String>> getHeaders(bool mustAuthenticated) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    if (mustAuthenticated) {
      try {
        // Retrieve the authentication token from secure storage
        const storage = FlutterSecureStorage();
        String? token = await storage.read(key: 'token');
        headers['Authorization'] = 'Bearer $token';
      } catch (e) {
        return headers;
      }
    }
    return headers;
  }

  void handleUnAuthenticated(statusCode, shouldNavigate) {
    if (statusCode == 401) {
      if (shouldNavigate) {
        // NavigatorHelper.replaceAll(const LoginView());
      } else {
        throw HttpError(
          message: 'Unauthorized',
        );
      }
    }
  }
}
