import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vietqr_windows/commons/configs/numeral.dart';
import 'package:vietqr_windows/commons/enums/authentication_type.dart';
import 'package:vietqr_windows/models/custom_http_res_dto.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/utils/log.dart';

class BaseAPIClient {
  static const Duration _timeout =
      Duration(seconds: Numeral.DEFAULT_TIMEOUT_API);

  const BaseAPIClient();

  static Future<http.Response> getAPI({
    required String url,
    AuthenticationType? type,
    Map<String, String>? header,
  }) async {
    final http.Response result = await http
        .get(
      Uri.parse(url),
      headers: _getHeader(type: type, header: header),
    )
        .timeout(_timeout, onTimeout: () {
      final http.Response response = http.Response('Request Timeout', 408);
      logAPI(url: url, statusCode: response.statusCode, body: response.body);
      return response;
    });
    logAPI(url: url, statusCode: result.statusCode, body: result.body);
    return result;
  }

  static Future<http.Response> postAPI({
    required String url,
    required dynamic body,
    AuthenticationType? type,
    Map<String, String>? header,
  }) async {
    _removeBodyNullValues(body);
    final http.Response result = await http
        .post(
      Uri.parse(url),
      headers: _getHeader(type: type, header: header),
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(body),
    )
        .timeout(_timeout, onTimeout: () {
      final http.Response response = http.Response('Request Timeout', 408);
      logAPI(url: url, statusCode: response.statusCode, body: response.body);
      return response;
    });
    logAPI(url: url, statusCode: result.statusCode, body: result.body);
    return result;
  }

  static Future<http.Response> putAPI({
    required String url,
    required dynamic body,
    AuthenticationType? type,
    Map<String, String>? header,
  }) async {
    _removeBodyNullValues(body);
    final http.Response result = await http
        .put(
      Uri.parse(url),
      headers: _getHeader(type: type, header: header),
      body: jsonEncode(body),
    )
        .timeout(_timeout, onTimeout: () {
      final http.Response response = http.Response('Request Timeout', 408);
      logAPI(url: url, statusCode: response.statusCode, body: response.body);
      return response;
    });
    logAPI(url: url, statusCode: result.statusCode, body: result.body);
    return result;
  }

  static Future<http.Response> deleteAPI({
    required String url,
    required dynamic body,
    AuthenticationType? type,
    Map<String, String>? header,
  }) async {
    _removeBodyNullValues(body);
    final http.Response result = await http
        .delete(
      Uri.parse(url),
      headers: _getHeader(type: type, header: header),
      body: jsonEncode(body),
    )
        .timeout(_timeout, onTimeout: () {
      final http.Response response = http.Response('Request Timeout', 408);
      logAPI(url: url, statusCode: response.statusCode, body: response.body);
      return response;
    });
    logAPI(url: url, statusCode: result.statusCode, body: result.body);
    return result;
  }

  static Future<http.Response> postMultipartAPI({
    required String url,
    required Map<String, dynamic> fields,
    required List<http.MultipartFile> files,
  }) async {
    final Uri uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);
    final String _token = AccountHelper.instance.getToken();
    request.headers['Authorization'] = 'Bearer $_token';
    if (fields.isNotEmpty) {
      for (String key in fields.keys) {
        request.fields[key] = fields[key];
      }
    }
    if (files.isNotEmpty) {
      for (http.MultipartFile multipartFile in files) {
        request.files.add(multipartFile);
      }
    }
    final http.Response result =
        await http.Response.fromStream(await request.send());
    logAPI(url: url, statusCode: result.statusCode, body: result.body);
    return result;
  }

  static Map<String, String>? _getHeader(
      {AuthenticationType? type,
      Map<String, String>? header,
      String? clientMessageId}) {
    Map<String, String>? result = {};
    type ??= AuthenticationType.NONE;
    final String _token = AccountHelper.instance.getToken();
    final String tokenFree = AccountHelper.instance.getTokenFree();
    switch (type) {
      case AuthenticationType.SYSTEM:
        result['Authorization'] =
            'Bearer ${tokenFree.isNotEmpty ? tokenFree : _token}';
        result['Content-Type'] = 'application/json';
        result['Accept'] = '*/*';
        result['Access-Control-Allow-Origin'] = '*';
        result['Access-Control-Allow-Methods'] = 'GET,PUT,PATCH,POST,DELETE';
        result['Access-Control-Allow-Headers'] =
            'Origin, X-Requested-With, Content-Type, Accept';
        result['Access-Control-Allow-Credentials'] = 'true';
        result['Cache-Control'] = 'no-cache';
        // header('Access-Control-Allow-Origin: *');
        // header('Access-Control-Allow-Methods: GET, POST');
        // header("Access-Control-Allow-Headers: X-Requested-With");
        break;
      case AuthenticationType.NONE:
        result['Content-Type'] = 'application/json';
        result['Accept'] = '*/*';
        result['Access-Control-Allow-Origin'] = '*';
        result['Access-Control-Allow-Methods'] = 'GET,PUT,PATCH,POST,DELETE';
        result['Access-Control-Allow-Headers'] =
            'Origin, X-Requested-With, Content-Type, Accept';
        result['Access-Control-Allow-Credentials'] = 'true';
        result['Cache-Control'] = 'no-cache';
        break;
      case AuthenticationType.CUSTOM:
        result = header;
        break;
      default:
        break;
    }
    return result;
  }

  static void _removeBodyNullValues(body) {
    if (body is Map<String, dynamic>) {
      body.removeWhere(_isMapValueNull);
    } else if (body is List<Map<String, dynamic>>) {
      for (var element in body) {
        element.removeWhere(_isMapValueNull);
      }
    }
  }

  static bool _isMapValueNull(String _, dynamic value) =>
      value == null && value is! String;

  static void logAPI(
      {required String url, required int statusCode, required String body}) {
    String message = 'URL: $url - STATUS CODE: $statusCode\nRESPONSE: $body';
    if (statusCode >= 200 && statusCode <= 299) {
      LOG.info(message);
    } else {
      LOG.error(message);
    }
  }
}

//APIClient for get data from server using thread/isolate. Reduce heavy tasks of main thread/isolate.
class APIClient {
  const APIClient();

  static Future<CustomHttpResponse> getAPIWithIsolate(
      Map<String, String> data) async {
    Map<String, String>? header = {};
    header['Authorization'] = 'Bearer ${data['token']}';
    header['Content-Type'] = 'application/json';
    header['Accept'] = '*/*';
    header['Access-Control-Allow-Origin'] = '*';
    header['Access-Control-Allow-Methods'] = 'GET,PUT,PATCH,POST,DELETE';
    header['Access-Control-Allow-Headers'] =
        'Origin, X-Requested-With, Content-Type, Accept';
    header['Access-Control-Allow-Credentials'] = 'true';
    header['Cache-Control'] = 'no-cache';
    final http.Response result = await http.get(
      Uri.parse(data['url'] ?? ''),
      headers: header,
    );
    CustomHttpResponse shr = CustomHttpResponse(
      body: result.body,
      statusCode: result.statusCode,
      bodyBytes: result.bodyBytes,
    );
    return shr;
  }
}
