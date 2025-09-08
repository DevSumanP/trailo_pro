import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            color: AppColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const Flexible(
          child: Divider(
            color: AppColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 5,
          ),
        ),
      ],
    );
  }
}
