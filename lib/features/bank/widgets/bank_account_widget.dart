import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/models/bank_account_dto.dart';
import 'package:vietqr_windows/utils/image_utils.dart';

class BankAccountWidget extends StatelessWidget {
  final double width;
  final BankAccountDTO dto;
  final VoidCallback onTap;

  BankAccountWidget({
    super.key,
    required this.width,
    required this.dto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Tooltip(
              message: dto.bankName,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.GREY),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: ImageUtils.instance.getImageNetWork(dto.imgId),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dto.bankAccount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    dto.userBankName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColor.GREY_TEXT,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),

            // Container(
            //   width: 40,
            //   height: 25,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     gradient: (dto.mmsActive)
            //         ? AppColor.YELLOW_TO_BROWN
            //         : AppColor.GRADIENT_BLUEL_TO_BLUED,
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            //   child: Text(
            //     (dto.mmsActive) ? 'Pro' : 'Plus',
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       color: AppColor.WHITE,
            //       fontSize: 12,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
