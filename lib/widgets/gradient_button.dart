import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class GradientButton extends StatefulWidget {
  final String? text;
  final Widget? textWidget;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final Color? color;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? borderRadius;

  GradientButton({
    this.text,
    this.textWidget,
    required this.onPressed,
    this.gradient,
    this.color,
    this.textStyle,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  double _opacity = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _opacity = 0.6; // Giảm độ mờ khi nhấn
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _opacity = 1.0; // Đặt lại độ mờ khi thả tay
    });
  }

  void _onTapCancel() {
    setState(() {
      _opacity = 1.0; // Đặt lại độ mờ nếu nhấn bị hủy
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _opacity,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          padding: (widget.width != null && widget.height != null)
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: BoxDecoration(
            gradient: widget.gradient,
            color: widget.color,
            borderRadius: (widget.borderRadius != null)
                ? BorderRadius.circular(widget.borderRadius!)
                : BorderRadius.circular(30),
          ),
          child: (widget.text != null)
              ? Text(
                  widget.text ?? '',
                  textAlign: TextAlign.center,
                  style: (widget.textStyle != null)
                      ? widget.textStyle
                      : const TextStyle(
                          color: AppColor.WHITE,
                          fontSize: 18,
                          // fontWeight: FontWeight.w500,
                        ),
                )
              : (widget.textWidget != null)
                  ? widget.textWidget
                  : const SizedBox(),
        ),
      ),
    );
  }
}
