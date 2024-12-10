import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/login/views/login_view.dart';
import 'package:vietqr_windows/features/logout/repositories/logout_repository.dart';
import 'package:vietqr_windows/main.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/tts_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/services/web_socket/web_socket_manager.dart';
import 'package:vietqr_windows/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class FooterDashboardWidget extends StatelessWidget {
  final double width;
  final WebSocketManager webSocketManager;
  final LogoutRepository _logoutRepository = const LogoutRepository();

  const FooterDashboardWidget({
    super.key,
    required this.width,
    required this.webSocketManager,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Powered by VIETQR.VN',
            style: TextStyle(
              color: AppColor.GREY_TEXT,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Đăng xuất',
            child: InkWell(
              onTap: () async {
                DialogWidget.instance.openLoadingDialog();
                bool result = await _logoutRepository.logout();
                Navigator.of(context).pop();
                if (result) {
                  await _resetServices(context).then((_) {
                    NavigationService.navigatorKey.currentState
                        ?.pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  });
                } else {
                  print('logout failed');
                }
              },
              child: const Icon(
                Icons.logout_rounded,
                color: AppColor.RED,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Future<void> _resetServices(BuildContext context) async {
    //shared preferences
    await AccountHelper.instance.initialAccountHelper();
    await UserHelper.instance.initialUserInformationHelper();
    await TtsHelper.instance.initialTtsHelper();
    //web socket
    webSocketManager.disconnect();
    //providers
    Provider.of<NotificationProvider>(context, listen: false).reset();
  }
}
