import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class TransactionDetailItemWidget extends StatefulWidget {
  final double width;
  final String title;
  final String value;

  TransactionDetailItemWidget({
    super.key,
    required this.width,
    required this.title,
    required this.value,
  });

  @override
  State<StatefulWidget> createState() => _TransactionDetailItemWidget();
}

class _TransactionDetailItemWidget extends State<TransactionDetailItemWidget> {
  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width * 1 / 4;

    return Container(
      width: widget.width,
      padding: (currentWidth <= 500)
          ? const EdgeInsets.symmetric(horizontal: 10)
          : const EdgeInsets.symmetric(horizontal: 20),
      child: (currentWidth <= 500)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: AppColor.GREY_TEXT,
                  ),
                ),
                Text(
                  widget.value,
                ),
              ],
            )
          : Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: AppColor.GREY_TEXT,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                Text(widget.value),
              ],
            ),
    );
  }
}
