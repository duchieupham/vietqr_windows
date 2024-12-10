import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/commons/env/env_config.dart';
import 'package:vietqr_windows/features/home/repositories/token_repository.dart';
import 'package:vietqr_windows/features/login/views/login_view.dart';
import 'package:vietqr_windows/features/logout/repositories/logout_repository.dart';
// import 'package:vietqr_windows/features/bank/repositories/bank_account_repository.dart';
// import 'package:vietqr_windows/features/home/frames/home_frame.dart';
// import 'package:vietqr_windows/features/home/widgets/dashboard_widget.dart';
import 'package:vietqr_windows/features/notification/views/notification_view.dart';
import 'package:vietqr_windows/main.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/services/shared_preferences/account_helper.dart';
import 'package:vietqr_windows/services/shared_preferences/tts_helper.dart';
// import 'package:vietqr_windows/features/transaction/repositories/transaction_repository.dart';
// import 'package:vietqr_windows/features/transaction/views/transaction_list_view.dart';
// import 'package:vietqr_windows/models/bank_account_dto.dart';
// import 'package:vietqr_windows/models/home_data_dto.dart';
// import 'package:vietqr_windows/models/transaction_receive_dto.dart';
// import 'package:vietqr_windows/models/transaction_search_value_dto.dart';
// import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/services/web_socket/web_socket_manager.dart';
import 'package:vietqr_windows/widgets/dialog_widget.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:web_socket_channel/status.dart' as status;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> with WindowListener {
  late WebSocketManager _webSocketManager;
  //home data
  // late final Future<HomeDataDTO> _homeDataFuture = _getHomeData();

  //list bank
  // final BankAccountRepository _bankAccountRepository = BankAccountRepository();

  //check token
  final TokenRepository _tokenRepository = TokenRepository();

  //logout repository
  final LogoutRepository _logoutRepository = const LogoutRepository();

//list transactions
  // final TransactionRepository _transactionRepository = TransactionRepository();

  // Future<HomeDataDTO> _getHomeData() async {
  //   List<BankAccountDTO> banks = await _getListBank();
  //   List<TransactionReceiveDTO> transactions = await _getListTransaction();
  //   HomeDataDTO result = HomeDataDTO(
  //     banks: banks,
  //     transactions: transactions,
  //   );
  //   return result;
  // }

  // Future<List<BankAccountDTO>> _getListBank() async {
  //   List<BankAccountDTO> result = [];
  //   result = await _bankAccountRepository.getBankAccounts();
  //   return result;
  // }

  // Future<List<TransactionReceiveDTO>> _getListTransaction() async {
  //   List<TransactionReceiveDTO> result = [];
  //   TransactionSearchValueDTO value = const TransactionSearchValueDTO(
  //     bankId: 'BNS01',
  //     type: 9,
  //     offset: 0,
  //     value: '',
  //     fromDate: '2024-10-08 00:00:00',
  //     toDate: '2024-10-15 23:59:59',
  //   );
  //   result = await _transactionRepository.getTransactions(value);
  //   return result;
  // }

  @override
  void initState() {
    super.initState();
    checkTokenExpired();
    windowManager.addListener(this);
    _connectWebSocket();
  }

  @override
  void dispose() {
    // _webSocketManager.disconnect();
    windowManager.removeListener(this);
    super.dispose();
  }

  int compareVersions(String version1, String version2) {
    List<int> v1Parts = version1.split('.').map(int.parse).toList();
    List<int> v2Parts = version2.split('.').map(int.parse).toList();

    for (int i = 0; i < v1Parts.length; i++) {
      if (i >= v2Parts.length) return 1; // version1 nhiều hơn version2
      if (v1Parts[i] < v2Parts[i]) return -1; // version1 nhỏ hơn version2
      if (v1Parts[i] > v2Parts[i]) return 1; // version1 lớn hơn version2
    }

    return v1Parts.length == v2Parts.length ? 0 : -1; // Nếu length khác nhau
  }

  void checkTokenExpired() {
    Future.delayed(const Duration(seconds: 0), () async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      print('currentVersion: $currentVersion');
      String version = await _tokenRepository.getAppVersion();
      print('version: $version');
      // AccountHelper.instance.setToken('abc');
      int comparison = compareVersions(version, currentVersion);
      if (comparison == 0) {
        bool value = await _tokenRepository.checkToken();
        if (!value) {
          //log out
          DialogWidget.instance.openSubmitDialog(
            title: 'Hết phiên đăng nhập',
            message:
                'Đã hết thời gian truy cập ứng dụng. Vì lý do bảo mật, Bạn vui lòng thực hiện đăng nhập lại.',
            onTap: () async {
              DialogWidget.instance.openLoadingDialog();
              bool result = await _logoutRepository.logout();
              Navigator.of(context).pop();
              if (result) {
                await _resetServices(context).then((_) {
                  NavigationService.navigatorKey.currentState?.pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                });
              } else {
                print('logout failed');
              }
            },
          );
        }
      } else if (comparison > 0) {
        DialogWidget.instance.openSubmitDialog(
          imageAsset: 'assets/images/banner-update.png',
          titleButton: 'Cập nhật ngay',
          title: 'Cập nhật ứng dụng',
          message:
              'Vui lòng cập nhật phiên bản mới của ứng dụng để mang lại trải nghiệm tuyệt vời hơn.',
          onTap: () async {
            Uri registerUri =
                Uri(scheme: 'https', host: 'pro.vietqr.vn', path: 'download');
            await launchUrl(
              registerUri,
              mode: LaunchMode.externalApplication,
            );
          },
        );
      }
    });
  }

  Future<void> _resetServices(BuildContext context) async {
    //shared preferences
    await AccountHelper.instance.initialAccountHelper();
    await UserHelper.instance.initialUserInformationHelper();
    await TtsHelper.instance.initialTtsHelper();
    //web socket
    _webSocketManager.disconnect();
    //providers
    Provider.of<NotificationProvider>(context, listen: false).reset();
  }

  void _connectWebSocket() {
    String userId = UserHelper.instance.getUserId();
    String baseWss = EnvConfig.getBaseWss();
    String wsUrl = '$baseWss?userId=$userId';
    print(userId);
    _webSocketManager = WebSocketManager(wsUrl, context);
  }

  @override
  void onWindowEvent(String eventName) {
    // print('[WindowManager] onWindowEvent: $eventName');
    // print(
    //     'check connection: ' + _webSocketManager.checkConnection().toString());
    if (_webSocketManager.checkConnection() == false) {
      _connectWebSocket();
    }
  }

  // @override
  // void onWindowClose() {
  //   print('onWindowClose');
  // }

  // @override
  // void onWindowFocus() {
  //   print('onWindowFocus');
  // }

  // @override
  // void onWindowBlur() {
  //   print('onWindowBlur');
  // }

  // @override
  // void onWindowMaximize() {
  //   print('onWindowMaximize');
  // }

  // @override
  // void onWindowUnmaximize() {
  //   print('onWindowUnmaximize');
  // }

  // @override
  // void onWindowMinimize() {
  //   print('onWindowMinimize');
  // }

  // @override
  // void onWindowRestore() {
  //   print('onWindowRestore');
  // }

  // @override
  // void onWindowResize() {
  //   print('onWindowResize');
  // }

  // @override
  // void onWindowMove() {
  //   print('onWindowMove');
  // }

  // @override
  // void onWindowEnterFullScreen() {
  //   print('onWindowEnterFullScreen');
  // }

  // @override
  // void onWindowLeaveFullScreen() {
  //   print('onWindowLeaveFullScreen');
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.WHITE,
      body: NotificationView(
        width: width,
        height: height,
        webSocketManager: _webSocketManager,
      ),
    );

    // FutureBuilder<HomeDataDTO>(
    //   future: _homeDataFuture, // Sử dụng Future đã lưu
    //   builder: (context, snapshot) {
    //     // print(
    //     //     'snapshot.connectionState:${snapshot.connectionState.toString()}');
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasError) {
    //       return const Center(child: Text('LỖI'));
    //     } else {

    // return HomeFrame(
    //   width: width,
    //   height: height,
    //   widget1: DashboardWidget(
    //     width: width,
    //     height: height,
    //     dtos: snapshot.data?.banks ?? [],
    //     webSocketManager: _webSocketManager,
    //   ),
    //   widget2: TransactionListView(
    //     width: width,
    //     height: height,
    //     dtos: snapshot.data?.transactions ?? [],
    //   ),
    //   widget3: NotificationView(
    //     width: width,
    //     height: height,
    //   ),
    // );
    // }
  }
}
