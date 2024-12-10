import 'package:vietqr_windows/commons/env/evn.dart';

class StgEnv implements Env {
  @override
  String getBankUrl() {
    return 'https://api-sandbox.mbbank.com.vn/';
  }

  @override
  String getBaseUrl() {
    return 'https://dev.vietqr.org/vqr/api/';
  }

  @override
  String getUrl() {
    return 'https://dev.vietqr.org/vqr/api';
  }

  @override
  String getImagePrefixUrl() {
    return 'https://dev.vietqr.org/vqr/api/images/';
  }

  @override
  String getBaseWss() {
    return 'wss://dev.vietqr.org/vqr/socket';
  }
}
