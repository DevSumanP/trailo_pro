import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/device/device_utils.dart';

class OnBoardingSkip extends StatelessWidget {
  final VoidCallback onSkip;
  const OnBoardingSkip({
    super.key, required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace - 24,
      child: TextButton(
        onPressed: () => onSkip,
        child: Text(
          'Skip',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
