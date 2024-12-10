import 'package:flutter/material.dart';
import 'package:vietqr_windows/features/home/views/home_view.dart';
import 'package:vietqr_windows/features/login/views/login_view.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/tts_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';

import 'package:provider/provider.dart';

//Share Preferences
late SharedPreferences sharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  await _initialServiceHelper();
  runApp(const VietQRWindows());
}

Future<void> _initialServiceHelper() async {
  if (!sharedPrefs.containsKey('TOKEN') ||
      sharedPrefs.getString('TOKEN') == null) {
    await AccountHelper.instance.initialAccountHelper();
  }
  if (!sharedPrefs.containsKey('USER_ID') ||
      sharedPrefs.getString('USER_ID') == null) {
    await UserHelper.instance.initialUserInformationHelper();
  }
  if (!sharedPrefs.containsKey('TTS_PREFIX') ||
      sharedPrefs.getString('TTS_PREFIX') == null) {
    await TtsHelper.instance.initialTtsHelper();
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class VietQRWindows extends StatelessWidget {
  const VietQRWindows({super.key});

  static Widget _mainScreen = LoginView();

  String get userId => UserHelper.instance.getUserId().trim();

  @override
  Widget build(BuildContext context) {
    _mainScreen = (userId.isNotEmpty) ? const HomeView() : LoginView();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        home: _mainScreen,
      ),
    );
  }
}
