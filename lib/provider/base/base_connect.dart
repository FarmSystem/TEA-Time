import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

abstract class BaseConnect extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = dotenv.env['REST_API_HOST']
      ..defaultContentType = "application/json"
      ..timeout = const Duration(seconds: 30)
      ..addRequestModifier<dynamic>((request) {
        request.headers['Authorization'] =
        'Bearer ';

        logOnDev("🛫 [${request.method}] ${request.url} | START");
        return request;
      })
      ..addResponseModifier((request, Response response) {
        if (response.status.hasError) {
          logOnDev(
            "[${request.method}] ${request.url} | FAILED (${response.statusCode})",
          );
        } else {
          logOnDev(
            "[${request.method}] ${request.url} | SUCCESS (${response.statusCode})",
          );
          logOnDev(
            "[${request.method}] ${request.url} | BODY ${response.body}",
          );
        }
        return response;
      });
  }
}
