import 'package:barkoder/screens/scanner/widgets/button_barcode_info.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class ScannedBarcodeInfo extends StatelessWidget {
  final BarkoderResult barcodeResult;
  final int scannedCount;
  final bool showCount;
  final bool showImage;

  const ScannedBarcodeInfo(
      {super.key,
      required this.barcodeResult,
      required this.scannedCount,
      required this.showCount,
      required this.showImage});

  @override
  Widget build(BuildContext context) {
    Uint8List? barcodeImageBytes;
    if (barcodeResult.resultImageAsBase64 != null) {
      barcodeImageBytes = base64Decode(barcodeResult.resultImageAsBase64!);
    }

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
              barcodeResult.barcodeType.toString().split('.').last,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          if (showImage && barcodeImageBytes != null)
            Center(
              child: Image.memory(
                barcodeImageBytes,
                height: 100,
              ),
            ),
          const SizedBox(height: 8.0),
          Center(
            child: Text(
              barcodeResult.textualData,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8.0),
          if (showCount)
            Center(
              child: Text(
                '$scannedCount results found',
                style: const TextStyle(fontSize: 14),
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
                        Clipboard.setData(
                            ClipboardData(text: barcodeResult.textualData));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Copied to clipboard: ${barcodeResult.textualData}')),
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
                          query:
                              'subject=Barcode CSV&body=${barcodeResult.textualData}',
                        );
                        if (await canLaunchUrl(emailLaunchUri)) {
                          await launchUrl(emailLaunchUri);
                        } else {
                          // ignore: use_build_context_synchronously
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
                        final query =
                            Uri.encodeComponent(barcodeResult.textualData);
                        final url = 'https://www.google.com/search?q=$query';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          // ignore: use_build_context_synchronously
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
