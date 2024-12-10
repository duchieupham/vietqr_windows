import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/models/bank_account_dto.dart';
import 'package:vietqr_windows/models/custom_http_res_dto.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/utils/base_api.dart';
import 'package:vietqr_windows/utils/log.dart';

class BankAccountRepository {
  // final http.Client httpClient;

  Future<List<BankAccountDTO>> getBankAccounts() async {
    final String userId = UserHelper.instance.getUserId();
    final String url = EnvConfig.getBaseUrl();
    final String path = 'account-bank/$userId';
    List<BankAccountDTO> result = [];
    try {
      final String _token = AccountHelper.instance.getToken();
      Map<String, String> data = {
        'url': url + path,
        'token': _token,
      };
      final CustomHttpResponse response =
          await compute(APIClient.getAPIWithIsolate, data);
      if (response.statusCode == 200) {
        result = await compute(parseToBankAccountDTO, response.body);
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }

  // //parse Json to CategoryNewsDTO
  static List<BankAccountDTO> parseToBankAccountDTO(String resBody) {
    final data = jsonDecode(resBody).cast<Map<String, dynamic>>();
    return data
            .map<BankAccountDTO>((json) => BankAccountDTO.fromJson(json))
            .toList() ??
        [];
  }
}
