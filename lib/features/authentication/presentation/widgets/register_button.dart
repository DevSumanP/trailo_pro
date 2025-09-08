import 'package:flutter/material.dart';
import 'package:trailo_pro/core/constants/colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return // Create Account Button
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
          text: "Don't have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Register now',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600,),
            ),
          ],
                ),
              ),
        );
  }
}
