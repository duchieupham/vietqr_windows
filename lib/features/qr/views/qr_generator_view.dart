import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/models/qr_generator_dto.dart';
import 'package:provider/provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:vietqr_windows/utils/image_utils.dart';

class QRGeneratorView extends StatefulWidget {
  final double width;
  final double height;
  final QRGeneratorDTO dto;

  const QRGeneratorView({
    super.key,
    required this.width,
    required this.height,
    required this.dto,
  });

  @override
  State<StatefulWidget> createState() => _QRGeneratorView();
}

class _QRGeneratorView extends State<QRGeneratorView> {
  void _closePopup() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          Provider.of<NotificationProvider>(context, listen: false).reset();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _closePopup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _closePopup();
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: AppColor.GREY,
                      ),
                      image: DecorationImage(
                        image: ImageUtils.instance
                            .getImageNetWork(widget.dto.imgId),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dto.bankAccount,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.dto.userBankName.trim().toUpperCase(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: 300,
              child: const Divider(
                height: 1,
                color: AppColor.GREY,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 300,
                height: 300,
                child: PrettyQrView.data(
                  data: widget.dto.qr,
                  decoration: const PrettyQrDecoration(
                    shape: PrettyQrRoundedSymbol(),
                    image: PrettyQrDecorationImage(
                      image: AssetImage('assets/images/ic-viet-qr-small.png'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo-vietqr.png',
                    height: 40,
                    width: 100,
                  ),
                  Image.asset(
                    'assets/images/ic-napas247.png',
                    height: 40,
                    width: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Quét mã VietQR để thanh toán',
              textAlign: TextAlign.center,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '+ ${widget.dto.amount}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: _getColor(
                        widget.dto.transType,
                        widget.dto.status,
                        widget.dto.type,
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: ' VND',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.GREY_TEXT,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: Text(
                widget.dto.content.trim(),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String transType, int status, int type) {
    Color result = AppColor.BLACK;
    if (transType == 'C' && status == 0) {
      result = AppColor.ORANGE;
    } else if (transType == 'C' &&
        status == 1 &&
        (type == 1 || type == 4 || type == 5)) {
      result = AppColor.GREEN;
    } else if (transType == 'C' &&
        status == 1 &&
        ((type != 1 && type != 4 && type != 5))) {
      result = AppColor.BLUE;
    } else if (transType == 'D') {
      result = AppColor.RED;
    }
    return result;
  }
}
