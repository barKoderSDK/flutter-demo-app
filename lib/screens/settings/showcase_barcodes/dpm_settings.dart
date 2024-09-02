import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class DpmSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const DpmSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  DpmSettingsPageState createState() => DpmSettingsPageState();
}

class DpmSettingsPageState extends State<DpmSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = getDPM();
  bool _allowPinchToZoom = false;
  bool _allowBeep = true;
  bool _allowVibrate = true;
  DecodingSpeed _decodingSpeed = DecodingSpeed.slow;
  BarkoderResolution _resolution = BarkoderResolution.high;
  FormattingType _formating = FormattingType.disabled;
  String _charset = 'Not set';
  bool _allowContinuousScanning = false;
  bool _showBottomsheet = true;
  final BaseSettings _baseSettings = BaseSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selectedDPMBarcodeTypes', getDPM());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoomDPM');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeepDPM');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrateDPM');
    _decodingSpeed = await _baseSettings.loadDecodingSpeedSetting('decodingSpeedDPM');
    _resolution = await _baseSettings.loadResolutionSetting('resolutionDPM');
    _formating = await _baseSettings.loadFormatingSetting('formatingDPM');
    _charset = await _baseSettings.loadCharsetSetting('charsetDPM');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanningDPM');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheetDPM');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selectedDPMBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomDPM', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeepDPM', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrateDPM', _allowVibrate);
    _baseSettings.saveDecodingSpeedSetting('decodingSpeedDPM', _decodingSpeed);
    _baseSettings.saveResolutionSetting('resolutionDPM', _resolution);
    _baseSettings.saveFormatingSetting('formatingDPM', _formating);
    _baseSettings.saveCharsetSetting('charsetDPM', _charset);
    _baseSettings.saveAllowContinuousScanning('continuousScanningDPM', _allowContinuousScanning);
    _baseSettings.saveShowBottomsheet('bottomsheetDPM', _showBottomsheet);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = getDPM();
      _allowPinchToZoom = false;
      _allowBeep = true;
      _allowVibrate = true;
      _decodingSpeed = DecodingSpeed.fast;
      _resolution = BarkoderResolution.normal;
      _formating = FormattingType.disabled;
      _charset = 'Not set';
      _allowContinuousScanning = false;
      _showBottomsheet = true;
    });

    _saveSettings();
  }

  void _togglePinchToZoom(bool value) {
    setState(() {
      _allowPinchToZoom = value;
    });
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomDPM', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeepDPM', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrateDPM', value);
  }

  void _toggleDecodingSpeed(DecodingSpeed speed) {
    setState(() {
      _decodingSpeed = speed;
    });
    _baseSettings.saveDecodingSpeedSetting('decodingSpeedDPM', speed);
  }

  void _toggleResolution(BarkoderResolution resolution) {
    setState(() {
      _resolution = resolution;
    });
    _baseSettings.saveResolutionSetting('resolutionDPM', resolution);
  }

  void _toggleFormating(FormattingType formating) {
    setState(() {
      _formating = formating;
    });
    _baseSettings.saveFormatingSetting('formatingDPM', formating);
  }

  void _toggleCharset(String charset) {
    setState(() {
      _charset = charset;
    });
    _baseSettings.saveCharsetSetting('charsetDPM', charset);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanningDPM', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheetDPM', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DPM Mode',
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
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'barKoder Settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OptionListTile<DecodingSpeed>(
            title: 'Decoding Speed',
            selectedOption: _decodingSpeed,
            options: DecodingSpeed.values,
            onOptionSelected: (DecodingSpeed selectedSpeed) {
              _toggleDecodingSpeed(selectedSpeed);
            },
          ),
          OptionListTile<BarkoderResolution>(
            title: 'barKoder Resolution',
            selectedOption: _resolution,
            options: BarkoderResolution.values,
            onOptionSelected: (BarkoderResolution selectedResolution) {
              _toggleResolution(selectedResolution);
            },
          ),
          CustomSwitch(
            title: 'Continuous Scanning',
            value: _allowContinuousScanning,
            onChanged: (bool newValue) {
              _toggleContinuousScanning(newValue);
            },
          ),
          CustomSwitch(
            title: 'Allow pinch to zoom',
            value: _allowPinchToZoom,
            onChanged: (bool newValue) {
              _togglePinchToZoom(newValue);
            },
          ),
          CustomSwitch(
            title: 'Beep on success',
            value: _allowBeep,
            onChanged: (bool newValue) {
              _toggleBeep(newValue);
            },
          ),
          CustomSwitch(
            title: 'Vibrate on success',
            value: _allowVibrate,
            onChanged: (bool newValue) {
              _toggleVibrate(newValue);
            },
          ),
          // CustomSwitch(
          //   title: 'Bigger Viewfinder',
          //   value: false,
          //   onChanged: (bool newValue) {},
          // ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'Result',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OptionListTile<FormattingType>(
            title: 'Formatting Type',
            selectedOption: _formating,
            options: FormattingType.values,
            onOptionSelected: (FormattingType selectedFormating) {
              _toggleFormating(selectedFormating);
            },
          ),
          OptionListTile<String>(
            title: 'Charset',
            selectedOption: _charset,
            options: const [
              'Not set',
              'ISO-8859-1',
              'ISO-8859-2',
              'ISO-8859-5',
              'Shift_JIS',
              'US-ASCII',
              'UTF-8',
              'UTF-16',
              'UTF-32',
              'windows-1251',
              'windows-1256'
            ],
            onOptionSelected: (String selectedCharset) {
              _toggleCharset(selectedCharset);
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'General settings',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _resetSettings,
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                'Reset config',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          CustomSwitch(
            title: 'Automatically show bottomsheet',
            value: _showBottomsheet,
            onChanged: (bool newValue) {
              _toggleShowBottomsheet(newValue);
            },
          ),
        ],
      ),
    );
  }
}