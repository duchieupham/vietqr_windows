import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vietqr_windows/widgets/gradient_text.dart';

class DialogWidget {
  //
  const DialogWidget._privateConstructor();

  static const DialogWidget _instance = DialogWidget._privateConstructor();

  static DialogWidget get instance => _instance;

  static bool isPopLoading = false;

  void openLoadingDialog({String msg = ''}) async {
    if (!isPopLoading) {
      isPopLoading = true;
      return await showDialog(
          barrierDismissible: false,
          context: NavigationService.navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return Material(
              color: AppColor.TRANSPARENT,
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.WHITE,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //staggeredDotsWave
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColor.BLUE,
                        size: 50,
                      ),
                      if (msg.isNotEmpty) ...[
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          msg,
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            );
          }).then((value) => isPopLoading = false);
    }
  }

  void openSubmitDialog(
      {String imageAsset = '',
      String titleButton = '',
      required String title,
      required String message,
      required VoidCallback onTap}) async {
    return await showDialog(
      barrierDismissible: false,
      context: NavigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Material(
          color: AppColor.TRANSPARENT,
          child: Center(
            child: Container(
              width: 300,
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.WHITE,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    (imageAsset.trim().isEmpty)
                        ? 'assets/images/ic-warning.png'
                        : imageAsset,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const Divider(
                    height: 1,
                    color: AppColor.GREY,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: GradientText(
                        (titleButton.trim().isEmpty)
                            ? 'Tôi đã hiểu'
                            : titleButton,
                        textAlign: TextAlign.center,
                        style: const TextStyle(),
                        gradient: AppColor.GRADIENT_BLUEL_TO_BLUED,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void openSettingDialog() async {
  //   final String imgId = UserHelper.instance.getAccountInformation().imgId;
  //   final String fullName = UserHelper.instance.getUserFullName().trim();
  //   final String phoneNo = StringUtils.instance
  //       .formatPhoneNumberVN(UserHelper.instance.getPhoneNo().trim());
  //   return await showDialog(
  //       barrierDismissible: true,
  //       context: NavigationService.navigatorKey.currentContext!,
  //       builder: (BuildContext context) {
  //         return Material(
  //           color: AppColor.TRANSPARENT,
  //           child: Center(
  //             child: Container(
  //               width: 250,
  //               height: 350,
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context).cardColor,
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   const Padding(padding: EdgeInsets.only(top: 10)),
  //                   Align(
  //                     alignment: Alignment.centerRight,
  //                     child: InkWell(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: const Icon(
  //                         Icons.close,
  //                         color: AppColor.GREY_TEXT,
  //                         size: 15,
  //                       ),
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(top: 10)),
  //                   Container(
  //                     width: 45,
  //                     height: 45,
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       image: DecorationImage(
  //                           fit: BoxFit.cover,
  //                           image: (imgId.isNotEmpty)
  //                               ? ImageUtils.instance.getImageNetWork(imgId)
  //                               : Image.asset('assets/images/ic-avatar.png')
  //                                   .image),
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(top: 10)),
  //                   Text(
  //                     'Xin chào, $fullName!',
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     textAlign: TextAlign.center,
  //                     style: const TextStyle(
  //                       fontSize: 13,
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(top: 3)),
  //                   Text(
  //                     phoneNo,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     textAlign: TextAlign.center,
  //                     style: const TextStyle(
  //                       fontSize: 12,
  //                       color: AppColor.GREY_TEXT,
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.symmetric(vertical: 10),
  //                     child: Divider(
  //                       color: AppColor.GREY_VIEW,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   ButtonWidget(
  //                     text: 'Đăng xuất',
  //                     height: 40,
  //                     fontSize: 13,
  //                     textColor: AppColor.RED_TEXT,
  //                     bgColor: AppColor.TRANSPARENT,
  //                     function: () async {
  //                       await _logoutRepository.logout().then(
  //                         (value) {
  //                           js.context.callMethod('logoutUser');
  //                           Navigator.pop(context);
  //                           if (value) {
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (_) => const LoginView(),
  //                               ),
  //                             );
  //                           }
  //                         },
  //                       );
  //                     },
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(bottom: 10)),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void openMsgDialog({required String title, required String message}) async {
  //   return await showDialog(
  //       barrierDismissible: true,
  //       context: NavigationService.navigatorKey.currentContext!,
  //       builder: (BuildContext context) {
  //         return Material(
  //           color: AppColor.TRANSPARENT,
  //           child: Center(
  //             child: Container(
  //               width: 250,
  //               height: 320,
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context).cardColor,
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   const Spacer(),
  //                   Image.asset(
  //                     'assets/images/ic-notice.png',
  //                     width: 80,
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(top: 10)),
  //                   Text(
  //                     title,
  //                     textAlign: TextAlign.center,
  //                     style: const TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(top: 5)),
  //                   Text(
  //                     message,
  //                     textAlign: TextAlign.center,
  //                     style: const TextStyle(
  //                       fontSize: 12,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   ButtonWidget(
  //                     text: 'Trang chủ',
  //                     height: 40,
  //                     width: 200,
  //                     borderRadius: 5,
  //                     fontSize: 13,
  //                     textColor: AppColor.WHITE,
  //                     bgColor: AppColor.BLUE_TEXT,
  //                     function: () async {
  //                       Navigator.popUntil(context, (route) => route.isFirst);
  //                     },
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(bottom: 5)),
  //                   ButtonWidget(
  //                     text: 'Đóng',
  //                     height: 40,
  //                     width: 200,
  //                     borderRadius: 5,
  //                     fontSize: 13,
  //                     textColor: AppColor.BLACK,
  //                     bgColor: AppColor.GREY_VIEW,
  //                     function: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(bottom: 20)),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
