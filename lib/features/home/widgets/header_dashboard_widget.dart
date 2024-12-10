import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/services/shared_preferences/user_information_helper.dart';
import 'package:vietqr_windows/utils/image_utils.dart';

class HeaderDashboardWidget extends StatelessWidget {
  final double width;

  const HeaderDashboardWidget({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final String imgId = UserHelper.instance.getAccountInformation().imgId;
    final String fullName =
        UserHelper.instance.getAccountInformation().firstName.trim();
    return SizedBox(
      width: width,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 60,
            child: Image.asset('assets/images/logo-vietqr.png'),
          ),
          const Spacer(),
          Text(
            fullName,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              //
            },
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: AppColor.GRADIENT_BLUEL_TO_BLUED,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (imgId.isNotEmpty)
                          ? ImageUtils.instance.getImageNetWork(imgId)
                          : Image.asset('assets/images/ic-avatar.png').image),
                ),
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
