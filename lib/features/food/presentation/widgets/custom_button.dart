import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppPallete.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size(double.infinity, 48),
        // shape: const StadiumBorder(),
      ),
      child: Text(text, style: TextStyles.body),
    );
  }
}
