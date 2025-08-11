import 'package:flutter/material.dart';
import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';

class ProductDetailsTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const ProductDetailsTabs({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onTabSelected("Ingredients"),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color:
                    selectedTab == "Ingredients"
                        ? AppPallete.primary
                        : AppPallete.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Ingredients',
                textAlign: TextAlign.center,
                style: TextStyles.body.copyWith(color: AppPallete.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () => onTabSelected("Instructions"),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color:
                    selectedTab == "Instructions"
                        ? AppPallete.primary
                        : AppPallete.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Instructions',
                textAlign: TextAlign.center,
                style: TextStyles.body.copyWith(color: AppPallete.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
