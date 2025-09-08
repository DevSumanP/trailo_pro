import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/onboarding/presentation/pages/onboarding.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/device/app_utils.dart';
import '../provider/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Listen for auth state changes in the build method instead
  }

  void _navigateAfterLogin() {
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      (route) => false,
    );
  }

  void _togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authNotifierProvider.notifier).login(
            emailController.text,
            passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Add auth state listener
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        authenticated: (_) => _navigateAfterLogin(),
        error: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });

    final authState = ref.watch(authNotifierProvider);

    // Clear error when user starts typing
    void onFieldChanged(String value) {}

    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email
            TextFormField(
              controller: emailController,
              onChanged: onFieldChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!AppUtils.isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'E-Mail',
                labelStyle: TextStyle(
                  color: emailController.text.isEmpty
                      ? Colors.grey
                      : AppColors.primaryColor,
                ),
                errorText: authState.maybeWhen(
                  error: (msg) => msg, 
                  orElse: () => null,
                ),
              ),
            ),

            SizedBox(height: AppSizes.inputSpacing),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: hidePassword,
              onChanged: onFieldChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (!AppUtils.isValidPassword(value)) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : AppColors.primaryColor,
                ),
                prefixIcon: const Icon(Iconsax.lock),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                ),
                errorText: authState.maybeWhen(
                  error: (msg) => msg, 
                  orElse: () => null,
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

            // Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {},
                      // onChanged: authState.isLoading
                      //     ? null
                      //     : (val) => setState(() => rememberMe = val ?? false),
                    ),
                    const Text('Remember Me'),
                  ],
                ),
                TextButton(
                  onPressed:
                      // authState.isLoading
                      // ? null
                      () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forgot password feature coming soon'),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 13, color: Color(0xff4b5ae4)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onLogin,
                child: authState.maybeWhen(
                  loading: () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  orElse: () => const Text('Sign In'),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections + 32),
          ],
        ),
      ),
    );
  }
}
