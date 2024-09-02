import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';

class OptionListTile<T> extends StatelessWidget {
  final String title;
  final T selectedOption;
  final List<T> options;
  final ValueChanged<T> onOptionSelected;

  const OptionListTile({
    super.key,
    required this.title,
    required this.selectedOption,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 4.0),
          Text(
            selectedOption.toString().split('.').last,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            T tempSelectedOption = selectedOption;

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(
                    title,
                    style: const TextStyle(color: AppColor.mainRed),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((option) {
                      return RadioListTile<T>(
                        title: Text(option.toString().split('.').last),
                        value: option,
                        groupValue: tempSelectedOption,
                        activeColor: AppColor.mainRed,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              tempSelectedOption = value;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.mainRed),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        onOptionSelected(tempSelectedOption);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: AppColor.mainRed),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}