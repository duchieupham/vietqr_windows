import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class NotificationFrame extends StatefulWidget {
  final double width;
  final double height;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;

  NotificationFrame({
    super.key,
    required this.width,
    required this.height,
    required this.widget1,
    required this.widget2,
    required this.widget3,
  });

  @override
  State<StatefulWidget> createState() => _NotificationFrame();
}

class _NotificationFrame extends State<NotificationFrame> {
  @override
  build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            width: widget.width,
            height: 60,
            child: widget.widget1,
          ),
          Container(
            color: AppColor.GREY,
            height: 1,
            width: widget.width,
          ),
          Expanded(child: widget.widget2),
          Container(
            color: AppColor.GREY,
            height: 1,
            width: widget.width,
          ),
          SizedBox(
            width: widget.width,
            height: 60,
            child: widget.widget3,
          ),
        ],
      ),
    );
  }
}
