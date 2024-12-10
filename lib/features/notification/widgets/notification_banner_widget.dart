import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/widgets/gradient_text.dart';

class NotificationBannerWidget extends StatelessWidget {
  final double width;
  final double height;

  final List<Widget> banners = [];

  NotificationBannerWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    banners.clear();
    banners.addAll(
      [
        _buildBannerAdsWidget(
          imgAsset: 'assets/images/banner1.png',
          description: 'Ứng dụng Tiện ích, Đơn giản\ncho cuộc số hiện đại',
          gradient: AppColor.GRADIENT_GREEN_TO_BLUE,
        ),
        _buildBannerAdsWidget(
          imgAsset: 'assets/images/banner2.png',
          description: 'Thanh toán nhanh gọn,\nĐối soát nhanh chóng',
          gradient: AppColor.GRADIENT_PURPLE_TO_ORANGE,
        ),
        _buildBannerAdsWidget(
          imgAsset: 'assets/images/banner3.png',
          description:
              'Quản lý cửa hàng hiệu quả. Dữ liệu\nthống kê trực quan, đáng tin cậy',
          gradient: AppColor.GRADIENT_PURPLE_TO_PINK,
        ),
        _buildBannerAdsWidget(
          imgAsset: 'assets/images/banner4.png',
          description:
              'Chia sẻ thông tin biến động\nqua các nền tảng mạng xã hội',
          gradient: AppColor.GRADIENT_ORANGE_TO_RED,
        ),
        _buildBannerAdsWidget(
          imgAsset: 'assets/images/banner5.png',
          description: 'Dễ dàng tích hợp dịch vụ VietQR\nvào hệ thống của bạn',
          gradient: AppColor.GRADIENT_BLUEL_TO_BLUED,
        ),
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 1,
        ),
        items: banners,
      ),
    );
  }

  Widget _buildBannerAdsWidget(
      {required String imgAsset,
      required String description,
      required Gradient gradient}) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgAsset,
            width: width / 2.8,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: width - 40,
            child: GradientText(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
              gradient: gradient,
            ),
          ),
        ],
      ),
    );
  }
}
