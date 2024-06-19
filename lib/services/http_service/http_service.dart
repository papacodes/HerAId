import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:her_aid/constants/service_constants.dart';
import 'package:her_aid/models/http_service/http_error.dart';
import 'package:her_aid/models/http_service/http_response.dart';
import 'package:her_aid/services/http_service/base_http_service.dart';

class HttpService extends BaseHttpService {
  // Send an HTTP request and handle the response
  Future<HttpResponse> _sendRequest(
      {required String method,
      required String endpoint,
      required bool mustAuthenticated,
      dynamic data,
      bool shouldNavigate = true}) async {
    try {
      var url = Uri.parse("${ServiceConstants.baseURL}$endpoint");

      var request = http.Request(method, url)..headers.addAll(await getHeaders(mustAuthenticated));

      if (data != null) {
        request.bodyFields = data.toMap();
        // request.body = jsonEncode(data.toMap());
      }

      http.StreamedResponse response = await request.send();
      var resData = await response.stream.bytesToString();
      dynamic responseData = jsonDecode(resData);
      // Debugging output for request and response
      log("=======");
      log("🗣️ Sending $method request to $url");
      log("🗣️ Sending data ${data ?? data!.toMap()}");
      log("🗣️ Status code: ${response.statusCode}");
      log("🗣️ Body: $resData");
      log("=======");

      handleUnAuthenticated(response.statusCode, shouldNavigate);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpResponse(
          status: RequestStatus.success,
          message: responseData['message'],
          data: responseData['data'],
        );
      }

      // Failed response
      throw HttpError(
          message: responseData['message'].runtimeType == List
              ? (responseData['message'] as List).first
              : responseData['message']);
    } on SocketException {
      // Handle network connectivity errors
      throw HttpError(message: "Unable to connect to the server");
    } on TimeoutException {
      // Handle request timeout
      throw HttpError(message: 'The request is timed out');
    } catch (e) {
      // Handle other errors
      debugPrint('An error thrown : $e');
      if (e.runtimeType == HttpError) {
        rethrow;
      }
      throw HttpError(message: "Something went wrong");
    }
  }

  // GET Request
  Future<HttpResponse> get({
    required String endpoint,
    required bool mustAuthenticated,
    dynamic data,
    bool shouldNavigate = true,
  }) async {
    return _sendRequest(
      method: "GET",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // PUT Request
  Future<HttpResponse> put(
      {required dynamic data,
      bool shouldNavigate = true,
      required String endpoint,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "PUT",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // DELETE Request
  Future<HttpResponse> delete(
      {required dynamic data, required String endpoint, required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "DELETE",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // POST Request
  Future<HttpResponse> post(
      {required dynamic data, required String endpoint, String? baseURL, bool? isProtected}) async {
    return _sendRequest(
      method: "POST",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: isProtected ?? true,
    );
  }
}
