import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class DottedLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 1), // Chiều rộng có thể thay đổi
      painter: DottedLineWidgetPainter(),
    );
  }
}

class DottedLineWidgetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.GREY
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    double dashWidth = 5;
    double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
