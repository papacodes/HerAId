import 'package:json_annotation/json_annotation.dart';

enum RequestStatus { success, failed, unauthorized }

@JsonSerializable()
class HttpResponse {
  final Map<String, dynamic> data;
  final RequestStatus status;
  final String? message;
  HttpResponse(
      {required this.data, required this.status, required this.message});
}
