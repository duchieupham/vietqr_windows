import 'dart:convert';

import 'package:vietqr_windows/commons/enums/authentication_type.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/models/account_information_dto.dart';
import 'package:vietqr_windows/models/account_login_dto.dart';
import 'package:vietqr_windows/models/response_message_dto.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/utils/base_api.dart';
import 'package:vietqr_windows/utils/log.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginRepository {
  const LoginRepository();

  Future checkExistedPhone(String phone) async {
    try {
      String url = '${EnvConfig.getBaseUrl()}accounts/search/$phone';
      final response = await BaseAPIClient.getAPI(
        url: url,
        type: AuthenticationType.NONE,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null) {
          return AccountInformationDTO.fromJson(data);
        }
      } else {
        var data = jsonDecode(response.body);
        if (data != null) {
          return ResponseMessageDTO(
            status: data['status'],
            message: data['message'],
          );
        }
      }
    } catch (e) {
      LOG.error(e.toString());
    }
  }

  Future<bool> login(AccountLoginDTO dto) async {
    bool result = false;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String url = '${EnvConfig.getBaseUrl()}accounts';
      String fcmToken = '';
      String platform = '';
      String device = '';
      String sharingCode = '';
      platform = 'WINDOWS';
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
      device = windowsDeviceInfo.deviceId.toString();
      AccountLoginDTO loginDTO = AccountLoginDTO(
        phoneNo: dto.phoneNo,
        password: dto.password,
        platform: platform,
        device: device,
        fcmToken: fcmToken,
        sharingCode: sharingCode,
      );
      final response = await BaseAPIClient.postAPI(
        url: url,
        body: loginDTO.toJson(),
        type: AuthenticationType.NONE,
      );
      if (response.statusCode == 200) {
        String token = response.body;
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        AccountInformationDTO accountInformationDTO =
            AccountInformationDTO.fromJson(decodedToken);

        await AccountHelper.instance.setFcmToken(fcmToken);
        await AccountHelper.instance.setToken(token);
        await AccountHelper.instance.setTokenFree('');
        await UserHelper.instance.setPhoneNo(dto.phoneNo);
        await UserHelper.instance.setUserId(accountInformationDTO.userId);
        await UserHelper.instance.setAccountInformation(accountInformationDTO);
        result = true;
      }
    } catch (e) {
      LOG.error(e.toString());
    }
    return result;
  }
}
