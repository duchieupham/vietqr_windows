import 'package:flutter/material.dart';
import 'package:vietqr_windows/features/transaction/frames/transaction_list_frame.dart';
import 'package:vietqr_windows/features/transaction/widgets/transaction_footer1_widget.dart';
import 'package:vietqr_windows/features/transaction/widgets/transaction_header1_widget.dart';
import 'package:vietqr_windows/features/transaction/widgets/transaction_table_widget.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';

class TransactionListView extends StatelessWidget {
  final double width;
  final double height;
  final List<TransactionReceiveDTO> dtos;

  TransactionListView({
    super.key,
    required this.width,
    required this.height,
    required this.dtos,
  });

  @override
  Widget build(BuildContext context) {
    final Widget header1 = Container(
      color: Colors.green,
      height: 60,
    );
    final Widget header2 = Container(
      color: Colors.grey,
      height: 60,
    );
    final Widget minimizeWidget = Container(
      color: Colors.yellow,
    );
    final Widget expandedWidget = Container(
      color: Colors.orange,
    );

    return SizedBox(
      width: width,
      height: height,
      child: TransactionListFrame(
        width: width,
        height: height,
        header1: TransactionHeader1Widget(
          width: width,
          height: 60,
        ),
        header2: header2,
        minimizeWidget: minimizeWidget,
        expandedWidget: TransactionTableWidget(dtos: dtos),
        footer1: TransactionFooterWidget(width: width, height: height),
        footer2: SizedBox(
          width: width,
          height: 60,
        ),
      ),
    );
  }
}
