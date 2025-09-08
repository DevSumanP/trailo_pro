import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/core/constants/assets_constant.dart';
import 'package:trailo_pro/core/constants/colors.dart';
import 'package:trailo_pro/features/onboarding/presentation/provider/onboarding_provider.dart';

import 'widgets/onboarding_button.dart';
import 'widgets/onboarding_page.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final controller = ref.read(onboardingProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Horizontal Scrollable Page
          PageView(
            controller: state.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                title: "Let's book your train with just a tap",
                image: AssetsConstant.onBoardingImage1,
                subTitle:
                    'It is a long established fact that the a reader will be distracted by the readable content.',
              ),
              OnboardingPage(
                title: 'Book your ticket and enjoy your trip',
                image: AssetsConstant.onBoardingImage2,
                subTitle:
                    'It is a long established fact that the a reader will be distracted by the readable content.',
              ),
              OnboardingPage(
                title: 'We make your train journey very easy',
                image: AssetsConstant.onBoardingImage3,
                subTitle:
                    'It is a long established fact that the a reader will be distracted by the readable content.',
              ),
            ],
          ),

          // Skip Button
          //  OnBoardingSkip(onSkip: controller.skipToLastPage,),

          // Smooth Page Indicator
          //  OnBoardingNavigation(controller: state.pageController),

          // Circular Button
          OnBoardingButton(
            onNext: () => controller.nextPage(context),
          ),
        ],
      ),
    );
  }
}
