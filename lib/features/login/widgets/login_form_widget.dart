import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/login/widgets/login_input_widget.dart';
import 'package:vietqr_windows/widgets/gradient_button.dart';
import 'package:vietqr_windows/widgets/gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class LoginFormWidget extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  bool isErrPassword;

  LoginFormWidget({
    super.key,
    required this.width,
    required this.height,
    required this.phoneController,
    required this.passwordController,
    required this.isErrPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: width * (1 / 5),
                height: width * (1 / 5),
                child: Image.asset('assets/images/logo-vietqr.png'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginInputWidget(
              width: width,
              phoneController: phoneController,
              passwordController: passwordController,
              isErrPassword: isErrPassword,
            ),
            const SizedBox(
              height: 20,
            ),
            GradientButton(
              textWidget: GradientText(
                'Tôi là người dùng mới',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.BLUE,
                  fontSize: 18,
                  // fontWeight: FontWeight.w500,
                ),
                gradient: AppColor.GRADIENT_BLUEL_TO_BLUED,
              ),
              onPressed: () async {
                Uri registerUri =
                    Uri(scheme: 'https', host: 'vietqr.vn', path: 'register');
                await launchUrl(
                  registerUri,
                  mode: LaunchMode.externalApplication,
                );
              },
              width: width,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
