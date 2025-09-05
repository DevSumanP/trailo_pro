import 'package:flutter/material.dart';
import 'package:trailo_pro/core/device/device_utils.dart';

import '../../../../../core/constants/app_sizes.dart';

class OnboardingPage extends StatelessWidget {
  final String title, image, subTitle;
  const OnboardingPage({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
           SizedBox(height: DeviceUtils.getAppBarHeight() + 16,),
          Image(
            image: AssetImage(image),
            width: DeviceUtils.getScreenHeight(context),
            height: DeviceUtils.getScreenHeight(context) * 0.58,
          ),
          SizedBox(height: AppSizes.spaceBtwSections,),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
