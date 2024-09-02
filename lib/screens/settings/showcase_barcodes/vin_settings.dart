import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class VinSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const VinSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  VinSettingsPageState createState() => VinSettingsPageState();
}

class VinSettingsPageState extends State<VinSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = getVIN();
  bool _allowPinchToZoom = false;
  bool _allowBeep = true;
  bool _allowVibrate = true;
  DecodingSpeed _decodingSpeed = DecodingSpeed.slow;
  BarkoderResolution _resolution = BarkoderResolution.high;
  bool _allowContinuousScanning = false;
  bool _showBottomsheet = true;
  bool _allowMisshaped = false;
  final BaseSettings _baseSettings = BaseSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selectedVINBarcodeTypes', getVIN());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoomVIN');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeepVIN');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrateVIN');
    _decodingSpeed = await _baseSettings.loadDecodingSpeedSetting('decodingSpeedVIN');
    _resolution = await _baseSettings.loadResolutionSetting('resolutionVIN');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanningVIN');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheetVIN');
    _allowMisshaped = await _baseSettings.loadAllowMisshaped('misshapedVIN');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selectedVINBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomVIN', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeepVIN', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrateVIN', _allowVibrate);
    _baseSettings.saveDecodingSpeedSetting('decodingSpeedVIN', _decodingSpeed);
    _baseSettings.saveResolutionSetting('resolutionVIN', _resolution);
    _baseSettings.saveAllowContinuousScanning('continuousScanningVIN', _allowContinuousScanning);
    _baseSettings.saveShowBottomsheet('bottomsheetVIN', _showBottomsheet);
    _baseSettings.saveAllowMisshaped('misshapedVIN', _allowMisshaped);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = getVIN();
      _allowPinchToZoom = false;
      _allowBeep = true;
      _allowVibrate = true;
      _decodingSpeed = DecodingSpeed.fast;
      _resolution = BarkoderResolution.normal;
      _allowContinuousScanning = false;
      _showBottomsheet = true;
      _allowMisshaped = false;
    });

    _saveSettings();
  }

  void _toggleBarcodeType(BarcodeType type, bool isSelected) {
    _baseSettings.toggleBarcodeType(
      type: type,
      isSelected: isSelected,
      selectedBarcodeTypes: selectedBarcodeTypes,
      onUpdate: (updatedTypes) {
        setState(() {
          selectedBarcodeTypes = updatedTypes;
        });
        _saveSettings();
      },
    );
  }

  bool _isBarcodeTypeSelected(BarcodeType type) {
    return _baseSettings.isBarcodeTypeSelected(type, selectedBarcodeTypes);
  }

  void _togglePinchToZoom(bool value) {
    setState(() {
      _allowPinchToZoom = value;
    });
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomVIN', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeepVIN', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrateVIN', value);
  }

  void _toggleDecodingSpeed(DecodingSpeed speed) {
    setState(() {
      _decodingSpeed = speed;
    });
    _baseSettings.saveDecodingSpeedSetting('decodingSpeedVIN', speed);
  }

  void _toggleResolution(BarkoderResolution resolution) {
    setState(() {
      _resolution = resolution;
    });
    _baseSettings.saveResolutionSetting('resolutionVIN', resolution);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanningVIN', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheetVIN', value);
  }

  void _toggleMisshaped(bool value) {
    setState(() {
      _allowMisshaped = value;
    });
    _baseSettings.saveAllowMisshaped('misshapedVIN', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VIN mode',
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
          //   title: 'Narrow Viewfinder',
          //   value: false,
          //   onChanged: (bool newValue) {},
          // ),
          CustomSwitch(
            title: 'Scan Deformed Codes - Segment Decoding',
            value: _allowMisshaped,
            onChanged: (bool newValue) {
              _toggleMisshaped(newValue);
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              'Barcode Types',
              style: TextStyle(
                color: AppColor.mainRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomSwitch(
            title: 'Code 39',
            value: _isBarcodeTypeSelected(BarcodeType.code39),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code39, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 128',
            value: _isBarcodeTypeSelected(BarcodeType.code128),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code128, newValue);
            },
          ),
          CustomSwitch(
            title: 'Data matrix',
            value: _isBarcodeTypeSelected(BarcodeType.datamatrix),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.datamatrix, newValue);
            },
          ),
          CustomSwitch(
            title: 'QR',
            value: _isBarcodeTypeSelected(BarcodeType.qr),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.qr, newValue);
            },
          ),
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