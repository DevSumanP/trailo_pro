import 'package:flutter/material.dart';
import 'package:trailo_pro/core/constants/assets_constant.dart';
import 'package:trailo_pro/core/device/device_utils.dart';

import '../../../../core/constants/app_sizes.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: AppSizes.buttonHeight,
          width: DeviceUtils.getScreenWidth(context) * 0.43,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.grey.shade400),
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsConstant.google),
                SizedBox(
                  width: 5,
                ),
                Text('Google'),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        SizedBox(
          height: AppSizes.buttonHeight,
          width: DeviceUtils.getScreenWidth(context) * 0.43,
          child: OutlinedButton(
             style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.grey.shade400),
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsConstant.facebook),
                SizedBox(
                  width: 5,
                ),
                Text('Facebook'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
