import 'package:flutter/material.dart';
import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';

class ProductsDetailsInfo extends StatelessWidget {
  final String name;
  final int cookTime;
  const ProductsDetailsInfo({
    super.key,
    required this.name,
    required this.cookTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyles.header1.copyWith(color: AppPallete.textHeader),
        ),
        const SizedBox(height: 20),
        Text(
          "$cookTime minutes",
          style: TextStyles.body.copyWith(color: AppPallete.textHeader),
        ),
      ],
    );
  }
}
