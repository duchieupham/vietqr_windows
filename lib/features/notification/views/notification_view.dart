import 'package:flutter/material.dart';
import 'package:vietqr_windows/features/notification/frames/notification_frame.dart';
import 'package:vietqr_windows/features/notification/widgets/notification_banner_widget.dart';
import 'package:vietqr_windows/features/notification/widgets/notification_footer_widget.dart';
import 'package:vietqr_windows/features/notification/widgets/notification_header_widget.dart';
import 'package:vietqr_windows/features/qr/views/qr_generator_view.dart';
import 'package:vietqr_windows/features/transaction/views/transaction_noti_view.dart';
import 'package:provider/provider.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/services/web_socket/web_socket_manager.dart';

class NotificationView extends StatelessWidget {
  final double width;
  final double height;
  final WebSocketManager webSocketManager;

  const NotificationView({
    super.key,
    required this.width,
    required this.height,
    required this.webSocketManager,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationFrame(
      width: width,
      height: height,
      widget1: NotificationHeaderWidget(width: width),
      widget2: Consumer<NotificationProvider>(
        builder: (context, setting, child) {
          return (setting.notificationType == 1)
              ? QRGeneratorView(
                  width: width, height: height, dto: setting.qrGeneratorDTO)
              : (setting.notificationType == 2)
                  ? TransactionNotiView(
                      width: width,
                      height: height,
                      dto: setting.transactionReceiveDTO,
                    )
                  : NotificationBannerWidget(width: width, height: height);
        },
      ),
      widget3: NotificationFooterWidget(
        width: width,
        webSocketManager: webSocketManager,
      ),
    );
  }
}
