import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/bank/widgets/bank_account_widget.dart';
import 'package:vietqr_windows/models/bank_account_dto.dart';
import 'package:vietqr_windows/widgets/gradient_button.dart';
import 'package:vietqr_windows/widgets/gradient_text.dart';

class BankListWidget extends StatefulWidget {
  final double width;
  final double height;
  final List<BankAccountDTO> dtos;

  BankListWidget({
    super.key,
    required this.width,
    required this.height,
    required this.dtos,
  });

  @override
  State<StatefulWidget> createState() => _BankListWidget();
}

class _BankListWidget extends State<BankListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            width: widget.width,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                GradientButton(
                  width: 60,
                  height: 30,
                  textWidget: GradientText(
                    'Tất cả',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.BLUE,
                      fontSize: 15,
                      // fontWeight: FontWeight.w500,
                    ),
                    gradient: AppColor.GRADIENT_BLUEL_TO_BLUED,
                  ),
                  gradient: AppColor.GRADIENT_BLUEL_TO_BLUEL,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 5,
                ),
                GradientButton(
                  width: 80,
                  height: 30,
                  text: 'Đã liên kết',
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: AppColor.GREY_TEXT,
                  ),
                  onPressed: () {},
                ),
                const Spacer(),
                Tooltip(
                  message: 'Tải lại danh sách',
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: AppColor.BLACK,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const Divider(color: AppColor.GREY, height: 1),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.dtos.length,
              separatorBuilder: (context, index) => const Divider(
                color: AppColor.GREY,
                height: 1,
              ),
              itemBuilder: (context, index) => BankAccountWidget(
                width: widget.width,
                dto: widget.dtos[index],
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
