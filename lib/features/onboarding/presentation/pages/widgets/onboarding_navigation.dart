import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/device/device_utils.dart';

class OnBoardingNavigation extends StatelessWidget {
  final PageController controller;
  const OnBoardingNavigation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      left: AppSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.primaryColor,
          dotHeight: 6.0,
        ),
        controller: controller,
        count: 3,
      ),
    );
  }
}
