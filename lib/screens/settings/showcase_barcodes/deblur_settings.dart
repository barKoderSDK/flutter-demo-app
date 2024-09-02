import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class DeblurSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const DeblurSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  DeblurSettingsPageState createState() => DeblurSettingsPageState();
}

class DeblurSettingsPageState extends State<DeblurSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = getDeblur();
  bool _allowPinchToZoom = false;
  bool _allowBeep = true;
  bool _allowVibrate = true;
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
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selectedDeblurBarcodeTypes', getDeblur());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoomDeblur');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeepDeblur');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrateDeblur');
    _formating = await _baseSettings.loadFormatingSetting('formatingDeblur');
    _charset = await _baseSettings.loadCharsetSetting('charsetDeblur');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanningDeblur');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheetDeblur');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selectedDeblurBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomDeblur', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeepDeblur', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrateDeblur', _allowVibrate);
    _baseSettings.saveFormatingSetting('formatingDeblur', _formating);
    _baseSettings.saveCharsetSetting('charsetDeblur', _charset);
    _baseSettings.saveAllowContinuousScanning('continuousScanningDeblur', _allowContinuousScanning);
    _baseSettings.saveShowBottomsheet('bottomsheetDeblur', _showBottomsheet);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = getDeblur();
      _allowPinchToZoom = false;
      _allowBeep = true;
      _allowVibrate = true;
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
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomDeblur', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeepDeblur', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrateDeblur', value);
  }

  void _toggleFormating(FormattingType formating) {
    setState(() {
      _formating = formating;
    });
    _baseSettings.saveFormatingSetting('formatingDeblur', formating);
  }

  void _toggleCharset(String charset) {
    setState(() {
      _charset = charset;
    });
    _baseSettings.saveCharsetSetting('charsetDeblur', charset);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanningDeblur', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheetDeblur', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deblur',
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