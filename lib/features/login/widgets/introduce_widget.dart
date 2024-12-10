import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/widgets/gradient_text.dart';

class IntroduceWidget extends StatelessWidget {
  final double width;
  const IntroduceWidget({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * (1 / 3),
            height: width * (1 / 3),
            child: Image.asset('assets/images/login-intro1.png'),
          ),
          const SizedBox(
            width: 30,
          ),
          GradientText(
            'Ứng dụng tiện ích, đơn giản\ncho cuộc sống hiện đại',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            gradient: AppColor.GRADIENT_GREEN_TO_BLUE,
          )
        ],
      ),
    );
  }
}
