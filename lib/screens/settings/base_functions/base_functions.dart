import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseSettings {
  // Barcode Types
  Future<List<BarcodeType>> loadBarcodeTypes(
      String key, List<BarcodeType> defaultTypes) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTypes = prefs.getStringList(key) ?? [];

    if (savedTypes.isEmpty) {
      await saveBarcodeTypes(key, defaultTypes);
      return defaultTypes;
    } else {
      return savedTypes
          .map((type) =>
              BarcodeType.values.firstWhere((e) => e.toString() == type))
          .toList();
    }
  }

  Future<void> saveBarcodeTypes(
      String key, List<BarcodeType> barcodeTypes) async {
    final prefs = await SharedPreferences.getInstance();
    final typesToSave = barcodeTypes.map((e) => e.toString()).toList();
    await prefs.setStringList(key, typesToSave);
  }

  Future<List<BarcodeType>> getSelectedBarcodeTypes(String type) async {
  final prefs = await SharedPreferences.getInstance();
  final savedTypes = prefs.getStringList(type) ?? [];
  return savedTypes
      .map((barcodeType) =>
          BarcodeType.values.firstWhere((e) => e.toString() == barcodeType))
      .toList();
}

  void toggleBarcodeType({
    required BarcodeType type,
    required bool isSelected,
    required List<BarcodeType> selectedBarcodeTypes,
    required Function(List<BarcodeType>) onUpdate,
  }) {
    if (isSelected) {
      if (!selectedBarcodeTypes.contains(type)) {
        selectedBarcodeTypes.add(type);
      }
    } else {
      selectedBarcodeTypes.remove(type);
    }
    onUpdate(selectedBarcodeTypes);
  }

  bool isBarcodeTypeSelected(
      BarcodeType type, List<BarcodeType> selectedBarcodeTypes) {
    return selectedBarcodeTypes.contains(type);
  }

  // Allow to Pinch Zoom
  Future<bool> loadAllowPinchToZoomSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveAllowPinchToZoomSetting(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Beep
  Future<bool> loadBeepSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  Future<void> saveBeepSetting(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Vibrate
  Future<bool> loadVibrateSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  Future<void> saveVibrateSetting(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Decoding Speed
  Future<DecodingSpeed> loadDecodingSpeedSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? speed = prefs.getString(key);
    if (speed == null) return DecodingSpeed.normal;
    return DecodingSpeed.values.firstWhere((e) => e.toString() == speed);
  }

  Future<void> saveDecodingSpeedSetting(String key, DecodingSpeed speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, speed.toString());
  }

  // Barkoder Resolution
  Future<BarkoderResolution> loadResolutionSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? resolution = prefs.getString(key);
    if (resolution == null) return BarkoderResolution.normal;
    return BarkoderResolution.values.firstWhere((e) => e.toString() == resolution);
  }

  Future<void> saveResolutionSetting(String key, BarkoderResolution resolution) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, resolution.toString());
  }

  // Formating 
  Future<FormattingType> loadFormatingSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? formating = prefs.getString(key);
    if (formating == null) return FormattingType.disabled;
    return FormattingType.values.firstWhere((e) => e.toString() == formating);
  }

  Future<void> saveFormatingSetting(String key, FormattingType formating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, formating.toString());
  }

  // Charset
  Future<String> loadCharsetSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'Not set';
  }

  Future<void> saveCharsetSetting(String key, String charset) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, charset);
  }

  // Allow Continuous Scanning
  Future<bool> loadAllowContinuousScanning(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveAllowContinuousScanning(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Allow Misshaped
  Future<bool> loadAllowMisshaped(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveAllowMisshaped(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Allow Scan Blurred UPC/EAN
  Future<bool> loadAllowBlurredUPC(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveAllowBlurredUPC(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Continuous Threshold 
  Future<int> loadContinuousThreshold(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 5;
  }

  Future<void> saveContinuousThreshold(String key, int num) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, num);
  }

  // Automatically Show Bottomsheet
  Future<bool> loadShowBottomsheet(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  Future<void> saveShowBottomsheet(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Enable Region of Interest
  Future<bool> loadRegionOfInterest(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveRegionOfInterest(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}