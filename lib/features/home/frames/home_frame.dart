import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
// import 'package:vietqr_windows/services/providers/notification_provider.dart';
// import 'package:provider/provider.dart';

class HomeFrame extends StatefulWidget {
  final double width;
  final double height;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;

  HomeFrame({
    Key? key,
    required this.width,
    required this.height,
    required this.widget1,
    required this.widget2,
    required this.widget3,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFrame();
}

class _HomeFrame extends State<HomeFrame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final notificationProvider =
    //       Provider.of<NotificationProvider>(context, listen: false);
    //   if (widget.width >= 1200) {
    //     notificationProvider.setShowingType(1);
    //     notificationProvider.setOpenPopup(false);
    //   } else {
    //     notificationProvider.setShowingType(2);
    //     notificationProvider.setOpenPopup(true);
    //   }
    // });
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: (widget.width >= 1200)
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: widget.widget1,
                ),
                Container(
                  color: AppColor.GREY,
                  height: widget.height,
                  width: 1,
                ),
                Expanded(
                  flex: 2,
                  child: widget.widget2,
                ),
                Container(
                  color: AppColor.GREY,
                  height: widget.height,
                  width: 1,
                ),
                Expanded(
                  flex: 1,
                  child: widget.widget3,
                ),
              ],
            )
          : (widget.width < 1200 && widget.width >= 900)
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: widget.widget1,
                    ),
                    Container(
                      color: AppColor.GREY,
                      height: widget.height,
                      width: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: widget.widget2,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: widget.widget2),
                  ],
                ),
    );
  }
}
