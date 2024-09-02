import 'package:flutter/material.dart';

class BarcodeRow extends StatelessWidget {
  final String title;
  final List<Widget> buttons;

  const BarcodeRow({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            alignment: WrapAlignment.center,
            children: buttons.map((button) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 3,
                child: button,
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20.0)
      ],
    );
  }
}