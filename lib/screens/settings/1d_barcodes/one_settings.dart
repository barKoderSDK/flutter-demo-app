import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class OneDSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const OneDSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  OneDSettingsPageState createState() => OneDSettingsPageState();
}

class OneDSettingsPageState extends State<OneDSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = get1D();
  bool _allowPinchToZoom = false;
  bool _allowBeep = true;
  bool _allowVibrate = false;
  DecodingSpeed _decodingSpeed = DecodingSpeed.slow;
  BarkoderResolution _resolution = BarkoderResolution.normal;
  FormattingType _formating = FormattingType.disabled;
  String _charset = 'Not set';
  bool _allowContinuousScanning = false;
  bool _allowMisshaped = false;
  bool _allowBlurredUPC = false;
  bool _showBottomsheet = true;
  final BaseSettings _baseSettings = BaseSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selected1DBarcodeTypes', get1D());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoom1D');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeep1D');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrate1D');
    _decodingSpeed = await _baseSettings.loadDecodingSpeedSetting('decodingSpeed1D');
    _resolution = await _baseSettings.loadResolutionSetting('resolution1D');
    _formating = await _baseSettings.loadFormatingSetting('formating1D');
    _charset = await _baseSettings.loadCharsetSetting('charset1D');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanning1D');
    _allowMisshaped = await _baseSettings.loadAllowMisshaped('misshaped1D');
    _allowBlurredUPC = await _baseSettings.loadAllowBlurredUPC('blurredUPC1D');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheet1D');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selected1DBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoom1D', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeep1D', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrate1D', _allowVibrate);
    _baseSettings.saveDecodingSpeedSetting('decodingSpeed1D', _decodingSpeed);
    _baseSettings.saveResolutionSetting('resolution1D', _resolution);
    _baseSettings.saveFormatingSetting('formating1D', _formating);
    _baseSettings.saveCharsetSetting('charset1D', _charset);
    _baseSettings.saveAllowContinuousScanning('continuousScanning1D', _allowContinuousScanning);
    _baseSettings.saveAllowMisshaped('misshaped1D', _allowMisshaped);
    _baseSettings.saveAllowBlurredUPC('blurredUPC1D', _allowBlurredUPC);
    _baseSettings.saveShowBottomsheet('bottomsheet1D', _showBottomsheet);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = get1D();
      _allowPinchToZoom = false;
      _allowBeep = true;
      _allowVibrate = true;
      _decodingSpeed = DecodingSpeed.fast;
      _resolution = BarkoderResolution.high;
      _formating = FormattingType.disabled;
      _charset = 'Not set';
      _allowContinuousScanning = false;
      _allowMisshaped = false;
      _allowBlurredUPC = false;
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
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoom1D', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeep1D', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrate1D', value);
  }

  void _toggleDecodingSpeed(DecodingSpeed speed) {
    setState(() {
      _decodingSpeed = speed;
    });
    _baseSettings.saveDecodingSpeedSetting('decodingSpeed1D', speed);
  }

  void _toggleResolution(BarkoderResolution resolution) {
    setState(() {
      _resolution = resolution;
    });
    _baseSettings.saveResolutionSetting('resolution1D', resolution);
  }

  void _toggleFormating(FormattingType formating) {
    setState(() {
      _formating = formating;
    });
    _baseSettings.saveFormatingSetting('formating1D', formating);
  }

  void _toggleCharset(String charset) {
    setState(() {
      _charset = charset;
    });
    _baseSettings.saveCharsetSetting('charset1D', charset);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanning1D', value);
  }

  void _toggleMisshaped(bool value) {
    setState(() {
      _allowMisshaped = value;
    });
    _baseSettings.saveAllowMisshaped('misshaped1D', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheet1D', value);
  }

  void _toggleBlurredUPC(bool value) {
    setState(() {
      _allowBlurredUPC = value;
    });
    _baseSettings.saveAllowBlurredUPC('blurredUPC1D', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All 1D Codes',
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
          CustomSwitch(
            title: 'Scan blured UPC/EAN',
            value: _allowBlurredUPC,
            onChanged: (bool newValue) {
              _toggleBlurredUPC(newValue);
            },
          ),
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
            title: 'Code 128',
            value: _isBarcodeTypeSelected(BarcodeType.code128),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code128, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 93',
            value: _isBarcodeTypeSelected(BarcodeType.code93),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code93, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 39',
            value: _isBarcodeTypeSelected(BarcodeType.code39),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code39, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 25',
            value: _isBarcodeTypeSelected(BarcodeType.code25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code25, newValue);
            },
          ),
          CustomSwitch(
            title: 'Codabar',
            value: _isBarcodeTypeSelected(BarcodeType.codabar),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.codabar, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 11',
            value: _isBarcodeTypeSelected(BarcodeType.code11),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code11, newValue);
            },
          ),
          CustomSwitch(
            title: 'MSI',
            value: _isBarcodeTypeSelected(BarcodeType.msi),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.msi, newValue);
            },
          ),
          CustomSwitch(
            title: 'Code 32',
            value: _isBarcodeTypeSelected(BarcodeType.code32),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.code32, newValue);
            },
          ),
          CustomSwitch(
            title: 'Interleaved 2 of 5',
            value: _isBarcodeTypeSelected(BarcodeType.interleaved25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.interleaved25, newValue);
            },
          ),
          CustomSwitch(
            title: 'ITF 14',
            value: _isBarcodeTypeSelected(BarcodeType.itf14),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.itf14, newValue);
            },
          ),
          CustomSwitch(
            title: 'IATA 25',
            value: _isBarcodeTypeSelected(BarcodeType.iata25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.iata25, newValue);
            },
          ),
          CustomSwitch(
            title: 'Matrix 25',
            value: _isBarcodeTypeSelected(BarcodeType.matrix25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.matrix25, newValue);
            },
          ),
          CustomSwitch(
            title: 'Datalogic 25',
            value: _isBarcodeTypeSelected(BarcodeType.datalogic25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.datalogic25, newValue);
            },
          ),
          CustomSwitch(
            title: 'COOP 25',
            value: _isBarcodeTypeSelected(BarcodeType.coop25),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.coop25, newValue);
            },
          ),
          CustomSwitch(
            title: 'Telepen',
            value: _isBarcodeTypeSelected(BarcodeType.telepen),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.telepen, newValue);
            },
          ),
          CustomSwitch(
            title: 'UPC-A',
            value: _isBarcodeTypeSelected(BarcodeType.upcA),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.upcA, newValue);
            },
          ),
          CustomSwitch(
            title: 'UPC-E',
            value: _isBarcodeTypeSelected(BarcodeType.upcE),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.upcE, newValue);
            },
          ),
          CustomSwitch(
            title: 'UPC-E1',
            value: _isBarcodeTypeSelected(BarcodeType.upcE1),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.upcE1, newValue);
            },
          ),
          CustomSwitch(
            title: 'EAN-13',
            value: _isBarcodeTypeSelected(BarcodeType.ean13),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.ean13, newValue);
            },
          ),
          CustomSwitch(
            title: 'EAN-8',
            value: _isBarcodeTypeSelected(BarcodeType.ean8),
            onChanged: (bool newValue) {
              _toggleBarcodeType(BarcodeType.ean8, newValue);
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
