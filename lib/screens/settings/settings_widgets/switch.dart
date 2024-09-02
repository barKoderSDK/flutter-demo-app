import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          activeColor: Colors.white,
          activeTrackColor: AppColor.mainRed,
          inactiveThumbColor: AppColor.switchInactivePrimary,
          inactiveTrackColor: AppColor.switchInactiveSecondary,
          splashRadius: 50.0,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
