import 'package:barkoder/screens/scanner/screens/barcode_scanner.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';
import 'package:barkoder/screens/home/screens/about_screen.dart';
import 'package:barkoder/screens/home/screens/scans_screen.dart';
import 'package:barkoder/screens/settings/settings_screen.dart';

// Navigation
void openRecentScans(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RecentScansScreen(recentScans: BarcodeScannerState.recentScans),
    ),
  );
}

void openAboutScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AboutPage(),
    ),
  );
}

void openSettingsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SettingsPage(),
    ),
  );
}

// Scanner functions
void startScanning(BuildContext context, List<BarcodeType> barcodeTypes,
    bool allowPinchToZoom, bool allowBeep, bool allowVibrate, DecodingSpeed changeSpeed, BarkoderResolution changeResolution, FormattingType changeFormatting, String changeCharset, bool continuousScanning, bool misshaped, bool blurredUPC, int continuousThreshold, bool showBottomsheet, bool regionOfInterest, bool location, String settings) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BarcodeScanner(
        barcodeTypes: barcodeTypes,
        autoStart: true,
        allowPinchToZoom: allowPinchToZoom,
        allowBeep: allowBeep,
        allowVibrate: allowVibrate,
        changeSpeed: changeSpeed,
        changeResolution: changeResolution,
        changeFormatting: changeFormatting,
        changeCharset: changeCharset,
        continuousScanning: continuousScanning,
        misshaped: misshaped,
        blurredUPC: blurredUPC,
        continuousThreshold: continuousThreshold,
        showBottomsheet: showBottomsheet,
        regionOfInterest: regionOfInterest,
        locationPreview: location,
        settings: settings,
      ),
    ),
  );
}
