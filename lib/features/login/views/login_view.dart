import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/login/frames/login_frame.dart';
import 'package:vietqr_windows/features/login/widgets/introduce_widget.dart';
import 'package:vietqr_windows/features/login/widgets/login_form_widget.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isErrPassword = false;

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.WHITE,
      body: LoginFrame(
        width: width,
        height: height,
        widget1: IntroduceWidget(
          width: width,
        ),
        widget2: LoginFormWidget(
          width: width,
          height: height,
          phoneController: _phoneController,
          passwordController: _passwordController,
          isErrPassword: _isErrPassword,
        ),
      ),
    );
  }
}
