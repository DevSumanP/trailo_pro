import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/core/constants/assets_constant.dart';
import 'package:trailo_pro/core/device/device_utils.dart';
import 'package:trailo_pro/features/authentication/presentation/widgets/register_button.dart';

import '../../../../core/constants/app_sizes.dart';
import '../widgets/form_divider.dart';
import '../widgets/signin_form.dart';
import '../widgets/signin_header.dart';
import '../widgets/social_buttons.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double top = DeviceUtils.getAppBarHeight() + 24;
    DeviceUtils.setStatusBarColor(Colors.white);
    DeviceUtils.setBottomNavBarColor(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, top, 16.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AssetsConstant.loginLogo,
                height: 65,
              ),

              // Logo, Title & Sub title
              const LoginHeader(),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Social login
              const SocialButtons(),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form Divider
              FormDivider(
                dividerText: ' Or login with ',
              ),

              // Form
              const LoginForm(),

              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RegisterButton(),
    );
  }
}
