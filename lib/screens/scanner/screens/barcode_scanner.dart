import 'package:barkoder/screens/settings/1d_barcodes/one_industrial.dart';
import 'package:barkoder/screens/settings/1d_barcodes/one_retail.dart';
import 'package:barkoder/screens/settings/1d_barcodes/one_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/dot_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/pdf_settings.dart';
import 'package:barkoder/screens/settings/2d_barcodes/two_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/all_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/deblur_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/dpm_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/misshaped_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/multi_settings.dart';
import 'package:barkoder/screens/settings/showcase_barcodes/vin_settings.dart';
import 'package:barkoder/utils/barcode_types.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:barkoder/screens/settings/settings_screen.dart';
import 'package:barkoder/screens/scanner/widgets/scanned_barcode_info.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'package:flutter/material.dart';

class BarcodeScanner extends StatefulWidget {
  final List<BarcodeType> barcodeTypes;
  final bool autoStart;
  final bool allowPinchToZoom;
  final bool allowBeep;
  final bool allowVibrate;
  final DecodingSpeed changeSpeed;
  final BarkoderResolution changeResolution;
  final FormattingType changeFormatting;
  final String changeCharset;
  final bool continuousScanning;
  final bool misshaped;
  final bool blurredUPC;
  final int continuousThreshold;
  final bool showBottomsheet;
  final bool regionOfInterest;
  final bool locationPreview;
  final String settings;

  const BarcodeScanner({
    super.key,
    required this.barcodeTypes,
    this.autoStart = true,
    this.allowPinchToZoom = false,
    this.allowBeep = true,
    this.allowVibrate = true,
    this.changeSpeed = DecodingSpeed.normal,
    this.changeResolution = BarkoderResolution.normal,
    this.changeFormatting = FormattingType.disabled,
    this.changeCharset = 'Not set',
    this.continuousScanning = false,
    this.misshaped = false,
    this.blurredUPC = false,
    this.continuousThreshold = 5,
    this.showBottomsheet = true,
    this.regionOfInterest = false,
    this.locationPreview = true,
    this.settings = 'default',
  });

  @override
  BarcodeScannerState createState() => BarcodeScannerState();
}

class BarcodeScannerState extends State<BarcodeScanner> with WidgetsBindingObserver {
  Barkoder? _barkoder;
  final List<BarkoderResult> _scannedResults = [];
  BarkoderResult? _lastScannedResult;
  bool isScanning = false;
  bool _flashEnabled = false;
  double _zoomFactor = 1.0;
  int _scannedCount = 0;

  static final List<Map<String, String>> recentScans = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _barkoder?.stopScanning();
    _lastScannedResult = null;
    _scannedResults.clear();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.paused) {
      _barkoder?.stopScanning(); // Stop scanning when app goes to background
    } else if (state == AppLifecycleState.resumed) {
      if (isScanning) {
        _startScanning(); // Resume scanning when app comes to foreground
      }
    }
  }

  void _onBarkoderViewCreated(Barkoder barkoder) {
    _barkoder = barkoder;

    // Set common settings
    _barkoder!.setRegionOfInterest(5, 5, 90, 90);
    _barkoder!.setRegionOfInterestVisible(widget.regionOfInterest);
    _barkoder!.setCloseSessionOnResultEnabled(false);
    _barkoder!.setImageResultEnabled(!(widget.continuousScanning));
    _barkoder!.setBarcodeThumbnailOnResultEnabled(true);
    _barkoder!.setBeepOnSuccessEnabled(widget.allowBeep);
    _barkoder!.setVibrateOnSuccessEnabled(widget.allowVibrate);
    _barkoder!.setPinchToZoomEnabled(widget.allowPinchToZoom);
    _barkoder!.setZoomFactor(1.0);
    _barkoder!.setFlashEnabled(false);
    _barkoder!.setDecodingSpeed(widget.changeSpeed);
    _barkoder!.setBarkoderResolution(widget.changeResolution);
    _barkoder!.setFormattingType(widget.changeFormatting);
    _barkoder!.setEncodingCharacterSet('Not set');
    _barkoder!.setMisshaped1DEnabled(widget.misshaped);
    _barkoder!.setUpcEanDeblurEnabled(widget.blurredUPC);
    _barkoder!.setLocationInPreviewEnabled(widget.locationPreview);
    _barkoder!.setThresholdBetweenDuplicatesScans(widget.continuousThreshold);

    // Apply selected barcode types
    for (var barcodeType in widget.barcodeTypes) {
      _barkoder!.setBarcodeTypeEnabled(barcodeType, true);
    }

    if (widget.autoStart) {
      _startScanning();
    }
  }

  void _startScanning() {
    setState(() {
      _scannedResults.clear();
      isScanning = true;
      _scannedCount = 0;
    });

    _barkoder!.startScanning((result) {
      setState(() {
        _lastScannedResult = result;
        _scannedResults.add(result);
        isScanning = false;
        _scannedCount++;

        recentScans.add({
          'name': result.textualData,
          'type': result.barcodeType.toString().split('.').last,
        });
      });
    });
  }

  void _toggleFlashlight() {
    setState(() {
      _flashEnabled = !_flashEnabled;
      _barkoder!.setFlashEnabled(_flashEnabled);
    });
  }

  void _zoomIn() {
    setState(() {
      _zoomFactor = _zoomFactor == 1.0 ? 2.0 : 1.0;
      _barkoder!.setZoomFactor(_zoomFactor);
    });
  }

  void _openSettings() {
    Widget settingsPage;

    switch (widget.settings) {
      case '1d':
        settingsPage = OneDSettingsPage(selectedBarcodeTypes: get1D());
        break;
      case 'industrial':
        settingsPage = IndustrialSettingsPage(selectedBarcodeTypes: getIndustrial());
        break;
      case 'retail':
        settingsPage = RetailSettingsPage(selectedBarcodeTypes: getRetail());
        break;
      case '2d':
        settingsPage = TwoDSettingsPage(selectedBarcodeTypes: get2D());
        break;
      case 'pdf':
        settingsPage = PdfSettingsPage(selectedBarcodeTypes: getPDF417());
        break;
      case 'dot':
        settingsPage = DotSettingsPage(selectedBarcodeTypes: getDotCode());
        break;
      case 'multi':
        settingsPage = MultiSettingsPage(selectedBarcodeTypes: getMultiScan());
        break;
      case 'dpm':
        settingsPage = DpmSettingsPage(selectedBarcodeTypes: getDPM());
        break;
      case 'vin':
        settingsPage = VinSettingsPage(selectedBarcodeTypes: getVIN());
        break;
      case 'deblur':
        settingsPage = DeblurSettingsPage(selectedBarcodeTypes: getDeblur());
        break;
      case 'miss':
        settingsPage = MissSettingsPage(selectedBarcodeTypes: getMisshaped());
        break;
      case 'all':
        settingsPage = AllSettingsPage(selectedBarcodeTypes: getAll());
        break;        
      default:
        settingsPage = const SettingsPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => settingsPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BarkoderView(
              licenseKey: 'YOUR_LICENSE_KEY',
              onBarkoderViewCreated: _onBarkoderViewCreated,
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: IconButton(
              padding: const EdgeInsets.only(top: 32.0),
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: IconButton(
              padding: const EdgeInsets.only(top: 32.0),
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                _openSettings();
              },
            ),
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/logos/bkdr-logo.png',
                ),
              ),
            ),
          ),
          if (_scannedResults.isNotEmpty)
            Positioned(
              top: 100.0,
              left: 60.0,
              right: 0.0,
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: _scannedResults.asMap().entries.map((entry) {
                    BarkoderResult result = entry.value;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${result.barcodeType.toString().split('.').last}: ',
                          style: const TextStyle(
                              color: AppColor.mainRed, fontSize: 14.0),
                        ),
                        Text(
                          result.textualData,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Text(
                  'Scanning: ${widget.barcodeTypes.map((type) => type.toString().split('.').last).join(', ')}',
                  style: const TextStyle(color: Colors.white, fontSize: 11.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _toggleFlashlight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _flashEnabled
                              ? AppColor.mainRed
                              : Colors.transparent,
                          border:
                              Border.all(color: AppColor.mainRed, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                            _flashEnabled
                                ? Icons.flashlight_off
                                : Icons.flashlight_on,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: _zoomIn,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _zoomFactor == 2.0
                              ? AppColor.mainRed
                              : Colors.transparent,
                          border:
                              Border.all(color: AppColor.mainRed, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                            _zoomFactor == 2.0 ? Icons.zoom_out : Icons.zoom_in,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_lastScannedResult != null && widget.showBottomsheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ScannedBarcodeInfo(
                barcodeResult: _lastScannedResult!,
                scannedCount: _scannedCount, 
                showCount: true,
                showImage: true,
              ),
            ),
        ],
      ),
    );
  }
}
