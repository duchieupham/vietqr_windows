import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:flowery_tts/flowery_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class TransactionHeader1Widget extends StatelessWidget {
  final double width;
  final double height;
  final AudioPlayer player = AudioPlayer();

  TransactionHeader1Widget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Tooltip(
            message: 'Ngân hàng TMCP Quân Đội',
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.WHITE,
                border: Border.all(color: AppColor.GREY),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: Image.asset('assets/images/logo-bank-mb.png').image),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1123355589',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pham Duc Hieu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Tooltip(
            message: 'Chi tiết tài khoản ngân hàng',
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.info_outline_rounded,
                color: AppColor.BLACK,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
