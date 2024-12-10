import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/transaction/widgets/transaction_detail_amount_widget.dart';
import 'package:vietqr_windows/features/transaction/widgets/transaction_detail_item_widget.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';
import 'package:vietqr_windows/widgets/dot_line_widget.dart';
import 'package:provider/provider.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:flowery_tts/flowery_tts.dart';

import 'package:audioplayers/audioplayers.dart';

class TransactionNotiView extends StatefulWidget {
  final double width;
  final double height;
  final TransactionReceiveDTO dto;

  const TransactionNotiView({
    super.key,
    required this.width,
    required this.height,
    required this.dto,
  });

  @override
  State<StatefulWidget> createState() => _TransactionNotiView();
}

class _TransactionNotiView extends State<TransactionNotiView> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    print('go to init state');
    _processVoice();
    _closePopup();
  }

  void _closePopup() {
    print('go to close popup');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        Provider.of<NotificationProvider>(context, listen: false).reset();
      }
    });
    // });
  }

  @override
  void dispose() {
    print('go to dispose');
    super.dispose();
  }

  void _processVoice() async {
    if (widget.dto.transType.trim() == 'C') {
      if (Provider.of<NotificationProvider>(context, listen: false)
              .isVoiceOff ==
          false) {
        print('go to processvoice');
        if (!widget.dto.amount.contains('*')) {
          try {
            const flowery = Flowery();
            final audio = await flowery.tts(
                text:
                    'Thanh toán thành công, ${_processAmount(widget.dto.amount)} đồng',
                voice: 'Phuong');
            final file = File('audio.mp3')..writeAsBytesSync(audio);
            print('Saved audio file at "${file.absolute.path}".');
            await player.stop();
            await player.play(BytesSource(file.readAsBytesSync()));
          } catch (e) {
            print(e.toString());
          }
        }
      }
    }
  }

  String _processAmount(String amount) {
    return amount.replaceAll(',', '');
  }

  @override
  Widget build(BuildContext context) {
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
            TransactionDetailAmountWidget(
              width: widget.width,
              amount:
                  '${_getPrefix(widget.dto.transType)} ${widget.dto.amount}',
              description: 'Thanh toán thành công',
              imageAsset: _getImageAssets(
                widget.dto.transType,
                widget.dto.type,
              ),
              color: _getColor(
                widget.dto.transType,
                widget.dto.status,
                widget.dto.type,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Mã giao dịch',
              value: _getValue(widget.dto.referenceNumber),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DottedLineWidget(),
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Thời gian thanh toán',
              value: widget.dto.timePaid.toString(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DottedLineWidget(),
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Tài khoản',
              value: _getValue(
                  '${widget.dto.bankCode} - ${widget.dto.bankAccount}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DottedLineWidget(),
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Đơn hàng',
              value: _getValue(widget.dto.orderId),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DottedLineWidget(),
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Điểm bán',
              value: _getValue(widget.dto.rawTerminalCode),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DottedLineWidget(),
            ),
            TransactionDetailItemWidget(
              width: widget.width,
              title: 'Nội dung thanh toán',
              value: _getValue(widget.dto.content),
            ),
          ],
        ),
      ),
    );
  }

  String _getPrefix(String transType) {
    String result = '';
    if (transType.trim().toUpperCase() == 'C') {
      result = '+';
    } else if (transType.trim().toUpperCase() == 'D') {
      result = '-';
    }
    return result;
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

  String _getImageAssets(String transType, int type) {
    String result = '';
    if (transType == 'D') {
      result = 'assets/images/ic-success-out.png';
    } else if (transType == 'C' && (type == 1 || type == 4 || type == 5)) {
      result = 'assets/images/ic-success-in-green.png';
    } else if (transType == 'C' && (type != 1 && type != 4 && type != 5)) {
      result = 'assets/images/ic-success-in-blue.png';
    }
    return result;
  }

  String _getValue(String value) {
    String result = '-';
    if (value.trim().isNotEmpty || value.trim() != '-') {
      result = value;
    }
    return result;
  }
}
