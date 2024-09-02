import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonBarcodeInfo extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  
  const ButtonBarcodeInfo({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.mainRed, width: 1.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColor.mainRed),
              const SizedBox(width: 8.0),
              Text(text, style: const TextStyle(fontSize: 12, color: AppColor.mainRed)),
            ],
          ),
        ),
      ),
    );
  }
}