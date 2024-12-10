import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';

class TransactionDetailAmountWidget extends StatefulWidget {
  final double width;
  final String amount;
  final String description;
  final String imageAsset;
  final Color color;

  TransactionDetailAmountWidget({
    super.key,
    required this.width,
    required this.amount,
    required this.description,
    required this.imageAsset,
    required this.color,
  });

  @override
  State<StatefulWidget> createState() => _TransactionDetailAmountWidget();
}

class _TransactionDetailAmountWidget
    extends State<TransactionDetailAmountWidget> {
  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width * 1 / 4;
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: (currentWidth <= 500)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imageAsset,
                  width: currentWidth / 3,
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.amount,
                            style: TextStyle(
                              color: widget.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' VND',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.GREY_TEXT,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(widget.description),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Image.asset(
                  widget.imageAsset,
                  width: 150,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.amount,
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' VND',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.GREY_TEXT,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(widget.description),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
    );
  }
}
