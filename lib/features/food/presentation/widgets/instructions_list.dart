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
                (step) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${instructions.indexOf(step) + 1}. ',
                        style: TextStyle(fontSize: 14),
                      ),
                      Expanded(
                        child: Text(
                          step,
                          style: TextStyles.body.copyWith(
                            color: AppPallete.textHeader,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
