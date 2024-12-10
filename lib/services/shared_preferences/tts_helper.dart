import 'package:vietqr_windows/main.dart';

class TtsHelper {
  const TtsHelper._privateConsrtructor();

  static const TtsHelper _instance = TtsHelper._privateConsrtructor();
  static TtsHelper get instance => _instance;

  Future<void> initialTtsHelper() async {
    await sharedPrefs.setString('TTS_PREFIX', 'Thanh toán thành công ');
    await sharedPrefs.setString('TTS_UNIT', ' đồng. ');
    await sharedPrefs.setString('TTS_SUFFIX', 'Xin cảm ơn quý khách.');
  }

  Future<void> setPrefix(String value) async {
    await sharedPrefs.setString('TTS_PREFIX', value);
  }

  Future<void> setUnit(String value) async {
    await sharedPrefs.setString('TTS_UNIT', value);
  }

  Future<void> setSuffix(String value) async {
    await sharedPrefs.setString('TTS_SUFFIX', value);
  }

  String getPrefix() {
    return sharedPrefs.getString('TTS_PREFIX') ?? '';
  }

  String getUnit() {
    return sharedPrefs.getString('TTS_UNIT') ?? '';
  }

  String getSuffix() {
    return sharedPrefs.getString('TTS_SUFFIX') ?? '';
  }
}
