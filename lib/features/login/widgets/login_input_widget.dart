import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/commons/configs/widget_setting.dart';
import 'package:vietqr_windows/features/home/views/home_view.dart';
import 'package:vietqr_windows/features/login/repositories/login_repository.dart';
import 'package:vietqr_windows/models/account_login_dto.dart';
import 'package:vietqr_windows/utils/encrypt_utils.dart';
import 'package:vietqr_windows/utils/log.dart';
import 'package:vietqr_windows/widgets/dialog_widget.dart';
import 'package:vietqr_windows/widgets/gradient_button.dart';
import 'package:vietqr_windows/main.dart';

// ignore: must_be_immutable
class LoginInputWidget extends StatefulWidget {
  final double width;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  LoginRepository loginRepository = const LoginRepository();
  bool isErrPassword;

  LoginInputWidget({
    super.key,
    required this.width,
    required this.phoneController,
    required this.passwordController,
    required this.isErrPassword,
  });

  @override
  State<StatefulWidget> createState() => _LoginInputWidget();
}

class _LoginInputWidget extends State<LoginInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLength: 10,
          controller: widget.phoneController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            labelText: 'Số điện thoại*',
            hintText: 'Nhập số điện thoại',
            hintStyle: WidgetSetting.HINT_STYLE,
            labelStyle: WidgetSetting.HINT_STYLE,
            counterText: '',
            floatingLabelStyle: WidgetSetting.LABEL_TEXT_FIELD_STYLE,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.BLUE, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.BLUE, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.GREY, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.RED, width: 2.0),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          obscureText: true,
          maxLength: 6,
          controller: widget.passwordController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            labelText: 'Mật khẩu* (6 ký tự)',
            hintText: '••••••',
            hintStyle: WidgetSetting.HINT_STYLE,
            labelStyle: WidgetSetting.HINT_STYLE,
            counterText: '',
            floatingLabelStyle: WidgetSetting.LABEL_TEXT_FIELD_STYLE,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.BLUE, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.BLUE, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.GREY, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.RED, width: 2.0),
            ),
          ),
        ),
        Visibility(
          visible: widget.isErrPassword,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Số điện thoại hoặc mật khẩu không chính xác.\nVui lòng kiểm tra lại thông tin đăng nhập.',
              style: TextStyle(
                color: AppColor.RED,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        GradientButton(
          text: 'Đăng nhập',
          color: (!_isValidLoginForm()) ? AppColor.GREY_BUTTON : null,
          gradient:
              (_isValidLoginForm()) ? AppColor.GRADIENT_BLUEL_TO_BLUED : null,
          textStyle: TextStyle(
            color: (_isValidLoginForm()) ? AppColor.WHITE : AppColor.BLACK,
            fontSize: 18,
            // fontWeight: FontWeight.w500,
          ),
          onPressed: () async {
            await _login(
              widget.phoneController.text.trim(),
              widget.passwordController.text.trim(),
            );
          },
          width: widget.width,
          height: 50,
        ),
      ],
    );
  }

  bool _isValidLoginForm() {
    bool result = false;
    result = _isValidPhoneNo() && _isValidPassword();
    return result;
  }

  bool _isValidPhoneNo() {
    bool result = false;
    result = widget.phoneController.text.length == 10 &&
        widget.phoneController.text.startsWith('0', 0) &&
        (int.tryParse(widget.phoneController.text) != null);
    return result;
  }

  bool _isValidPassword() {
    bool result = false;
    result = widget.passwordController.text.length == 6 &&
        (int.tryParse(widget.passwordController.text) != null);
    return result;
  }

  Future<void> _login(String phoneNo, String password) async {
    bool result = false;
    try {
      String passwordEncrypted =
          EncryptUtils.instance.encrypted(phoneNo, password);
      AccountLoginDTO dto = AccountLoginDTO(
        phoneNo: phoneNo,
        password: passwordEncrypted,
        platform: '',
        device: '',
        fcmToken: '',
        sharingCode: '',
      );
      //open loading dialog
      DialogWidget.instance.openLoadingDialog();
      //call login method
      result = await widget.loginRepository.login(dto);
      Navigator.pop(context);
      if (result) {
        widget.isErrPassword = false;
        setState(() {});
        NavigationService.navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        widget.isErrPassword = true;
        setState(() {});
      }
    } catch (e) {
      LOG.error(e.toString());
    }
  }
}
