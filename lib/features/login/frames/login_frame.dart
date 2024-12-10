import 'package:flutter/material.dart';

class LoginFrame extends StatefulWidget {
  final double width;
  final double height;
  final Widget widget1;
  final Widget widget2;

  LoginFrame({
    Key? key,
    required this.width,
    required this.height,
    required this.widget1,
    required this.widget2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFrame();
}

class _LoginFrame extends State<LoginFrame> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: (widget.width < 600)
          ? Column(
              children: [
                Expanded(child: widget.widget2),
              ],
            )
          : Row(
              children: [
                Expanded(child: widget.widget1),
                Expanded(child: widget.widget2),
              ],
            ),
    );
  }
}
