import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.press});

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.header2.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: AppPallete.primary),
          child: Text(
            "View all",
            style: TextStyles.body.copyWith(
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: AppPallete.primary,
            ),
          ),
        ),
      ],
    );
  }
}
