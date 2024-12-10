import 'dart:convert';

import 'package:vietqr_windows/commons/enums/authentication_type.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/models/custom_http_res_dto.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/utils/base_api.dart';
import 'package:vietqr_windows/utils/log.dart';
import 'package:flutter/foundation.dart';

class TokenRepository {
  Future<bool> checkToken() async {
    bool result = false;
    try {
      final String url = EnvConfig.getBaseUrl();
      final String path = 'token';
      final String _token = AccountHelper.instance.getToken();
      Map<String, String> data = {
        'url': url + path,
        'token': _token,
      };
      final CustomHttpResponse response =
          await compute(APIClient.getAPIWithIsolate, data);
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }

  Future<String> getAppVersion() async {
    String result = '';
    try {
      final String url = EnvConfig.getBaseUrl();
      final String path = 'system-setting/windows-version';
      final response = await BaseAPIClient.getAPI(
        url: url + path,
        type: AuthenticationType.NONE,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        result = data['windowsVersion'] ?? '';
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }
}
