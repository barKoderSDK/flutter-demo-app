import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class TwoDSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const TwoDSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  TwoDSettingsPageState createState() => TwoDSettingsPageState();
}

class TwoDSettingsPageState extends State<TwoDSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = get2D();
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
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selected2DBarcodeTypes', get2D());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoom2D');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeep2D');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrate2D');
    _decodingSpeed = await _baseSettings.loadDecodingSpeedSetting('decodingSpeed2D');
    _resolution = await _baseSettings.loadResolutionSetting('resolution2D');
    _formating = await _baseSettings.loadFormatingSetting('formating2D');
    _charset = await _baseSettings.loadCharsetSetting('charset2D');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanning2D');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheet2D');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selected2DBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoom2D', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeep2D', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrate2D', _allowVibrate);
    _baseSettings.saveDecodingSpeedSetting('decodingSpeed2D', _decodingSpeed);
    _baseSettings.saveResolutionSetting('resolution2D', _resolution);
    _baseSettings.saveFormatingSetting('formating2D', _formating);
    _baseSettings.saveCharsetSetting('charset2D', _charset);
    _baseSettings.saveAllowContinuousScanning('continuousScanning2D', _allowContinuousScanning);
    _baseSettings.saveShowBottomsheet('bottomsheet2D', _showBottomsheet);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = get2D();
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
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoom2D', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeep2D', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrate2D', value);
  }

  void _toggleDecodingSpeed(DecodingSpeed speed) {
    setState(() {
      _decodingSpeed = speed;
    });
    _baseSettings.saveDecodingSpeedSetting('decodingSpeed2D', speed);
  }

  void _toggleResolution(BarkoderResolution resolution) {
    setState(() {
      _resolution = resolution;
    });
    _baseSettings.saveResolutionSetting('resolution2D', resolution);
  }

  void _toggleFormating(FormattingType formating) {
    setState(() {
      _formating = formating;
    });
    _baseSettings.saveFormatingSetting('formating2D', formating);
  }

  void _toggleCharset(String charset) {
    setState(() {
      _charset = charset;
    });
    _baseSettings.saveCharsetSetting('charset2D', charset);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanning2D', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheet2D', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All 2D Codes',
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
            title: 'Aztec',
            value: _isBarcodeTypeSelected(BarcodeType.aztec),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.aztec, newValue);
            },
          ),
          CustomSwitch(
            title: 'Aztec Compact',
            value: _isBarcodeTypeSelected(BarcodeType.aztecCompact),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.aztecCompact, newValue);
            },
          ),
          CustomSwitch(
            title: 'QR',
            value: _isBarcodeTypeSelected(BarcodeType.qr),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.qr, newValue);
            },
          ),
          CustomSwitch(
            title: 'QR Micro',
            value: _isBarcodeTypeSelected(BarcodeType.qrMicro),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.qrMicro, newValue);
            },
          ),
          CustomSwitch(
            title: 'PDF 417',
            value: _isBarcodeTypeSelected(BarcodeType.pdf417),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.pdf417, newValue);
            },
          ),
          CustomSwitch(
            title: 'PDF 417 Micro',
            value: _isBarcodeTypeSelected(BarcodeType.pdf417Micro),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.pdf417Micro, newValue);
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
            title: 'DotCode',
            value: _isBarcodeTypeSelected(BarcodeType.dotcode),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.dotcode, newValue);
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