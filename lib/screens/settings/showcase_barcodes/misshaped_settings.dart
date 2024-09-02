import 'package:barkoder/screens/settings/settings_widgets/list_tile_radio.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/base_functions/base_functions.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/screens/settings/settings_widgets/switch.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class MissSettingsPage extends StatefulWidget {
  final List<BarcodeType> selectedBarcodeTypes;

  const MissSettingsPage({super.key, required this.selectedBarcodeTypes});

  @override
  MissSettingsPageState createState() => MissSettingsPageState();
}

class MissSettingsPageState extends State<MissSettingsPage> {
  List<BarcodeType> selectedBarcodeTypes = getMisshaped();
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
    selectedBarcodeTypes = await _baseSettings.loadBarcodeTypes('selectedMissBarcodeTypes', getMisshaped());
    _allowPinchToZoom = await _baseSettings.loadAllowPinchToZoomSetting('allowPinchToZoomMiss');
    _allowBeep = await _baseSettings.loadBeepSetting('allowBeepMiss');
    _allowVibrate = await _baseSettings.loadVibrateSetting('allowVibrateMiss');
    _formating = await _baseSettings.loadFormatingSetting('formatingMiss');
    _charset = await _baseSettings.loadCharsetSetting('charsetMiss');
    _allowContinuousScanning = await _baseSettings.loadAllowContinuousScanning('continuousScanningMiss');
    _showBottomsheet = await _baseSettings.loadShowBottomsheet('bottomsheetMiss');
    setState(() {});
  }

  void _saveSettings() {
    _baseSettings.saveBarcodeTypes('selectedMissBarcodeTypes', selectedBarcodeTypes);
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomMiss', _allowPinchToZoom);
    _baseSettings.saveBeepSetting('allowBeepMiss', _allowBeep);
    _baseSettings.saveVibrateSetting('allowVibrateMiss', _allowVibrate);
    _baseSettings.saveFormatingSetting('formatingMiss', _formating);
    _baseSettings.saveCharsetSetting('charsetMiss', _charset);
    _baseSettings.saveAllowContinuousScanning('continuousScanningMiss', _allowContinuousScanning);
    _baseSettings.saveShowBottomsheet('bottomsheetMiss', _showBottomsheet);
  }

  void _resetSettings() {
    setState(() {
      selectedBarcodeTypes = getMisshaped();
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
    _baseSettings.saveAllowPinchToZoomSetting('allowPinchToZoomMiss', value);
  }

  void _toggleBeep(bool value) {
    setState(() {
      _allowBeep = value;
    });
    _baseSettings.saveBeepSetting('allowBeepMiss', value);
  }

  void _toggleVibrate(bool value) {
    setState(() {
      _allowVibrate = value;
    });
    _baseSettings.saveVibrateSetting('allowVibrateMiss', value);
  }

  void _toggleFormating(FormattingType formating) {
    setState(() {
      _formating = formating;
    });
    _baseSettings.saveFormatingSetting('formatingMiss', formating);
  }

  void _toggleCharset(String charset) {
    setState(() {
      _charset = charset;
    });
    _baseSettings.saveCharsetSetting('charsetMiss', charset);
  }

  void _toggleContinuousScanning(bool value) {
    setState(() {
      _allowContinuousScanning = value;
    });
    _baseSettings.saveAllowContinuousScanning('continuousScanningMiss', value);
  }

  void _toggleShowBottomsheet(bool value) {
    setState(() {
      _showBottomsheet = value;
    });
    _baseSettings.saveShowBottomsheet('bottomsheetMiss', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Misshaped',
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
            title: 'Continuous Scanning',
            value: false,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Allow pinch to zoom',
            value: false,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Beep on success',
            value: true,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Vibrate on success',
            value: true,
            onChanged: (bool newValue) {},
          ),
          CustomSwitch(
            title: 'Scan Deformed Codes - Segment Decoding',
            value: false,
            onChanged: (bool newValue) {},
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