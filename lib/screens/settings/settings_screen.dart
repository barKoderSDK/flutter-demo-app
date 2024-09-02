import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/1d_barcodes/one_industrial.dart';
import 'package:barkoder/screens/settings/1d_barcodes/one_retail.dart';
import 'package:barkoder/screens/settings/1d_barcodes/one_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/two_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/all_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/deblur_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/dot_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/dpm_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/misshaped_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/multi_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/pdf_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/vin_settings.dart';
import 'package:barkoder/screens/settings/settings_widgets/webhook_config_screen.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/list_tile.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
                color: Colors.white,
              ),
          ),
        backgroundColor: AppColor.mainRed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // ---------------- //
          // Webhook settings //
          // ---------------- //
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'Webhook settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomSwitch(
            title: 'Enable Webhook',
            value: true,
            onChanged: (bool newValue) {},
          ),
          CustomListTile(
            title: 'Webhook Config',
            onTap: () {
              // Navigate to Webhook Config screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebhookConfigScreen(),
                ),
              );
            },
          ),
          CustomSwitch(
            title: 'Auto send to webhook',
            value: false,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Webhook Confirmation Feedback',
            value: false,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Encode webhook data',
            value: false,
            onChanged: (bool newValue) {},
          ),
          // ---------------- //
          // General settings //
          // ---------------- //
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'General settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomSwitch(
            title: 'Enable search on Web',
            value: true,
            onChanged: (bool newValue) {},
          ),
          // OptionListTile(
          //   title: 'Default search engine',
          //   selectedOption: 'Google',
          //   options: ['Google', 'Yahoo', 'DuckDuckGo', 'Yandex', 'Bing', 'Brave'],
          //   // onOptionSelected: (value) {
          //   //   setState(() {
          //   //     selectedOption = true;
          //   //   });
          //   // },
          // ),
          // ------------------ //
          // Reset all settings //
          // ------------------ //
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Reset all settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // ----------------------- //
          // Scanning modes settings //
          // ----------------------- //
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'Scanning Modes Settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomListTile(
          title: 'All 1D Codes',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OneDSettingsPage(selectedBarcodeTypes: get1D()),
              ),
            );
          },
        ),
        CustomListTile(
          title: '1D Industrial',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndustrialSettingsPage(selectedBarcodeTypes: getIndustrial()),
              ),
            );
          },
        ),
        CustomListTile(
          title: '1D Retail',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RetailSettingsPage(selectedBarcodeTypes: getRetail()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'PDF417',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfSettingsPage(selectedBarcodeTypes: getPDF417()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'All 2D Codes',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TwoDSettingsPage(selectedBarcodeTypes: get2D()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'Batch MultiScan',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiSettingsPage(selectedBarcodeTypes: getMultiScan()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'DPM Mode',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DpmSettingsPage(selectedBarcodeTypes: getDPM()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'VIN Mode',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VinSettingsPage(selectedBarcodeTypes: getVIN()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'DotCode',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DotSettingsPage(selectedBarcodeTypes: getDotCode()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'Deblur',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeblurSettingsPage(selectedBarcodeTypes: getDeblur()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'Misshaped',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MissSettingsPage(selectedBarcodeTypes: getMisshaped()),
              ),
            );
          },
        ),
        CustomListTile(
          title: 'Anycode',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllSettingsPage(selectedBarcodeTypes: getAll()),
              ),
            );
          },
        ),
        ],
      ),
    );
  }
}