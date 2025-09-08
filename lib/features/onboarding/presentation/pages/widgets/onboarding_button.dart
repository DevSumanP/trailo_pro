import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/device/device_utils.dart';

class OnBoardingButton extends StatelessWidget {
  final VoidCallback onNext;
  const OnBoardingButton({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() - 25,
      left: 16,
      right: 16,
      child: SizedBox(
        width: DeviceUtils.getScreenWidth(context),
        height: AppSizes.buttonHeight,
        child: ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
            backgroundColor: AppColors.primaryColor,
          ),
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
