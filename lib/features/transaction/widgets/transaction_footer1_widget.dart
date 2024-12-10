import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class TransactionFooterWidget extends StatelessWidget {
  final double width;
  final double height;

  TransactionFooterWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 10,
          ),
          Tooltip(
            message: 'Số hàng',
            child: Container(
              width: 60,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.GREY,
              ),
              child: const Text(
                '20',
                style: TextStyle(
                  color: AppColor.GREY_TEXT,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Text('Trang 1'),
          const SizedBox(
            width: 20,
          ),
          Tooltip(
            message: 'Trang trước',
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColor.BLACK,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Tooltip(
            message: 'Trang sau',
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.BLACK,
                size: 15,
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
