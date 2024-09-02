import 'package:barkoder/screens/scanner/widgets/button_barcode_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanDetailPopup extends StatelessWidget {
  final String name;
  final String type;

  const ScanDetailPopup({super.key, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              type,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    ButtonBarcodeInfo(
                      text: 'Copy',
                      icon: Icons.copy,
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: name));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied to clipboard: $name')),
                        );
                      },
                    ),
                    const SizedBox(width: 8.0),
                    ButtonBarcodeInfo(
                      text: 'CSV',
                      icon: Icons.table_chart,
                      onTap: () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: '',
                          query: 'subject=Barcode CSV&body=$name',
                        );
                        if (await canLaunchUrl(emailLaunchUri)) {
                          await launchUrl(emailLaunchUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Could not launch email app.')),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    ButtonBarcodeInfo(
                      text: 'Webhook',
                      icon: Icons.phone_android,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Webhook'),
                              content: const Text(
                                  'Webhook configuration for this app is not set.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 8.0),
                    ButtonBarcodeInfo(
                      text: 'Search',
                      icon: Icons.search,
                      onTap: () async {
                        final url = 'https://www.google.com/search?q=$name';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Could not launch browser for search')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
