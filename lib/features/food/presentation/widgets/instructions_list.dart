import 'package:flutter/material.dart';
import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';

class InstructionsList extends StatelessWidget {
  final List<String> instructions;
  const InstructionsList({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          instructions
              .map(
                (step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    step,
                    style: TextStyles.body.copyWith(
                      color: AppPallete.textHeader,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
