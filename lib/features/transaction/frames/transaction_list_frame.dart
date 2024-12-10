import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class TransactionListFrame extends StatefulWidget {
  final double width;
  final double height;
  final Widget header1;
  final Widget header2;
  final Widget minimizeWidget;
  final Widget expandedWidget;
  final Widget footer1;
  final Widget footer2;

  TransactionListFrame({
    Key? key,
    required this.width,
    required this.height,
    required this.header1,
    required this.header2,
    required this.minimizeWidget,
    required this.expandedWidget,
    required this.footer1,
    required this.footer2,
  });

  @override
  State<StatefulWidget> createState() => _TransactionListFrame();
}

class _TransactionListFrame extends State<TransactionListFrame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: (widget.width <= 900)
          ? [
              //
              widget.header2,
              const Divider(
                color: AppColor.GREY,
                height: 1,
              ),
              Expanded(
                child: widget.minimizeWidget,
              ),
              const Divider(
                color: AppColor.GREY,
                height: 1,
              ),
              widget.footer2,
            ]
          : [
              widget.header1,
              const Divider(
                color: AppColor.GREY,
                height: 1,
              ),
              Expanded(
                child: widget.expandedWidget,
              ),
              const Divider(
                color: AppColor.GREY,
                height: 1,
              ),
              widget.footer1,
            ],
    );
  }
}
