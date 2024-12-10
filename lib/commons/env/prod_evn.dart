import 'package:vietqr_windows/commons/env/evn.dart';

class ProdEnv implements Env {
  @override
  String getBankUrl() {
    return '';
  }

  @override
  String getBaseUrl() {
    return 'https://api.vietqr.org/vqr/api/';
  }

  @override
  String getUrl() {
    return 'https://api.vietqr.org/vqr/';
  }

  @override
  String getImagePrefixUrl() {
    return 'https://api.vietqr.org/vqr/api/images/';
  }

  @override
  String getBaseWss() {
    return 'wss://api.vietqr.org/vqr/socket';
  }
}
