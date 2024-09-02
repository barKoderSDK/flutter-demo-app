import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<BarcodeType>> getSelectedBarcodeTypes(String type) async {
  final prefs = await SharedPreferences.getInstance();
  final savedTypes = prefs.getStringList(type) ?? [];
  return savedTypes
      .map((barcodeType) =>
          BarcodeType.values.firstWhere((e) => e.toString() == barcodeType))
      .toList();
}

Future<bool> getAllowPinchToZoomSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<bool> getBeepSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? true;
}

Future<bool> getVibrateSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? true;
}

Future<DecodingSpeed> getDecodingSpeedSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String? speed = prefs.getString(key);
  if (speed == null) return DecodingSpeed.normal;
  return DecodingSpeed.values.firstWhere((e) => e.toString() == speed);
}

Future<BarkoderResolution> getResolutionSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String? resolution = prefs.getString(key);
  if (resolution == null) return BarkoderResolution.normal;
  return BarkoderResolution.values.firstWhere((e) => e.toString() == resolution);
}

Future<FormattingType> getFormatingSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String? formating = prefs.getString(key);
  if (formating == null) return FormattingType.disabled;
  return FormattingType.values.firstWhere((e) => e.toString() == formating);
}

Future<String> getCharsetSetting(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? 'Not set';
}

Future<bool> getAllowContinuousScanning(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<bool> getAllowMisshaped(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<bool> getAllowBlurredUPC(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<int> getContinuousThreshold(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key) ?? 5;
}

Future<bool> getShowBottomsheet(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? true;
}

Future<bool> getRegionOfInterest(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}