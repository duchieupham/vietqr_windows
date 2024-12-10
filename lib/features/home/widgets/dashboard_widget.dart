import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/bank/widgets/bank_list_widget.dart';
import 'package:vietqr_windows/features/home/widgets/footer_dashboard_widget.dart';
import 'package:vietqr_windows/features/home/widgets/header_dashboard_widget.dart';
import 'package:vietqr_windows/models/bank_account_dto.dart';
import 'package:vietqr_windows/services/web_socket/web_socket_manager.dart';

class DashboardWidget extends StatelessWidget {
  final double width;
  final double height;
  final List<BankAccountDTO> dtos;
  final WebSocketManager webSocketManager;

  const DashboardWidget({
    super.key,
    required this.width,
    required this.height,
    required this.dtos,
    required this.webSocketManager,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          HeaderDashboardWidget(width: width),
          const Divider(
            color: AppColor.GREY,
            height: 1,
          ),
          Expanded(
            child: BankListWidget(
              width: width,
              height: height,
              dtos: dtos,
            ),
          ),
          const Divider(
            color: AppColor.GREY,
            height: 1,
          ),
          FooterDashboardWidget(
            width: width,
            webSocketManager: webSocketManager,
          ),
        ],
      ),
    );
  }
}
