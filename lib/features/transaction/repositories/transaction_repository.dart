import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/models/custom_http_res_dto.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';
import 'package:vietqr_windows/models/transaction_search_value_dto.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/utils/base_api.dart';
import 'package:vietqr_windows/utils/log.dart';

class TransactionRepository {
//type detault = 9: Get ALL
  Future<List<TransactionReceiveDTO>> getTransactions(
      TransactionSearchValueDTO dto) async {
    List<TransactionReceiveDTO> result = [];
    //https://api.vietqr.org/vqr/api/transactions/list?bankId=BNS01&type=9&offset=0&value=&from=2024-10-03^%^2000:00:00&to=2024-10-10^%^2023:59:59^
    try {
      final String url = EnvConfig.getBaseUrl();
      final String path =
          'transactions/list?bankId=${dto.bankId}&type=${dto.type}&offset=${dto.offset}&value=${dto.value}&from=${dto.fromDate}&to=${dto.toDate}';
      final String _token = AccountHelper.instance.getToken();
      Map<String, String> data = {
        'url': url + path,
        'token': _token,
      };
      final CustomHttpResponse response =
          await compute(APIClient.getAPIWithIsolate, data);
      if (response.statusCode == 200) {
        result = await compute(parseToTransactionReceiveDTO, response.body);
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }

  // //parse Json to CategoryNewsDTO
  static List<TransactionReceiveDTO> parseToTransactionReceiveDTO(
      String resBody) {
    final data = jsonDecode(resBody).cast<Map<String, dynamic>>();
    return data
            .map<TransactionReceiveDTO>(
                (json) => TransactionReceiveDTO.fromJson(json))
            .toList() ??
        [];
  }
}
