import 'package:vietqr_windows/commons/enums/authentication_type.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/utils/base_api.dart';
import 'package:vietqr_windows/utils/log.dart';

class LogoutRepository {
  const LogoutRepository();

  Future<bool> logout() async {
    bool result = false;
    try {
      final String url = '${EnvConfig.getBaseUrl()}accounts/logout';
      final response = await BaseAPIClient.postAPI(
        url: url,
        body: {'fcmToken': ''},
        type: AuthenticationType.NONE,
      );
      if (response.statusCode == 200) {
        await _resetServices().then((value) => result = true);
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }

  Future<void> _resetServices() async {
    await UserHelper.instance.initialUserInformationHelper();
    await AccountHelper.instance.initialAccountHelper();
  }
}
